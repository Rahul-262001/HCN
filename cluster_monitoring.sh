#!/bin/bash

# Cluster Information
echo "Cluster Information:"
kubectl cluster-info
echo

# Node Information
echo "Node Information:"
kubectl get nodes
echo

# Pod Information
echo "Pod Information:"
kubectl get pods --all-namespaces
echo

# Service Information
echo "Service Information:"
kubectl get services --all-namespaces
echo

# Persistent Volume Information
echo "Persistent Volume Information:"
kubectl get pv
echo

# Persistent Volume Claim Information
echo "Persistent Volume Claim Information:"
kubectl get pvc --all-namespaces
echo

# Ingress Information
echo "Ingress Information:"
kubectl get ingress --all-namespaces
echo

# Events
echo "Cluster Events:"
kubectl get events --sort-by=.metadata.creationTimestamp
echo

# Custom Metrics or Specific Monitoring Commands

