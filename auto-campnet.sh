#!/bin/sh

CAPTIVE_URL="http://captive.apple.com/?ts="
SUCCESS_STRING="<HTML><HEAD><TITLE>Success</TITLE></HEAD><BODY>Success</BODY></HTML>"
LOGIN_URL="https://campnet.bits-goa.ac.in:8090/login.xml"

# Load .env file
if [ -f .env ]; then
    # shellcheck disable=SC2046
    set -a
    . ./.env
    set +a
fi

if [ -z "$SOPHOS_USERNAME" ]; then
    echo "No username. Set SOPHOS_USERNAME in .env"
    exit 1
fi

if [ -z "$SOPHOS_PASSWORD" ]; then
    echo "No password. Set SOPHOS_PASSWORD in .env"
    exit 1
fi

while true; do
    echo "Checking..."
    
    TS=$(date +%s)
    RESP=$(curl -s --max-time 1 "${CAPTIVE_URL}${TS}")

    # Check if response contains success string using case (glob matching)
    case "$RESP" in
        *"Success</BODY></HTML>"*)
            echo "OK"
            ;;
        *)
            echo "Not logged in."
        LOGIN_RESP=$(curl -s -X POST "$LOGIN_URL" \
            -d "mode=191" \
            -d "producttype=0" \
            -d "username=$SOPHOS_USERNAME" \
            -d "password=$SOPHOS_PASSWORD")
        
        # Check for successful login in the XML response if needed, 
        # or just rely on the next loop iteration to verify connectivity.
        # The original script checked for status 200. curl exits 0 on HTTP errors unless -f is used, 
        # but we can check the output.
        
        echo "Login attempt made. Response: $LOGIN_RESP"
    esac

    sleep 5
done
