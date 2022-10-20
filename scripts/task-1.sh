#! /bin/bash
gcloud container clusters create m4a-processing \
    --num-nodes=1 \
    --region=us-central1 \
    --zone=us-central1-a