.PHONY: wasm-release serve server-docker-up server-docker-down server-docker-logs wasm-submodules

WASM_ROOT ?= deps/ppsspp-wasm
BIND ?= 192.168.1.170
PORT ?= 8081
CMAKE ?= $(or $(wildcard /usr/bin/cmake),cmake)
WASM_JOBS ?= -j

wasm-release: wasm-submodules
	git config --global --add safe.directory "$(abspath $(WASM_ROOT))" || true
	$(MAKE) -C $(WASM_ROOT) wasm-release CMAKE=$(CMAKE) WASM_JOBS="$(WASM_JOBS)"
	rm -rf build-wasm-release assets
	ln -s $(WASM_ROOT)/build-wasm-release build-wasm-release
	mkdir -p assets
	cp -a $(WASM_ROOT)/assets/. assets/

serve:
	python3 server/serve.py --https --wasm-root $(WASM_ROOT) --bind $(BIND) --port $(PORT) --adhoc-ws

server-docker-up:
	docker compose up --build ppsspp-wasm-server

wasm-submodules:
	git submodule update --init --recursive

server-docker-down:
	docker compose down

server-docker-logs:
	docker compose logs -f ppsspp-wasm-server
