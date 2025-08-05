#!/bin/bash
REGION="us-east-1"
REPO_NAME="emmanuel-services-infra-crossplane"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
IMAGE_URI="$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:v1"
aws ecr get-login-password --region "$REGION" | docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"
docker build -t $REPO_NAME:v1 ./docker
docker tag $REPO_NAME:v1 $IMAGE_URI
docker push $IMAGE_URI
echo "Docker image pushed to ECR: $IMAGE_URI"
