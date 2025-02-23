#!/bin/bash
set -e

# Change to the directory where this script is located
cd "$(dirname "$0")"

# Load environment variables from .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo ".env file not found!"
  exit 1
fi

# Check required variables
if [ -z "$DOCKERHUB_USERNAME" ] || [ -z "$DOCKERHUB_PASSWORD" ]; then
  echo "Please set DOCKERHUB_USERNAME and DOCKERHUB_PASSWORD in your .env file."
  exit 1
fi

# Log in to Docker Hub
echo "Logging in to Docker Hub..."
echo "$DOCKERHUB_PASSWORD" | docker login --username "$DOCKERHUB_USERNAME" --password-stdin

# Build the image using the Dockerfile in this directory (the plex folder)
echo "Building the Docker image..."
docker build -t plex-cof:latest -f Dockerfile .

# Tag the image for Docker Hub
echo "Tagging the image..."
docker tag plex-cof:latest gerardogve/plex-cof:latest

# Push the image to Docker Hub
echo "Pushing the image to Docker Hub..."
docker push gerardogve/plex-cof:latest

echo "Build and push complete."
