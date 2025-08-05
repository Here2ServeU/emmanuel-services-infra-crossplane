#!/bin/bash
echo "Port forwarding ArgoCD UI..."
kubectl port-forward svc/argocd-server -n argocd 8080:443
