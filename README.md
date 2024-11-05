# BITS Auto Campnet
Auto login to https://campnet.bits-goa.ac.in:8090/httpclient.html
- Fork of https://github.com/khrj/bits-wifi-autologin/  
- CLI variant of https://github.com/Devsoc-BPGC/auto-campnet

Checks `http://captive.apple.com` every 5s

## Running

[Download auto-campnet](https://github.com/khrj/bits-auto-campnet/releases) or install via deno:

```sh
deno install -g --allow-net --allow-read --allow-env https://raw.githubusercontent.com/khrj/bits-auto-campnet/refs/heads/main/auto-campnet.ts
```

Set `SOPHOS_USERNAME` and `SOPHOS_PASSWORD` in `.env`.

```env
SOPHOS_USERNAME=yourusername
SOPHOS_PASSWORD=yourpassword
```

then run

```sh
auto-campnet
```

## Development

```sh
deno run --allow-net --allow-read --allow-env auto-campnet.ts
```

```sh
deno compile --allow-net --allow-read --allow-env auto-campnet.ts
```
