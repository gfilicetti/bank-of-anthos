#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
ZONE=us-central1-a
GKE_PROD_CLUSTER_NAME=cymbal-bank-prod
GKE_DEV_CLUSTER_NAME=cymbal-bank-dev
CONFIG_MAP_NAME=asm-options
CONTEXT_PROD="gke_l300-appmod-lab_us-central1-a_cymbal-bank-prod"
CONTEXT_DEV="gke_l300-appmod-lab_us-central1-a_cymbal-bank-dev"

# NOTE !!!!!!!!!!!!!!!!!!!!!!
# Use this command to list out all the contexts in your kube config
# kubectl config get-contexts --output name
# ---------------------------

# needed when getting CIDRS
function join_by { local IFS="$1"; shift; echo "$*"; }

# get kubectl context for prod
# gcloud container clusters get-credentials $GKE_PROD_CLUSTER_NAME \
#   --project=$PROJECT_ID --zone=$ZONE

# create the configmap for multicluster
kubectl --context=$CONTEXT_PROD create configmap $CONFIG_MAP_NAME -n istio-system --from-file <(echo '{"data":{"multicluster_mode":"connected"}}')

# get kubectl context for dev
# gcloud container clusters get-credentials $GKE_DEV_CLUSTER_NAME \
#   --project=$PROJECT_ID --zone=$ZONE

# create the configmap for multicluster
kubectl --context=$CONTEXT_DEV create configmap $CONFIG_MAP_NAME -n istio-system --from-file <(echo '{"data":{"multicluster_mode":"connected"}}')