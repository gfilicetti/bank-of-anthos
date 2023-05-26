#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
ZONE=us-central1-a
GKE_PROD_CLUSTER_NAME=cymbal-bank-prod
GKE_DEV_CLUSTER_NAME=cymbal-bank-dev
NETWORK=default
CONFIG_MAP_NAME=asm-options

# needed when getting CIDRS
function join_by { local IFS="$1"; shift; echo "$*"; }

# get kubectl context for this cluster
gcloud container clusters get-credentials $GKE_PROD_CLUSTER_NAME \
  --project=$PROJECT_ID --zone=$ZONE

kubectl create configmap $CONFIG_MAP_NAME -n istio-system --from-file < (echo '{"data":{"multicluster_mode":"connected"}}')
