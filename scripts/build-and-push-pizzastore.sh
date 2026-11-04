#!/usr/bin/env bash

set -Eeuo pipefail

# Azure Container Registry configuration
ACR_NAME="ibraheempizzastoreacr"
ACR_LOGIN_SERVER="${ACR_NAME}.azurecr.io"

# Application image configuration
IMAGE_NAME="pizzastore-api"
DOCKERFILE="src/PizzaStore.Api/Dockerfile"

# Require an explicit image tag to avoid accidental overwrites
TAG="${1:-}"

if [[ -z "$TAG" ]]; then
    echo "Usage: $0 <image-tag>"
    echo "Example: $0 v2"
    exit 1
fi

if [[ ! "$TAG" =~ ^[A-Za-z0-9_][A-Za-z0-9_.-]{0,127}$ ]]; then
    echo "Error: Invalid Docker image tag: $TAG"
    exit 1
fi

IMAGE="${ACR_LOGIN_SERVER}/${IMAGE_NAME}:${TAG}"

# Locate repository root regardless of where the script is executed
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

cd "$REPO_ROOT"

echo "======================================"
echo " PizzaStore Image Build and Push"
echo "======================================"
echo "Image: $IMAGE"
echo

# Check required tools
for command in az docker; do
    if ! command -v "$command" >/dev/null 2>&1; then
        echo "Error: $command is not installed."
        exit 1
    fi
done

# Check Azure authentication
echo "[1/5] Checking Azure authentication..."
az account show --output none

# Check Docker daemon
echo "[2/5] Checking Docker..."
docker info >/dev/null

# Authenticate Docker with ACR
echo "[3/5] Authenticating with ACR..."
az acr login --name "$ACR_NAME"

# Build image
echo "[4/5] Building image..."
docker build \
    -f "$DOCKERFILE" \
    -t "$IMAGE" \
    .

# Push and verify
echo "[5/5] Pushing image..."
docker push "$IMAGE"

echo
echo "Verifying image in ACR..."

az acr repository show \
    --name "$ACR_NAME" \
    --image "${IMAGE_NAME}:${TAG}" \
    --output none

echo
echo "======================================"
echo " SUCCESS"
echo "======================================"
echo "Published image: $IMAGE"


