#!/bin/bash

set -ex

PROTO_FILE="src/cartservice/src/protos/Cart.proto"
PROTO_IMPORT_PATH="src/cartservice/src/protos"
SERVER_ADDR="localhost:7070"
USER_ID="test-user"

# Add an item to the cart
grpcurl -plaintext -import-path "$PROTO_IMPORT_PATH" -proto "$PROTO_FILE" -d "{\"user_id\": \"$USER_ID\", \"item\": {\"product_id\": \"OLJCESPC7Z\", \"quantity\": 1}}" "$SERVER_ADDR" hipstershop.CartService/AddItem

# Get the cart to verify the item was added
grpcurl -plaintext -import-path "$PROTO_IMPORT_PATH" -proto "$PROTO_FILE" -d "{\"user_id\": \"$USER_ID\"}" "$SERVER_ADDR" hipstershop.CartService/GetCart

# Empty the cart
grpcurl -plaintext -import-path "$PROTO_IMPORT_PATH" -proto "$PROTO_FILE" -d "{\"user_id\": \"$USER_ID\"}" "$SERVER_ADDR" hipstershop.CartService/EmptyCart

# Get the cart again to verify it's empty
grpcurl -plaintext -import-path "$PROTO_IMPORT_PATH" -proto "$PROTO_FILE" -d "{\"user_id\": \"$USER_ID\"}" "$SERVER_ADDR" hipstershop.CartService/GetCart