#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
GKE_PROD_CLUSTER_NAME=cymbal-bank-prod
GKE_DEV_CLUSTER_NAME=cymbal-bank-dev
ZONE=us-central1-a
CONTEXT_PROD=gke_l300-appmod-lab_us-central1-a_cymbal-bank-prod
CONTEXT_DEV=gke_l300-appmod-lab_us-central1-a_cymbal-bank-dev

# stop all application deployments to have the pods restart themselves
kubectl --context=$CONTEXT_PROD rollout restart deployment balancereader
kubectl --context=$CONTEXT_PROD rollout restart deployment contacts
kubectl --context=$CONTEXT_PROD rollout restart deployment frontend
kubectl --context=$CONTEXT_PROD rollout restart deployment ledgerwriter
kubectl --context=$CONTEXT_PROD rollout restart deployment loadgenerator
kubectl --context=$CONTEXT_PROD rollout restart deployment transactionhistory
kubectl --context=$CONTEXT_PROD rollout restart deployment userservice

# stop all application deployments to have the pods restart themselves
kubectl --context=$CONTEXT_DEV rollout restart deployment balancereader
kubectl --context=$CONTEXT_DEV rollout restart deployment contacts
kubectl --context=$CONTEXT_DEV rollout restart deployment frontend
kubectl --context=$CONTEXT_DEV rollout restart deployment ledgerwriter
kubectl --context=$CONTEXT_DEV rollout restart deployment loadgenerator
kubectl --context=$CONTEXT_DEV rollout restart deployment transactionhistory
kubectl --context=$CONTEXT_DEV rollout restart deployment userservice

# NOTE !!!!!!!!!!!!!!!!!!!!!!!!!
# Make sure to look at all the pods to see if they actually restarted.
# Restart manually any that weren't part of these deployments
# -------------------------------