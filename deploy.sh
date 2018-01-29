#!/bin/bash

set -e

if [ -z "$PROJECT_ID" ]; then
    echo """
    [ERROR] please set env PROJECT_ID
    export PROJECT_ID=your_project_id
    """
    exit 1
fi

if [ -z "$1" ]; then
    echo """
    [ERROR] no version args
    ./deploy.sh <version>
    """
    exit 1
fi

export APP_VERSION=$1

# docker build & push
docker build -t gcr.io/${PROJECT_ID}/gke-training:v${APP_VERSION} .
gcloud docker -- push gcr.io/${PROJECT_ID}/gke-training:v${APP_VERSION}

# generate k8s yaml files
mkdir tmp
for f in k8s/*.yaml
do
    envsubst < $f > tmp/run-$(basename $f)
done

# deploy
kubectl apply -f tmp/run-service.yaml
kubectl apply -f tmp/run-deployment.yaml --record

rm -rf tmp/
