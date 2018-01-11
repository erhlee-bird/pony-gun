pony-gun
===
Implementation of a gun.js server in Pony-lang.

Getting Started
===
```
ponyc stable fetch
make
```

Testing
===
Open up a new browser and run the following in the console.

```
var ws = new WebSocket('ws://localhost:10000');
ws.onopen = function(o) { console.log('open', o) };
ws.onclose = function(c) { console.log('close', c) };
ws.onmessage = function(m) { console.log('message', m) };
ws.onerror = function(e) { console.log('error', e) };

ws.send(JSON.stringify({put: {test: "whoo!"}}))
```
