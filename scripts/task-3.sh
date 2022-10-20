#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
CLUSTER_NAME=m4a-processing
ZONE=us-central1-a
SOURCE_NAME=m4a-source 

# create a service account for VM source migrations
gcloud iam service-accounts create m4a-ce-src

# give the service account compute viewer and compute storage admin rights
gcloud projects add-iam-policy-binding $PROJECT_ID  \
  --member="serviceAccount:m4a-ce-src@${PROJECT_ID}.iam.gserviceaccount.com" \
  --role="roles/compute.viewer"
gcloud projects add-iam-policy-binding $PROJECT_ID  \
  --member="serviceAccount:m4a-ce-src@${PROJECT_ID}.iam.gserviceaccount.com" \
  --role="roles/compute.storageAdmin"

# download key file for this service account
gcloud iam service-accounts keys create m4a-ce-src.json \
  --iam-account=m4a-ce-src@$PROJECT_ID.iam.gserviceaccount.com

# create the migration source
migctl source create compute-engine $SOURCE_NAME --json-key=m4a-ce-src.json
