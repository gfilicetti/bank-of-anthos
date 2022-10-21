#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
ZONE=us-central1-a
GCS_BUCKET=bank-of-anthos-ci

# run deploy script
# since we are using the canonical bucket, all the build artifacts will already be there.
../src/ledgermonolith/scripts/deploy-monolith.sh