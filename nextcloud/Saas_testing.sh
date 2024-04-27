#!/bin/bash

# Execute the deploy_website.sh script
./install.sh


# Check if the Kubernetes deployment was successful
kubectl get deployments | grep "$K8S_DEPLOYMENT_NAME"
if [ $? -eq 0 ]; then
   # echo "Kubernetes Iaas Deployment Test: Passed"
   echo -e "\e[32mKubernetes SaaS Deployment Test: Passed\e[0m"

else
    echo "Kubernetes Deployment Test: Failed"
fi

# Check if the NodePort is assigned
kubectl get services | grep "$K8S_DEPLOYMENT_NAME-service"
if [ $? -eq 0 ]; then
   # echo "NodePort Iaas Test: Passed"
   echo -e "\e[32mNodePort SaaS Test: Passed\e[0m"

else
    echo "NodePort Test: Failed"
fi
