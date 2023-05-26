#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
ZONE=us-central1-a
GKE_PROD_CLUSTER_NAME=cymbal-bank-prod
OUTPUT_DIR=../asm

# install ASM on the production cluster
asmcli install \
  --project_id $PROJECT_ID \
  --cluster_name $GKE_PROD_CLUSTER_NAME \
  --cluster_location $ZONE \
  --output_dir $OUTPUT_DIR \
  --enable_all \
  --ca mesh_ca
