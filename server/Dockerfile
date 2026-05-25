FROM python:3.13-slim

RUN apt-get update \
	&& apt-get install -y --no-install-recommends openssl \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY server/serve.py ./server/serve.py
COPY wasm-page ./wasm-page

WORKDIR /app/server

EXPOSE 8081 27312

CMD ["python3", "serve.py", "--https", "--bind", "0.0.0.0", "--port", "8081", "--wasm-root", "/wasm", "--adhoc-ws"]
