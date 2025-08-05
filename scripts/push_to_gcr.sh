#!/bin/bash
PROJECT_ID="your-gcp-project-id"
REPO_NAME="emmanuel-services-infra-crossplane"
IMAGE_URI="gcr.io/$PROJECT_ID/$REPO_NAME:v1"
gcloud auth configure-docker
docker build -t $REPO_NAME:v1 ./docker
docker tag $REPO_NAME:v1 $IMAGE_URI
docker push $IMAGE_URI
echo "✅ Docker image pushed to GCR: $IMAGE_URI"
