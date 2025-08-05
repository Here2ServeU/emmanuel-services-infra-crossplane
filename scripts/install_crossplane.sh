#!/bin/bash
echo "Installing Crossplane..."
kubectl create namespace crossplane-system --dry-run=client -o yaml | kubectl apply -f -
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update
helm install crossplane crossplane-stable/crossplane -n crossplane-system
echo "Crossplane installed in 'crossplane-system' namespace."
