#!/bin/bash
ACR_NAME="emmanacr"
REPO_NAME="emmanuel-services-infra-crossplane"
IMAGE_URI="$ACR_NAME.azurecr.io/$REPO_NAME:v1"
az acr login --name "$ACR_NAME"
docker build -t $REPO_NAME:v1 ./docker
docker tag $REPO_NAME:v1 $IMAGE_URI
docker push $IMAGE_URI
echo "✅ Docker image pushed to ACR: $IMAGE_URI"
