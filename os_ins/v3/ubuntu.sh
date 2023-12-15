#!/bin/bash

figlet -c "Welcome to my Program" | sed 's/./\x1b[31m&\x1b[0m/g'

# Prompt for the name of the Kubernetes deployment
read -p "Enter the name of the Kubernetes deployment: " K8S_DEPLOYMENT_NAME

echo "Please check the port"
kubectl get services

# Prompt for the NodePort value
read -p "Enter the NodePort value (e.g., 30000-32767): " NODE_PORT

# Check if NodePort is provided
if [ -z "$NODE_PORT" ]; then
    echo "Please provide a NodePort value."
    exit 1
fi

# Use the content of deployment.yaml and service.yaml
DEPLOYMENT_FILE="deployment.yaml"
SERVICE_FILE="service.yaml"

echo "apiVersion: apps/v1
kind: Deployment
metadata:
  name: $K8S_DEPLOYMENT_NAME
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $K8S_DEPLOYMENT_NAME
  template:
    metadata:
      labels:
        app: $K8S_DEPLOYMENT_NAME
    spec:
      containers:
      - name: $K8S_DEPLOYMENT_NAME-container
        image: serieswatcher/ubuntu-ttyd:latest
        ports:
        - containerPort: 7681
---
apiVersion: v1
kind: Service
metadata:
  name: $K8S_DEPLOYMENT_NAME-service
spec:
  selector:
    app: $K8S_DEPLOYMENT_NAME
  ports:
    - protocol: TCP
      Port: $NODE_PORT
      targetPort: 7681
  type: NodePort" > "$DEPLOYMENT_FILE"

# Apply Kubernetes deployment
kubectl apply -f "$DEPLOYMENT_FILE"

# Check if Kubernetes deployment was successful
if [ $? -ne 0 ]; then
    echo "Error applying Kubernetes deployment."
    exit 1
fi

echo "Workflow completed"
echo "The link is http://10.0.0.8:$NODE_PORT/"
