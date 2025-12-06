import { Server, ServerWebSocket } from "bun";

function log(category: string, action: string, details: string) {
  // Use stderr (console.error) to avoid polluting MCP stdio on stdout
  console.error(`[Figma] [${category}] [${action}] ${details}`);
}

function logError(action: string, details: string) {
  console.error(`[Figma] [Error] ${action} ${details}`);
}

type ChannelMap = Map<string, Set<ServerWebSocket<any>>>;

type SocketOptions = {
  port?: number;
  host?: string;
};

function sendJson(ws: ServerWebSocket<any>, payload: unknown) {
  if (ws.readyState === WebSocket.OPEN) {
    ws.send(JSON.stringify(payload));
  }
}

export function startSocketServer(options: SocketOptions = {}) {
  const port = options.port ?? Number(process.env.PORT || 3055);
  const hostname = options.host ?? process.env.HOST ?? undefined;
  const channels: ChannelMap = new Map();

  // Track channel and keep-alive timer per connection
  const connectionMeta = new WeakMap<ServerWebSocket<any>, {
    channel?: string;
    keepAlive?: ReturnType<typeof setInterval>;
  }>();

  const handleConnection = (ws: ServerWebSocket<any>) => {
    log("Connection", "Connected", "New client connected");
    sendJson(ws, {
      type: "system",
      message: "Please join a channel to start chatting",
    });

    // Lightweight ping to keep connections from idling out silently
    const keepAlive = setInterval(() => {
      if (ws.readyState === WebSocket.OPEN) {
        sendJson(ws, { type: "ping", ts: Date.now() });
      }
    }, 30000);

    connectionMeta.set(ws, { keepAlive });
  };

  const cleanupConnection = (ws: ServerWebSocket<any>) => {
    const meta = connectionMeta.get(ws);
    if (meta?.keepAlive) {
      clearInterval(meta.keepAlive);
    }

    channels.forEach((clients, channelName) => {
      if (clients.has(ws)) {
        clients.delete(ws);
        clients.forEach((client) => {
          sendJson(client, {
            type: "system",
            message: "A user has left the channel",
            channel: channelName
          });
        });
      }
    });
  };

  const server = Bun.serve({
    port,
    hostname,
    fetch(req: Request, server: Server) {
      if (req.method === "OPTIONS") {
        return new Response(null, {
          headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
            "Access-Control-Allow-Headers": "Content-Type, Authorization",
          },
        });
      }

      const success = server.upgrade(req, {
        headers: {
          "Access-Control-Allow-Origin": "*",
        },
      });

      if (success) {
        return;
      }

      return new Response("WebSocket server running", {
        headers: {
          "Access-Control-Allow-Origin": "*",
        },
      });
    },
    websocket: {
      open: handleConnection,
      message(ws: ServerWebSocket<any>, message: string | Buffer) {
        try {
          const data = JSON.parse(message as string);
          log("Connection", "Message received", `Type=${data.type}, Channel=${data.channel || "N/A"}`);
          if (data.message?.command) {
            log("Connection", "Command", `Command=${data.message.command}, ID=${data.id}`);
          } else if (data.message?.result) {
            log("Connection", "Response", `ID=${data.id}, HasResult=${!!data.message.result}`);
          }
          log("Connection", "Payload", JSON.stringify(data));

          if (data.type === "join") {
            const channelName = data.channel;
            if (!channelName || typeof channelName !== "string") {
              sendJson(ws, {
                type: "error",
                message: "Channel name is required"
              });
              return;
            }

            if (!channels.has(channelName)) {
              channels.set(channelName, new Set());
            }

            const channelClients = channels.get(channelName)!;
            channelClients.add(ws);
            const meta = connectionMeta.get(ws) || {};
            connectionMeta.set(ws, { ...meta, channel: channelName });

            log("Channel", "Joined", `"${channelName}" (${channelClients.size} clients)`);

            sendJson(ws, {
              type: "system",
              message: `Joined channel: ${channelName}`,
              channel: channelName
            });

            sendJson(ws, {
              type: "system",
              message: {
                id: data.id,
                result: "Connected to channel: " + channelName,
              },
              channel: channelName
            });

            channelClients.forEach((client) => {
              if (client !== ws && client.readyState === WebSocket.OPEN) {
                sendJson(client, {
                  type: "system",
                  message: "A new user has joined the channel",
                  channel: channelName
                });
              }
            });
            return;
          }

          if (data.type === "message") {
            const channelName = data.channel;
            if (!channelName || typeof channelName !== "string") {
              sendJson(ws, {
                type: "error",
                message: "Channel name is required"
              });
              return;
            }

            const channelClients = channels.get(channelName);
            if (!channelClients || !channelClients.has(ws)) {
              sendJson(ws, {
                type: "error",
                message: "You must join the channel first"
              });
              return;
            }

            let broadcastCount = 0;
            channelClients.forEach((client) => {
              if (client !== ws && client.readyState === WebSocket.OPEN) {
                broadcastCount++;
                const broadcastMessage = {
                  type: "broadcast",
                  message: data.message,
                  sender: "peer",
                  channel: channelName
                };
                log("Connection", "Broadcast", `Peer #${broadcastCount} in channel "${channelName}"`);
                log("Connection", "Broadcast payload", JSON.stringify(broadcastMessage));
                sendJson(client, broadcastMessage);
              }
            });
            
            if (broadcastCount === 0) {
              log("Connection", "Broadcast skipped", `No peers in channel "${channelName}"`);
            } else {
              log("Connection", "Broadcast sent", `${broadcastCount} peer(s) in channel "${channelName}"`);
            }
          }
        } catch (err) {
          logError("Message handling failed:", String(err));
        }
      },
      close(ws: ServerWebSocket<any>) {
        cleanupConnection(ws);
      }
    }
  });

  log(
    "Connection",
    "Status",
    `WebSocket server running on port ${server.port}${hostname ? ` (host: ${hostname})` : ""}`
  );
  return server;
}

if (import.meta.main) {
  startSocketServer();
}
