#!/bin/bash

docker pull registry.metal8.cloud/cloudrevive-agent:1.0.0
docker run -p 80:5000 -d --restart unless-stopped --name agent cloudrevive-agent:1.0.0
