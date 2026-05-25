# ppsspp-web

Web shell and local server for the PPSSPP WebAssembly build.

This repository contains:

- `wasm-page/`: browser UI, service worker, manifest, and icons.
- `server/`: HTTPS server with COOP/COEP headers and the browser ad hoc WebSocket relay.

The emulator source and WebAssembly build outputs live in the sibling `ppsspp-wasm`
repository.

## Local Run

Build PPSSPP from the sibling repository first:

```sh
cd ../ppsspp-wasm
make wasm-dev
```

Then serve it from this repository:

```sh
make serve
```

By default the server reads `../ppsspp-wasm/build-wasm/` and
`../ppsspp-wasm/build-wasm-release/`. Use `WASM_ROOT=/path/to/ppsspp-wasm`
if the checkout lives somewhere else.

## Docker

```sh
make server-docker-up
```

The compose file mounts `../ppsspp-wasm` read-only at `/wasm`.
