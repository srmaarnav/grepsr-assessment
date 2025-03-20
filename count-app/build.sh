#!/bin/bash

# Set default values for version and image tag
VERSION=${1}  # If no version is provided, default to 'latest'
IMAGE_NAME="sharmaarnav/fastapi-assesment-app"
DOCKERFILE_PATH="."

# Build Docker image
echo "Building Docker image: ${IMAGE_NAME}:${VERSION}"
docker build -t ${IMAGE_NAME}:${VERSION} ${DOCKERFILE_PATH}

# Show built image
docker images ${IMAGE_NAME}

docker push ${IMAGE_NAME}:${VERSION}
docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest
docker push ${IMAGE_NAME}:latest

docker rmi ${IMAGE_NAME}:${VERSION}
docker rmi ${IMAGE_NAME}:latest
