#!/bin/bash

# Print message to indicate script is starting
echo "Starting Docker Compose services..."

# Navigate to the directory containing the docker-compose.yml file
cd "$(dirname "$0")"

# Pull the latest images (optional, uncomment if needed)
# docker-compose pull

# Build the Docker images (optional, uncomment if needed)
# docker-compose build

# Start the Docker Compose services
docker-compose up -d

# Print message to indicate script has completed
echo "Docker Compose services started."
