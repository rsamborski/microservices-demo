# Migration Plan: Cart Service from C# gRPC to TypeScript HTTP

This document outlines the plan to migrate the `cartservice` from a C# gRPC implementation to a TypeScript HTTP/JSON service.

## 1. Project Setup

*   **Create Project Directory:** A new directory, `src/cartservice-ts`, will be created to house the new TypeScript service.
*   **Initialize Node.js Project:** A `package.json` file will be created using `npm init -y`.
*   **Install Dependencies:** The following npm packages will be installed:
    *   **Runtime:** `express`, `axios`
    *   **Development:** `typescript`, `ts-node`, `jest`, `supertest`, `@types/express`, `@types/jest`, `@types/node`, `openapi-typescript`, `swagger-ui-express`
*   **TypeScript Configuration:** A `tsconfig.json` file will be created to configure the TypeScript compiler.
*   **Jest Configuration:** A `jest.config.js` file will be created to configure the Jest testing framework.

## 2. OpenAPI Specification

*   **Convert Proto to OpenAPI:** The existing `demo.proto` file will be manually converted into an OpenAPI 3.0 specification. This new specification will be saved as `src/cartservice-ts/openapi.yaml`. This will define the API contract for the new HTTP service.

## 3. API Server Tests (Test-Driven Development)

*   **Create Test Directory:** A `src/cartservice-ts/src/tests` directory will be created.
*   **Write API Tests:** Jest tests will be written for all the API endpoints defined in `openapi.yaml`. These tests will be written *before* the implementation of the server and will cover:
    *   `POST /cart`: Add an item to the cart.
    *   `GET /cart/{userId}`: Get a user's cart.
    *   `DELETE /cart/{userId}`: Empty a user's cart.

## 4. HTTP Server Implementation

*   **Create Source Directory:** A `src/cartservice-ts/src` directory will be created.
*   **Server Entrypoint:** `src/cartservice-ts/src/index.ts` will be the main entry point for the Express server.
*   **Express Server:** An Express server will be implemented with routes corresponding to the OpenAPI specification.
*   **Route Handlers:** Handlers for each route will be implemented in `src/cartservice-ts/src/handlers.ts`.
*   **Cart Logic:** The core cart management logic will be implemented in `src/cartservice-ts/src/cart.ts`. Initially, this will be an in-memory data store to replicate the functionality of the existing `RedisCartStore`.

## 5. Containerization and Deployment

*   **Dockerfile:** A new `Dockerfile` will be created in `src/cartservice-ts` to build a container image for the new TypeScript service.
*   **Kubernetes Manifest:** The `kubernetes-manifests/cartservice.yaml` file will be updated to:
    *   Use the new Docker image.
    *   Change the port to the new HTTP port.
    *   Remove the gRPC-specific configurations.

## 6. Documentation

*   **README:** A `README.md` file will be created in `src/cartservice-ts` to provide instructions on how to build, test, and run the new service.

This plan will be executed milestone by milestone, with a request for approval before proceeding to the next.
