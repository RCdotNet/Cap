#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
dockerpath="zerocodebit/projectcapstone"

# Step 2:  
# Authenticate & tag
docker login --username "zerocodebit" &&\
    docker image tag projectcapstone $dockerpath
echo "Docker ID and Image: $dockerpath"

# Step 3:docker push $dockerpath
# Push image to a docker repository
docker image push $dockerpath
