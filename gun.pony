use "websocket"
use "src"

actor Main
  new create(env: Env) =>
    try
      let listener = WebSocketListener(
        env.root as AmbientAuth,
        BroadcastListenNotify,
        "127.0.0.1",
        "10000")
    end
