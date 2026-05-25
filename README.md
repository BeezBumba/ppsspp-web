# ppsspp-web

Web shell and local server for the PPSSPP WebAssembly build.

This repository contains:

- `wasm-page/`: browser UI, service worker, manifest, and icons.
- `server/`: HTTPS server with COOP/COEP headers and the browser ad hoc WebSocket relay.

The emulator source and WebAssembly build outputs live in `deps/ppsspp-wasm`,
the pinned Git submodule used for reproducible checkouts and local development.
If you temporarily want to use a separate checkout, override
`WASM_ROOT=/path/to/ppsspp-wasm`.

## Checkout

Clone with submodules:

```sh
git clone --recurse-submodules https://github.com/root-hunter/ppsspp-web.git
```

For an existing checkout:

```sh
git submodule update --init --recursive
```

Or use the Makefile wrapper:

```sh
make wasm-submodules
```

## Local Run

Build PPSSPP from the active `WASM_ROOT` first:

```sh
make wasm-dev
```

Then serve it from this repository:

```sh
make serve
```

By default the server reads `deps/ppsspp-wasm/build-wasm/` and
`deps/ppsspp-wasm/build-wasm-release/`. Use
`WASM_ROOT=/path/to/ppsspp-wasm` if the checkout lives somewhere else.

Useful local-development shortcuts:

```sh
make wasm-status
make wasm-submodule-branch
make wasm-dev
make serve
```

To update the pinned submodule to the latest `origin/wasm`:

```sh
make wasm-submodule-update
git diff --submodule
```

To pin `ppsspp-web` to the current committed HEAD of a separate sibling
`../ppsspp-wasm` checkout, when you are using one:

```sh
make wasm-pin-local
git diff --submodule
```

Push the `ppsspp-wasm` commit before sharing the `ppsspp-web` submodule pointer,
otherwise other machines will not be able to fetch it.

## Docker

```sh
make server-docker-up
```

The compose file mounts `WASM_ROOT` read-only at `/wasm`. For the sibling local
checkout:

```sh
make server-docker-up-local
```

## GitHub Pages

The Pages workflow builds `deps/ppsspp-wasm` with Emscripten, copies the web
shell from `wasm-page/`, and publishes the complete app to GitHub Pages.
