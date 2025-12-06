import { afterAll, afterEach, beforeAll, describe, expect, it } from "bun:test";
import WebSocket from "ws";
import { startSocketServer } from "./socket";

const waitForMessage = <T = any>(
  ws: WebSocket,
  predicate: (msg: T) => boolean,
  timeout = 3000
): Promise<T> => {
  return new Promise((resolve, reject) => {
    const timer = setTimeout(() => {
      ws.off("message", handler);
      reject(new Error("Timed out waiting for message"));
    }, timeout);

    const handler = (data: WebSocket.RawData) => {
      try {
        const parsed = JSON.parse(data.toString());
        if (predicate(parsed)) {
          clearTimeout(timer);
          ws.off("message", handler);
          resolve(parsed);
        }
      } catch (err) {
        clearTimeout(timer);
        ws.off("message", handler);
        reject(err);
      }
    };

    ws.on("message", handler);
  });
};

const joinChannel = async (ws: WebSocket, channel: string) => {
  ws.send(JSON.stringify({ type: "join", channel, id: `join-${Date.now()}` }));
  await waitForMessage(
    ws,
    (msg) => msg.type === "system" && msg.channel === channel
  );
};

const openSocket = (url: string) =>
  new Promise<WebSocket>((resolve, reject) => {
    const client = new WebSocket(url);
    client.on("open", () => resolve(client));
    client.on("error", (err) => reject(err));
  });

describe("socket server", () => {
  let server: ReturnType<typeof startSocketServer> | null = null;
  let clientA: WebSocket | null = null;
  let clientB: WebSocket | null = null;
  let socketUrl = "";

  beforeAll(() => {
    server = startSocketServer({ port: 0, host: "127.0.0.1" });
    socketUrl = `ws://127.0.0.1:${server.port}`;
  });

  afterEach(async () => {
    clientA?.close();
    clientB?.close();
    await new Promise((r) => setTimeout(r, 50));
    clientA = null;
    clientB = null;
  });

  afterAll(async () => {
    if (server?.stop) {
      await server.stop();
    }
  });

  it("broadcasts commands to peers in the same channel", async () => {
    clientA = await openSocket(socketUrl);
    clientB = await openSocket(socketUrl);
    await joinChannel(clientA, "test-channel");
    await joinChannel(clientB, "test-channel");

    const received = waitForMessage(
      clientB,
      (msg) =>
        msg.type === "broadcast" &&
        msg.channel === "test-channel" &&
        msg.message?.command === "ping"
    );

    clientA.send(
      JSON.stringify({
        type: "message",
        channel: "test-channel",
        message: { id: "1", command: "ping" },
      })
    );

    const payload = await received;
    expect(payload.message.command).toBe("ping");
  });

  it("delivers peer responses back to the original sender", async () => {
    clientA = await openSocket(socketUrl);
    clientB = await openSocket(socketUrl);
    await joinChannel(clientA, "roundtrip");
    await joinChannel(clientB, "roundtrip");

    const roundTrip = waitForMessage(
      clientA,
      (msg) =>
        msg.type === "broadcast" &&
        msg.channel === "roundtrip" &&
        msg.message?.result === "pong"
    );

    clientB.send(
      JSON.stringify({
        type: "message",
        channel: "roundtrip",
        message: { id: "42", result: "pong" },
      })
    );

    const payload = await roundTrip;
    expect(payload.message.result).toBe("pong");
  });
});

