FROM alpine:3.21

# Create app directory
WORKDIR /usr/src/app

RUN apk add --no-cache deno

# Bundle app source
COPY auto-campnet.ts deno.json deno.lock ./

WORKDIR /usr/src/app

# Run
CMD ["deno", "run", "--allow-net", "--allow-read", "--allow-env", "auto-campnet.ts" ]
