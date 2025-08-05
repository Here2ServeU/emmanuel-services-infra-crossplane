#!/bin/bash
echo "Port forwarding Grafana dashboard..."
kubectl port-forward svc/grafana 3000:3000 -n monitoring
