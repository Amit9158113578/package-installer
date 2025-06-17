#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Update and install unzip
echo "Installing unzip..."
sudo apt update && sudo apt install unzip -y

# Download AWS CLI v2
echo "Downloading AWS CLI v2..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the package
echo "Unzipping AWS CLI package..."
unzip awscliv2.zip

# Install AWS CLI
echo "Installing AWS CLI..."
sudo ./aws/install

# Verify installation
echo "Verifying AWS CLI installation..."
aws --version

