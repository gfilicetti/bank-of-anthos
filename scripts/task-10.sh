#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
ZONE=us-central1-a
GKE_PROD_CLUSTER_NAME=cymbal-bank-prod
GKE_PROD_NODES=4
CHANNEL=stable
CP_VERSION=1.23
NODE_VM_TYPE=e2-standard-4

# create a new GKE cluster according to specs
gcloud container clusters create $GKE_PROD_CLUSTER_NAME \
  --project=$PROJECT_ID --zone=$ZONE \
  --machine-type=$NODE_VM_TYPE --num-nodes=$GKE_PROD_NODES \
  --release-channel=$CHANNEL --cluster-version=$CP_VERSION \
  --monitoring=SYSTEM --logging=SYSTEM,WORKLOAD --subnetwork=default \
  --tags=$GKE_PROD_CLUSTER_NAME --labels csm=
