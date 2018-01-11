use "json"

// Design WireProto as a primitive for the initial attempt.
// WireProto is an oracle to interact with Json messages transparently.

primitive WireProto
  fun _to_json(text: String): JsonObject ? =>
    var doc: JsonDoc = JsonDoc
    doc.parse(text) ?
    doc.data as JsonObject

  fun pretty_print(obj: JsonObject): String ? =>
    obj.string(where indent = "  ", pretty_print = true)

  fun pretty_print(obj: String): String ? =>
    pretty_print(_to_json(obj) ?) ?

  fun get_command(obj: JsonObject): String ? =>
    if obj.data.contains("put") then
      "put"
    elseif obj.data.contains("get") then
      "get"
    else
      // No valid commands found.
      error
    end

  fun get_command(obj: String): String ? =>
    get_command(_to_json(obj) ?) ?
