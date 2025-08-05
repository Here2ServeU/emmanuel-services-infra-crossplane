#!/bin/bash
echo "Installing ArgoCD..."
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
echo "ArgoCD installed. Use 'kubectl port-forward svc/argocd-server -n argocd 8080:443' to access the UI."
