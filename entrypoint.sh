#!/bin/bash
set -e # abort on any error

response=$(curl \
        -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
        -H "Content-Type: application/json" \
        -s "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/web3/hostnames/$CLOUDFLARE_GATEWAY_ID")

success=$(jq -r  '.success' <<< "${response}" )

if [ $success != "true" ]; then
  echo "Web3 Gateway Update: Failed to find gateway"
  errors=$(jq -r  '.errors' <<< "${response}" )
  echo "Errors: $errors"
  exit 1
fi

echo "Web3 Gateway Update: Gateway Found!"

patchResponse=$(curl \
        -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
        -H "Content-Type: application/json" \
        -X PATCH \
        --data "{\"dnslink\":\"/ipfs/$1\"}" \
        -s "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/web3/hostnames/$CLOUDFLARE_GATEWAY_ID")

success=$(jq -r  '.success' <<< "${patchResponse}" )
if [ $success != "true" ]; then
  echo "Web3 Gateway Update: Failed to update record!"
  errors=$(jq -r  '.errors' <<< "${patchResponse}" )
  echo "Errors: $errors"
  exit 1
fi

echo "Web3 Gateway Update: Success"
echo "  Gateway $CLOUDFLARE_GATEWAY_ID updated to $1."
echo "  Update time will vary depending on your Cloudflare settings."
