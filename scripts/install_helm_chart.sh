#!/bin/bash

CLUSTER_NAME=$1
NAMESPACE=${2:-default}

echo "Deploying Helm chart to $CLUSTER_NAME in namespace $NAMESPACE..."

helm upgrade --install emmanuel-services ./helm \
  --namespace "$NAMESPACE" \
  --create-namespace
