#!/bin/bash

# Set the name and tag for the image
IMAGE_NAME="realashleybailey/wizarr"
IMAGE_TAG="beta"

# Create a buildx environment
docker buildx create --name wizarrbuilder
docker buildx use wizarrbuilder

# Build the image using buildx
docker buildx build --platform linux/amd64,linux/arm64,linux/arm64/v7,linux/arm64/v8 --cache-to type=local,dest=database/cache --push -t $IMAGE_NAME:$IMAGE_TAG --progress tty .

# Remove the buildx environment
docker buildx rm wizarrbuilder

