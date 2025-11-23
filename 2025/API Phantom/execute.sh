#!/bin/bash
response=$(curl -H "Accept: application/json" "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd")
value=$(echo "$response" | grep -o '"usd":[0-9]*' | cut -d: -f2)
echo "$value"