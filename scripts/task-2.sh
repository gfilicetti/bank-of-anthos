#! /bin/bash

PROJECT_ID=$(gcloud config get-value project)
printf '${PROJECT_ID}\n'
exit 0

# create a service account for migrate
gcloud iam service-accounts create m4a-install

# give the service account storage admin rights
gcloud projects add-iam-policy-binding ${PROJECT_ID}  \
  --member="serviceAccount:m4a-install@${PROJECT_ID}.iam.gserviceaccount.com" \
  --role="roles/storage.admin"