#!/bin/bash

# Exit on any error
set -e

echo "Running SonarQube LTS Community container..."
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community

echo "Listing running Docker containers..."
docker ps

