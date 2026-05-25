# ppsspp-web

Web shell and local server for the PPSSPP WebAssembly build.

This repository contains:

- `wasm-page/`: browser UI, service worker, manifest, and icons.
- `server/`: HTTPS server with COOP/COEP headers and the browser ad hoc WebSocket relay.

The emulator source and WebAssembly build outputs live in the `deps/ppsspp-wasm`
submodule.

## Checkout

Clone with submodules:

```sh
git clone --recurse-submodules https://github.com/root-hunter/ppsspp-web.git
```

For an existing checkout:

```sh
git submodule update --init --recursive
```

## Local Run

Build PPSSPP from the submodule first:

```sh
cd deps/ppsspp-wasm
make wasm-dev
```

Then serve it from this repository:

```sh
make serve
```

By default the server reads `deps/ppsspp-wasm/build-wasm/` and
`deps/ppsspp-wasm/build-wasm-release/`. Use `WASM_ROOT=/path/to/ppsspp-wasm`
if the checkout lives somewhere else.

## Docker

```sh
make server-docker-up
```

The compose file mounts `./deps/ppsspp-wasm` read-only at `/wasm`.

## GitHub Pages

The Pages workflow builds `deps/ppsspp-wasm` with Emscripten, copies the web
shell from `wasm-page/`, and publishes the complete app to GitHub Pages.
