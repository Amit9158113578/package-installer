#!/bin/bash

# Exit on error
set -e

echo "Checking Docker version..."
DOCKER_VERSION=$(docker version --format '{{.Server.Version}}')
REQUIRED_VERSION="24.0.0"

if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$DOCKER_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
  echo "❌ Docker version 24.0.0 or higher is required. Current version: $DOCKER_VERSION"
  exit 1
fi

echo "✅ Docker version $DOCKER_VERSION is compatible."

echo "Installing Docker Scout CLI plugin..."

# Download and install Docker Scout plugin
curl -sSfL https://raw.githubusercontent.com/docker/scout-cli/main/install.sh | sh -s --

# Verify installation
echo "Verifying Docker Scout installation..."
docker scout version

echo "✅ Docker Scout has been installed successfully."

sudo chmod 777 /var/run/docker.sock

echo "gave permission to docker scoute"
