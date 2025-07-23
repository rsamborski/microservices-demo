# Plan for Migrating Cart Stores to TypeScript

This document outlines the plan to migrate the cart storage backends for the `cartservice` from C# to TypeScript. The existing C# implementation has several backends (`Redis`, `AlloyDB`, `Spanner`) that implement the `ICartStore` interface. We will replicate this structure in TypeScript.

## 1. Define the Cart Store Interface in TypeScript

- Create a new directory `src/cartservice-ts/src/cartstore` for the cart store implementations.
- Create a TypeScript interface `ICartStore` in `src/cartservice-ts/src/cartstore/ICartStore.ts`.
- This interface will define the methods for interacting with the cart storage, based on the C# `ICartStore.cs`:
  - `addItem(userId: string, productId: string, quantity: number): Promise<void>`
  - `getCart(userId: string): Promise<Cart>`
  - `emptyCart(userId: string): Promise<void>`
  - `ping(): Promise<void>`
- Define the `Cart` and `CartItem` types in a shared types file if they don't exist, based on the protobuf definitions.

## 2. Implement RedisCartStore

- Create `src/cartservice-ts/src/cartstore/RedisCartStore.ts`.
- This class will implement the `ICartStore` interface.
- Use a Node.js Redis client library (e.g., `redis`) to connect to the Redis server.
- The cart data will be stored as a JSON string in Redis, with the user ID as the key.
- Implement the methods:
  - `addItem`: Retrieve the cart, update it, and store it back.
  - `getCart`: Retrieve the cart from Redis. Return an empty cart if not found.
  - `emptyCart`: Clear the cart for a user.
  - `ping`: Check the connection to Redis.

## 3. Implement AlloyDBCartStore

- Create `src/cartservice-ts/src/cartstore/AlloyDBCartStore.ts`.
- This class will implement the `ICartStore` interface.
- Use a Node.js PostgreSQL client library (e.g., `pg`) to connect to the AlloyDB instance.
- The connection details (including password from Secret Manager) will be handled similarly to the C# implementation.
- Implement the methods using SQL queries:
  - `addItem`: Add or update an item in the cart table.
  - `getCart`: Retrieve all items for a user and construct the cart object.
  - `emptyCart`: Delete all items for a user.
  - `ping`: Check the connection to the database.

## 4. Implement SpannerCartStore

- Create `src/cartservice-ts/src/cartstore/SpannerCartStore.ts`.
- This class will implement the `ICartStore` interface.
- Use the `@google-cloud/spanner` library to connect to Spanner.
- Implement the methods using the Spanner client library:
  - `addItem`: Add or update an item in the cart table.
  - `getCart`: Retrieve all items for a user.
  - `emptyCart`: Delete all items for a user.
  - `ping`: Check the connection to the database.

## 5. Integrate Cart Stores into the Application

- Modify the main application file (`src/cartservice-ts/src/index.ts`) to select and initialize the desired cart store based on an environment variable (e.g., `CART_STORE_TYPE`).
- Use dependency injection to provide the cart store instance to the service/controller layer that handles the API requests.
- Update the API handlers to use the methods from the `ICartStore` instance.

## 6. Update Dependencies

- Add the necessary npm packages to `src/cartservice-ts/package.json`:
  - `redis`
  - `pg`
  - `@google-cloud/spanner`
  - `@google-cloud/secret-manager`

By following this plan, we will have a flexible architecture for the `cartservice-ts` that allows for easy switching between different backend storages, mirroring the original C# implementation's capabilities.
