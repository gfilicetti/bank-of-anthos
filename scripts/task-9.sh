#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
ZONE=us-central1-a
GSR_REPO_NAME=cymbal-bank-repo
GSR_REPO_URL=ssh://admin@ginof.altostrat.com@source.developers.google.com:2022/p/l300-appmod-lab/r/cymbal-bank-repo
GSR_REMOTE_NAME=gsr
GITHUB_REPO_URL=https://github.com/GoogleCloudPlatform/bank-of-anthos.git
APP_NAME=cymbal-bank

# create a new Cloud Source Repository
gcloud source repos create $GSR_REPO_NAME

# clone Bank app code repo
git clone $GITHUB_REPO_URL $APP_NAME

# Add the GSR as a remote to the cloned git repo
cd $APP_NAME
git remote add $GSR_REMOTE_NAME $GSR_REPO_URL

# Push the entire repo to this new remote so we have a copy in GSR
git push $GSR_REMOTE_NAME
