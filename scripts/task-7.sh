#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
ZONE=us-central1-a
SOURCE_NAME=m4a-source 
CE_SRC=m4a-ce-src
JOB_NAME=ledgermonolith-migration
VM_NAME=ledgermonolith-service
CLUSTER_NAME=cymbal-monolith-cluster

# get credential for the new cluster
gcloud container clusters get-credentials $CLUSTER_NAME \
  --project=$PROJECT_ID --zone=$ZONE

# deploy new container to our prod cluster
xxx
