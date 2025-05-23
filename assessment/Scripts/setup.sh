#!/bin/bash

set -e

yum update -y
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

mkdir -p /opt/wazuh
cd /opt/wazuh

cat <<EOF > docker-compose.yml
version: '3.9'
services:
  wazuh:
    image: wazuh/wazuh:4.7.0
    ports:
      - "55000:55000"
    volumes:
      - wazuh_data:/var/ossec/data
    environment:
      - WAZUH_MANAGER_NAME=wazuh
    healthcheck:
      test: curl --fail http://localhost:55000 || exit 1
      interval: 30s
      retries: 3
volumes:
  wazuh_data:
EOF

docker-compose up -d
