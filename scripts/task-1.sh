#! /bin/bash
# create a single node cluster for processing migration
gcloud container clusters create m4a-processing \
    --num-nodes=1 \
    --zone=us-central1-a