#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
ZONE=us-central1-a
GKE_PROD_CLUSTER_NAME=cymbal-bank-prod
GKE_DEV_CLUSTER_NAME=cymbal-bank-dev
GW_NAMESPACE=gateway-namespace
ISTIO_REV=asm-1172-1
INGRESS_GW_DIR=../asm/samples/gateways/istio-ingressgateway 
FE_INGRESS_FILE=frontend-ingress.yaml

# NOTE !!!!!!!!!!!!!!!!!!!!!!
# Use this command to list out all the contexts in your kube config
# kubectl config get-contexts --output name
# ---------------------------

# get kubectl context for this cluster
gcloud container clusters get-credentials $GKE_PROD_CLUSTER_NAME \
  --project=$PROJECT_ID --zone=$ZONE

# create a namespace for the istio gateway
kubectl create namespace $GW_NAMESPACE

# label the namespace for injection, just like we did in Task 16
kubectl label namespace $GW_NAMESPACE istio-injection- istio.io/rev=$ISTIO_REV --overwrite

# deploy the gateway ingress controller using files that were created during ASM installation
kubectl apply -n $GW_NAMESPACE -f $INGRESS_GW_DIR 

# enable traffic management by creating a Gateway and a VirtualService
kubectl apply -n $GW_NAMESPACE -f $FE_INGRESS_FILE 
