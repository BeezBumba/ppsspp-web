.PHONY: serve server-docker-up server-docker-down server-docker-logs

WASM_ROOT ?= ../ppsspp-wasm
BIND ?= 192.168.1.170
PORT ?= 8081

serve:
	python3 server/serve.py --https --wasm-root $(WASM_ROOT) --bind $(BIND) --port $(PORT) --adhoc-ws

server-docker-up:
	docker compose up --build ppsspp-wasm-server

server-docker-down:
	docker compose down

server-docker-logs:
	docker compose logs -f ppsspp-wasm-server
