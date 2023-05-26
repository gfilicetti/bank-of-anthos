#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
ZONE=us-central1-a
GKE_PROD_CLUSTER_NAME=cymbal-bank-prod
GKE_DEV_CLUSTER_NAME=cymbal-bank-dev
NAMESPACE=default

# get kubectl context for this cluster
gcloud container clusters get-credentials $GKE_PROD_CLUSTER_NAME \
  --project=$PROJECT_ID --zone=$ZONE

function join_by { local IFS="$1"; shift; echo "$*"; }

ALL_CLUSTER_CIDRS=$(gcloud container clusters list --project $PROJECT_1 --format='value(clusterIpv4Cidr)' | sort | uniq)
ALL_CLUSTER_CIDRS=$(join_by , $(echo "${ALL_CLUSTER_CIDRS}"))
ALL_CLUSTER_NETTAGS=$(gcloud compute instances list --project $PROJECT_1 --format='value(tags.items.[0])' | sort | uniq)
ALL_CLUSTER_NETTAGS=$(join_by , $(echo "${ALL_CLUSTER_NETTAGS}"))

printf "$ALL_CLUSTER_CIDRS\n"
printf "$ALL_CLUSTER_NETTAGS\n"