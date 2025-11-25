# BITS Auto Campnet
Auto login to https://campnet.bits-goa.ac.in:8090/httpclient.html  
Checks `http://captive.apple.com` every 5s

## Running

Set `SOPHOS_USERNAME` and `SOPHOS_PASSWORD` in `.env`.

```env
SOPHOS_USERNAME=yourusername
SOPHOS_PASSWORD=yourpassword
```

### 1. Shell script

Download

```sh
curl -fsSLO https://raw.githubusercontent.com/khrj/bits-auto-campnet/refs/heads/main/auto-campnet.sh
```

Run

```sh
bash auto-campnet.sh
```

### 2. Docker container

Start

```sh
docker compose up
```

Stop

```sh
docker compose down
```
