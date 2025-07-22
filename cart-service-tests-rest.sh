#!/bin/bash

set -ex

SERVER_ADDR="localhost:3000"
USER_ID="test-user"

# Add an item to the cart
curl -X POST -H "Content-Type: application/json" -d "{\"userId\": \"$USER_ID\", \"item\": {\"productId\": \"OLJCESPC7Z\", \"quantity\": 1}}" "http://$SERVER_ADDR/cart"

# Get the cart to verify the item was added
curl "http://$SERVER_ADDR/cart/$USER_ID"

# Empty the cart
curl -X DELETE "http://$SERVER_ADDR/cart/$USER_ID"

# Get the cart again to verify it's empty
curl "http://$SERVER_ADDR/cart/$USER_ID"

