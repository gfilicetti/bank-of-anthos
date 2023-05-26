#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUM=$(gcloud projects describe ${PROJECT_ID} --format json | jq -r .projectNumber)
ZONE=us-central1-a
CLOUD_BUILD_SA="serviceAccount:${PROJECT_NUM}@cloudbuild.gserviceaccount.com"
GKE_PROD_CLUSTER_NAME=cymbal-bank-dev
GSR_REPO_NAME=cymbal-bank-repo
TRIGGER_NAME="deploy-cymbal-k8s-dev"
BUILD_CONFIG_FILE="cloud-build-dev.yaml"

# This isn't needed because we gave permissions in Step 11 already
# # give cloud build SA permissions to deploy to GKE
# gcloud projects add-iam-policy-binding $PROJECT_ID \
#   --member="${CLOUD_BUILD_SA}" \
#   --role="roles/container.admin"

# You need to create a 'cymbal-dev' branch on the GSR repo
# git checkout -b cymbal-dev --track origin/cymbal-dev
# git push

# NOTE !!!!!!!!!!!!!!!!!!!!
# Make sure that cloud-build-dev.yaml is in the root of the GSR repo or this trigger won't find it
# Make sure that cloud-build-dev.yaml is on the cymbal-dev branch
# --------------------------

# set up the cloud build trigger to run on everything that gets checked into main
gcloud builds triggers create cloud-source-repositories --name=$TRIGGER_NAME \
  --build-config=$BUILD_CONFIG_FILE \
  --repo=$GSR_REPO_NAME \
  --branch-pattern="^cymbal-dev$"

# NOTE !!!!!!!!!!!!!!!!!!!!
# Make sure that the v2 version of frontend.yaml is in the GSR or it will fail
# --------------------------
