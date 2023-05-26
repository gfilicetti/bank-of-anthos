#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
ZONE=us-central1-a
GKE_PROD_CLUSTER_NAME=cymbal-bank-prod
GKE_DEV_CLUSTER_NAME=cymbal-bank-dev
CONTEXT_PROD=gke_l300-appmod-lab_us-central1-a_cymbal-bank-prod
CONTEXT_DEV=gke_l300-appmod-lab_us-central1-a_cymbal-bank-dev
GW_NAMESPACE=gateway-namespace
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

# deploy the gateway ingress controller using a file that was creating during ASM installation
kubectl apply -f $INGRESS_GW_DIR -n $GW_NAMESPACE

# enable traffic management by creating a Gateway and a VirtualService
kubectl apply -f $FE_INGRESS_FILE -n $GW_NAMESPACE