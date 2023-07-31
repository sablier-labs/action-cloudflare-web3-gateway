# @sablier-labs/action-cloudflare-web3-gateway

Allows you to quickly update a Cloudflare Web3 Gateway with a new IPFS CID. This action requires that you have already created a Web3 Gateway in your Cloudflare settings. Additionally, you will need a Cloudflare Token with sufficient permissions to edit the record.

## Example

```yml
- name: Update Web3 Gateway
  env:
    CLOUDFLARE_TOKEN: ${{ secrets.CLOUDFLARE_TOKEN }}
    CLOUDFLARE_ZONE_ID: ${{ secrets.CLOUDFLARE_ZONE_ID }}
    CLOUDFLARE_GATEWAY_ID: ${{ secrets.CLOUDFLARE_GATEWAY_ID }}
  id: web3gateway
  uses: sablier-labs/cloudflare-update-web3-gateway@master
  with:
    cid: ${{ steps.push.outputs.cid }}
```
