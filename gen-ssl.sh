#!/bin/bash

set -x

mkdir -p certs
openssl genrsa -out certs/server.key 2048
openssl req -new -key certs/server.key -out certs/server.csr -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=localhost"
openssl x509 -req -days 365 -in certs/server.csr -signkey certs/server.key -out certs/server.crt
