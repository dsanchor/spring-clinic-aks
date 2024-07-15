#!/bin/bash

# Read parameters from input
registry="$1"
tag="$2"
namespace="$3"

# List of services
services=("spring-petclinic-customers-service" "spring-petclinic-vets-service" "spring-petclinic-visits-service" "spring-petclinic-api-gateway" "spring-petclinic-admin-server")

for service in "${services[@]}"
do
    IMAGE="$registry\/$service:$tag"
    echo "Deploying $service with image $IMAGE"
    
    sed -e 's/#image#/'$IMAGE'/g' -e \
        's/#appname#/'$service'/g' \
        src/$service/k8s/application.yaml \
        | kubectl apply -f - -n $namespace
done

