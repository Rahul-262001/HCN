#!/bin/bash

kubectl get deployment
sleep 1
echo "Read the service name properly and enter it correctly"
read name

echo "Deleting deployment $name"
kubectl delete deployment $name

echo "Deleted deployment successfully!"
sleep 2

echo "Deleting the NodePort service"

kubectl get services

echo "Enter the service name "
read  $name
kubectl delete service $name

echo "After Deleting"
echo ""
echo ""
echo "Deployments are"
kubectl get deployments
echo ""
echo ""
echo "The services are "
kubectl get services

echo "Workflow completed"
