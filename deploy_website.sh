#!/bin/bash

# Check if the HTML file path is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <path/to/html/file>"
    exit 1
fi

# Generate a unique tag for the Docker image based on timestamp
IMAGE_TAG="serieswatcher/trail:$(date '+%Y%m%d%H%M%S')"

# Build Docker image with the unique tag
docker build -t "$IMAGE_TAG" .

# Push Docker image to Docker Hub
docker push "$IMAGE_TAG"

# Update Kubernetes Deployment YAML with the new image and HTML file
cat <<EOL > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: trail-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: trail-website
  template:
    metadata:
      labels:
        app: trail-website
    spec:
      containers:
      - name: trail-container
        image: $IMAGE_TAG
        ports:
        - containerPort: 80
EOL

# Copy the provided HTML file to the Docker image
docker cp "$1" trail-deployment-$(kubectl get pods -o jsonpath='{.items[0].metadata.name}'):/usr/share/nginx/html/hello.html

# Apply Kubernetes Deployment
kubectl apply -f deployment.yaml

# Wait for the pod to be running
kubectl wait --for=condition=Ready pod -l app=trail-website --timeout=300s

# Expose the website using NodePort
kubectl expose deployment trail-deployment --type=NodePort --port=8081 --target-port=80 --name=trail-nodeport-service

# Print instructions
NODEPORT=$(kubectl get service trail-nodeport-service -o=jsonpath='{.spec.ports[0].nodePort}')
PRIVATE_IP=$(kubectl get nodes -o=jsonpath='{.items[0].status.addresses[?(@.type=="InternalIP")].address}')

echo "Website deployed successfully!"
echo "Access your website at: http://$PRIVATE_IP:$NODEPORT"

