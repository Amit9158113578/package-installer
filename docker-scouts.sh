#!/bin/bash

# Exit on any error
set -e

echo "🔍 Checking Docker version..."
DOCKER_VERSION=$(docker version --format '{{.Server.Version}}')
REQUIRED_VERSION="24.0.0"

# Compare Docker version
if [ "$(printf '%s\n' "$REQUIRED_VERSION" "$DOCKER_VERSION" | sort -V | head -n1)" != "$REQUIRED_VERSION" ]; then
  echo "❌ Docker version $REQUIRED_VERSION or higher is required. Current version: $DOCKER_VERSION"
  exit 1
fi

echo "✅ Docker version $DOCKER_VERSION is compatible."

# Check if docker scout is already available
echo "🔍 Checking if Docker Scout is already installed..."
if ! docker scout version &>/dev/null; then
  echo "📦 Docker Scout not found. Installing..."

  # Download and install Docker Scout
  curl -sSfL https://raw.githubusercontent.com/docker/scout-cli/main/install.sh | sh -s --

  # Move it to the correct CLI plugins directory
  sudo mkdir -p /usr/libexec/docker/cli-plugins
  sudo mv ~/.docker/cli-plugins/docker-scout /usr/libexec/docker/cli-plugins/
  sudo chmod +x /usr/libexec/docker/cli-plugins/docker-scout

  echo "✅ Docker Scout installed and moved to plugin directory."
else
  echo "✅ Docker Scout is already installed."
fi

# Verify installation
echo "🔍 Verifying Docker Scout..."
docker scout version

# Set Docker socket permissions
echo "🔧 Setting permissions for Docker socket..."
sudo chmod 666 /var/run/docker.sock
echo "✅ Permissions set."

echo "🎉 Docker Scout setup completed successfully."

