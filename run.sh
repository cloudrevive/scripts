#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
FILE="certs/server.crt"

if [ -e "$FILE" ]; then
    EXPIRATION_DATE=$(openssl x509 -enddate -noout -in certs/server.crt | cut -d= -f2)
    EXPIRATION_DATE_SECONDS=$(date -d "$EXPIRATION_DATE" +%s)
    CURRENT_DATE_SECONDS=$(date +%s)
    if [ "$CURRENT_DATE_SECONDS" -ge "$EXPIRATION_DATE_SECONDS" ]; then
        echo "The certificate has expired."
    else
        bash ./gen-ssl.sh
    fi
else
    bash ./gen-ssl.sh
fi

docker kill agent || true
docker rm agent || true
docker pull registry.metal8.cloud/cloudrevive-agent:1.0.0
docker run -p 80:80 -p 443:443 -v $SCRIPT_DIR/certs:/app/certs -d --restart unless-stopped --name agent registry.metal8.cloud/cloudrevive-agent:1.0.0
