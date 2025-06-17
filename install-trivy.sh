#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Installing prerequisites..."
sudo apt-get update
sudo apt-get install -y wget apt-transport-https gnupg lsb-release

echo "Adding Trivy GPG key..."
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/trivy.gpg

echo "Adding Trivy repository..."
echo "deb [signed-by=/etc/apt/trusted.gpg.d/trivy.gpg] https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/trivy.list

echo "Updating package list..."
sudo apt-get update

echo "Installing Trivy..."
sudo apt-get install -y trivy

echo "Verifying Trivy installation..."
trivy --version

