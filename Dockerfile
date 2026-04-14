FROM erlang:27-alpine
ARG TARGETARCH
WORKDIR /app
RUN apk add --no-cache bash curl tar gzip rebar3
RUN case "$TARGETARCH" in \
      amd64) arch="x86_64" ;; \
      arm64) arch="aarch64" ;; \
      *) echo "unsupported TARGETARCH: $TARGETARCH" >&2; exit 1 ;; \
    esac \
    && curl -fsSL "https://github.com/gleam-lang/gleam/releases/download/v1.15.4/gleam-v1.15.4-${arch}-unknown-linux-musl.tar.gz" \
    | tar -xz -C /usr/local/bin gleam
COPY gleam.toml ./
COPY src ./src
COPY test ./test
RUN gleam deps download
RUN gleam format --check src test
RUN gleam test
ENTRYPOINT ["gleam", "run", "--"]
