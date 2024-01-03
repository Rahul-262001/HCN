#!/bin/bash
figlet -c "Welcome to my Program" | sed 's/./\x1b[31m&\x1b[0m/g'



read -p "Enter the name of docker hub repo: " repo
#./print_ports.sh
TPORT=6901
#prompt for the name of the Kubernetes deployment
read -p "Enter the name of the Kubernetes deployment: " K3S_DEPLOYMENT_NAME

echo "Please check the port"
kubectl get services
# Prompt for the NodePort value
read -p "Enter the NodePort value (e.g., 30000-32767): " NODE_PORT

# Check if NodePort is provided
if [ -z "$NODE_PORT" ]; then
    echo "Please provide a NodePort value."
    exit 1
fi

# Create deployment.yaml file
echo "apiVersion: apps/v1
kind: Deployment
metadata:
  name: $K3S_DEPLOYMENT_NAME
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $K3S_DEPLOYMENT_NAME
  template:
    metadata:
      labels:
        app: $K3S_DEPLOYMENT_NAME
    spec:
      containers:
      - name: $K3S_DEPLOYMENT_NAME
        image: serieswatcher/$repo:latest
        ports:
        - containerPort: $TPORT
        env:
        - name: VNC_PW
          value: "password"
---
apiVersion: v1
kind: Service
metadata:
  name: $K3S_DEPLOYMENT_NAME-service
spec:
  selector:
    app: $K3S_DEPLOYMENT_NAME
  ports:
    - protocol: TCP
      port: $TPORT
      targetPort: $TPORT
      nodePort: $NODE_PORT
  type: NodePort" > deployment.yaml

# Apply Kubernetes deployment
kubectl apply -f deployment.yaml

# Check if Kubernetes deployment was successful
if [ $? -ne 0 ]; then
    echo "Error applying Kubernetes deployment."
    exit 1
fi

echo "Workflow completed"
echo "The link is http://10.0.0.8:$NODE_PORT/$HTML_FILE"
echo "                        OR                        "
echo "The link is https://10.0.0.8:$NODE_PORT/$HTML_FILE"

