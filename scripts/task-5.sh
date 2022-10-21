#! /bin/bash

# variables
PROJECT_ID=$(gcloud config get-value project)
CLUSTER_NAME=m4a-processing
ZONE=us-central1-a
SOURCE_NAME=m4a-source 
CE_SRC=m4a-ce-src
JOB_NAME=ledgermonolith-migration
VM_NAME=ledgermonolith-service

# download the migration plan
migctl migration get $JOB_NAME
exit 0

# edit $JOB_NAME.yaml and add in
# dataVolumes:
#   - folders:
#     - /var/lib/postgresql
printf 'edit yaml here...\n'

# update the revised plan
migctl migration update $JOB_NAME --file $JOB_NAME.yaml

# now generate artifacts
migctl migration generate-artifacts $JOB_NAME

# check status once before we finish
printf 'Checking status with this command line:\n'
printf "> migctl migration status $JOB_NAME\n"
migctl migration status $JOB_NAME