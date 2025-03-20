#!/bin/bash

# Set default values for version and image tag
VERSION=${1:-latest}  # If no version is provided, default to 'latest'
IMAGE_NAME="fastapi-app"
DOCKERFILE_PATH="."

# List of platforms to build for (amd64, arm64, etc.)
PLATFORMS="linux/amd64,linux/arm64"  # You can modify this list based on your target architectures

# Enable Buildx if it's not available (ensure multi-platform support)
DOCKER_BUILDKIT=1

# Create a builder instance (if needed)
docker buildx create --use

# Build multi-platform Docker image
echo "Building multi-platform Docker image: ${IMAGE_NAME}:${VERSION} for platforms ${PLATFORMS}"
docker buildx build --platform ${PLATFORMS} -t ${IMAGE_NAME}:${VERSION} ${DOCKERFILE_PATH} --load

# Optionally, tag the image with 'latest'
echo "Tagging image as latest"
docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest

# Show built image
docker images ${IMAGE_NAME}

