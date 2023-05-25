#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUM=$(gcloud projects describe ${PROJECT_ID} --format json | jq -r .projectNumber)
ZONE=us-central1-a
CLOUD_BUILD_SA='${PROJECT_NUM}@cloudbuild.gserviceaccount.com'
GKE_PROD_CLUSTER_NAME=cymbal-bank-prod
GKE_PROD_NODES=4
CHANNEL=stable
CP_VERSION=1.23
NODE_VM_TYPE=e2-standard-4

GSR_REPO_NAME=cymbal-bank-repo
GSR_REPO_URL=ssh://admin@ginof.altostrat.com@source.developers.google.com:2022/p/l300-appmod-lab/r/cymbal-bank-repo
GSR_REMOTE_NAME=gsr
GITHUB_REPO_URL=https://github.com/GoogleCloudPlatform/bank-of-anthos.git
GITHUB_REPO_DIR=cymbal-bank-github

echo $CLOUD_BUILD_SA






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
