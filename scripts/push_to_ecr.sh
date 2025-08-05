#!/bin/bash

ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGION="us-east-1"
REPO_NAME="emmanuel-services"

aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin "$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com"
docker build -t $REPO_NAME:v1 ../docker
docker tag $REPO_NAME:v1 "$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:v1"
docker push "$ACCOUNT_ID.dkr.ecr.$REGION.amazonaws.com/$REPO_NAME:v1"
