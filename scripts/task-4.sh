#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
CLUSTER_NAME=m4a-processing
ZONE=us-central1-a
SOURCE_NAME=m4a-source 
CE_SRC=m4a-ce-src
JOB_NAME=ledgermonolith-migration
VM_NAME=ledgermonolith-service

# run a migration job that we just set up
migctl migration create $JOB_NAME --source $SOURCE_NAME --vm-id $VM_NAME