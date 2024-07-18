#!/bin/bash

FILE="certs/erver.crt"

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
docker run -p 80:5000 -d --restart unless-stopped --name agent registry.metal8.cloud/cloudrevive-agent:1.0.0
