#!/bin/bash

ip=$1
echo "Test de NGINX sur $ip"
curl http://$ip
chmod +x scripts/test_nginx.sh
