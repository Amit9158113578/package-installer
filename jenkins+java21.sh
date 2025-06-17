#!/bin/bash

# Exit on any error
set -e

echo "Updating package list..."
sudo apt update

echo "Installing Java (OpenJDK 21)..."
sudo apt install -y fontconfig openjdk-21-jre

echo "Verifying Java installation..."
java -version

echo "Adding Jenkins repository key..."
sudo mkdir -p /etc/apt/keyrings
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "Adding Jenkins repository..."
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
  | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package list with Jenkins repo..."
sudo apt-get update

echo "Installing Jenkins..."
sudo apt-get install -y jenkins

echo "Enabling and starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "Checking Jenkins service status..."
sudo systemctl status jenkins

