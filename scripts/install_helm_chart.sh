#!/bin/bash
CLUSTER_NAME=${1:-emmanuel-cluster}
NAMESPACE=${2:-default}
RELEASE_NAME="emmanuel-services-infra-crossplane"
echo "Installing Helm chart '$RELEASE_NAME' to cluster: $CLUSTER_NAME in namespace: $NAMESPACE"
helm upgrade --install "$RELEASE_NAME" ./helm \
  --namespace "$NAMESPACE" \
  --create-namespace
echo "Helm chart deployed to $CLUSTER_NAME"
