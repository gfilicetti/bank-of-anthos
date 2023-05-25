#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUM=$(gcloud projects describe ${PROJECT_ID} --format json | jq -r .projectNumber)
ZONE=us-central1-a
CLOUD_BUILD_SA="serviceAccount:${PROJECT_NUM}@cloudbuild.gserviceaccount.com"
TRIGGER_NAME="deploy-cymbal-k8s"
GKE_PROD_CLUSTER_NAME=cymbal-bank-prod
GSR_REPO_NAME=cymbal-bank-repo

GSR_REPO_URL=ssh://admin@ginof.altostrat.com@source.developers.google.com:2022/p/l300-appmod-lab/r/cymbal-bank-repo
GSR_REMOTE_NAME=gsr
GITHUB_REPO_URL=https://github.com/GoogleCloudPlatform/bank-of-anthos.git
GITHUB_REPO_DIR=cymbal-bank-github

# give cloud build SA permissions to deploy to GKE
gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="${CLOUD_BUILD_SA}" \
  --role="roles/container.admin"

# NOTE !!!!!!!!!!!!!!!!!!!!
# Make sure that cloud-build.yaml is in the root of the GSR repo or this trigger won't find it
# --------------------------

# set up the cloud build trigger to run on everything that gets checked into main
gcloud builds triggers create cloud-source-repositories --name=$TRIGGER_NAME \
  --build-config="cloud-build.yaml" \
  --repo=$GSR_REPO_NAME \
  --branch-pattern="^main$"



# GKE_PROD_NODES=4
# CHANNEL=stable
# CP_VERSION=1.23
# NODE_VM_TYPE=e2-standard-4

# GSR_REPO_NAME=cymbal-bank-repo
# GSR_REPO_URL=ssh://admin@ginof.altostrat.com@source.developers.google.com:2022/p/l300-appmod-lab/r/cymbal-bank-repo
# GSR_REMOTE_NAME=gsr
# GITHUB_REPO_URL=https://github.com/GoogleCloudPlatform/bank-of-anthos.git
# GITHUB_REPO_DIR=cymbal-bank-github

# # create a new GKE cluster according to specs
# gcloud container clusters create $GKE_PROD_CLUSTER_NAME \
#   --project=$PROJECT_ID --zone=$ZONE \
#   --machine-type=$NODE_VM_TYPE --num-nodes=$GKE_PROD_NODES \
#   --release-channel=$CHANNEL --cluster-version=$CP_VERSION \
#   --monitoring=SYSTEM --logging=SYSTEM,WORKLOAD --subnetwork=default \
#   --tags=$GKE_PROD_CLUSTER_NAME --labels csm=

# # get kubectl context for this cluster
# gcloud container clusters get-credentials $GKE_PROD_CLUSTER_NAME \
#   --project=$PROJECT_ID --zone=$ZONE

# # move in the manually created v1 of the deployment
# mv ../kubernetes-manifests/frontend.yaml kubernetes-manifests/frontend.orig.yaml 
# cp ../kubernetes-manifests/frontend.v1.yaml kubernetes-manifests/frontend.yaml 

# # deploy the application to the cluster
# kubectl apply -f ../extras/jwt/jwt-secret.yaml
# kubectl apply -f ../kubernetes-manifests

# # NOTE !!!!!!!!!!!!
# # Run 'kubectl get pods' and make sure they're all started
# # Then run "kubectl get service frontend | awk '{print $4}'" to get the IP address
# # ------------------
