#!/bin/bash

# Variables
RESOURCE_GROUP="aks-demox"
AKS_CLUSTER_NAME="aks-demo"
LOCATION="eastus"

# Create Resource Group
echo "Creating Resource Group: $RESOURCE_GROUP"
az group create --name $RESOURCE_GROUP --location $LOCATION

# Create AKS Cluster
echo "Creating AKS Cluster: $AKS_CLUSTER_NAME"
az aks create --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER_NAME --node-count 1 --enable-addons monitoring --generate-ssh-keys

# Get AKS Credentials
echo "Getting AKS Credentials"
az aks get-credentials --name $AKS_CLUSTER_NAME --resource-group $RESOURCE_GROUP

# Get Nodes
echo "Getting Nodes"
kubectl get nodes

# Create Namespace
NAMESPACE="aks-store-demo"
echo "Creating Namespace: $NAMESPACE"
kubectl create ns $NAMESPACE

# Apply Ingress Quickstart YAML
echo "Applying Ingress Quickstart YAML"
kubectl apply -n $NAMESPACE -f https://raw.githubusercontent.com/Azure-Samples/aks-store-demo/main/aks-store-ingress-quickstart.yaml

# Get Pods
echo "Getting Pods in Namespace: $NAMESPACE"
kubectl get pods -n $NAMESPACE

# Watch Ingress
echo "Watching Ingress: store-front in Namespace: $NAMESPACE"
kubectl get ingress store-front -n $NAMESPACE --watch