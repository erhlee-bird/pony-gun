use "collections"
use "websocket"

actor PeerList
  var _peers: SetIs[WebSocketConnection] =
    SetIs[WebSocketConnection].create()

  be add(conn: WebSocketConnection) =>
    @printf[I32]("Add peer\n".cstring())
    _peers.set(conn)

  be remove(conn: WebSocketConnection) =>
    @printf[I32]("Remove peer\n".cstring())
    _peers.unset(conn)

  be broadcast_text(text: String) =>
    for peer in _peers.values() do
      peer.send_text(text)
    end
