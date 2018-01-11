use "debug"
use "websocket"

class BroadcastListenNotify is WebSocketListenNotify
  // Store a local peerlist that we can modify.
  var _peerlist: PeerList = PeerList.create()

  // Triggered when the socket cannot be opened.
  fun ref not_listening() =>
    @printf[I32]("Failed to listen to the provided socket\n".cstring())

  fun ref connected(): BroadcastConnectionNotify iso^ =>
    BroadcastConnectionNotify(_peerlist)

class BroadcastConnectionNotify is WebSocketConnectionNotify
  var _peerlist: PeerList

  // XXX: Do I need iso for peerlist?
  new iso create(peerlist: PeerList) =>
    _peerlist = peerlist

  // New peer connection.
  fun ref opened(conn: WebSocketConnection tag) =>
    _peerlist.add(conn)

  // Peer closed connection.
  fun ref closed(conn: WebSocketConnection tag) =>
    _peerlist.remove(conn)

  // Received text message.
  fun ref text_received(conn: WebSocketConnection tag, text: String) =>
    // Handle a partial.
    try
      let fmt_text = WireProto.pretty_print(text)? as String
      Debug.out("text_received: " + fmt_text + "\n")

      let command: String = WireProto.get_command(text)? as String
      _peerlist.broadcast_text(text)
    end

  // Received binary data.
  // Generally ignore as the gun communications are all JSON.
  fun ref binary_received(conn: WebSocketConnection tag, data: Array[U8] val) =>
    Debug.out("binary_received: " + data.size().string())
