#!/bin/bash

# Common configuration
read -p "Enter registry: " registry
read -p "Enter tag: " tag
read -p "Enter namespace: " namespace
read -p "Enter dbhost: " dbhost
read -p "Enter dbname: " dbname
read -p "Enter dbusername: " dbusername
read -p "Enter dbpassword: " dbpassword
read -p "Enter appinsightsconnectionstring: " appinsightsconnectionstring

# create namespace
kubectl create namespace $namespace

dbpassword=$(echo -n $dbpassword | base64 -w0)
appinsightsconnectionstring=$(echo -n $appinsightsconnectionstring | base64 -w0)

sed -e 's|#dbhost#|'$dbhost'|g' \
    -e 's|#dbname#|'$dbname'|g' \
    -e 's|#dbpassword#|'$dbpassword'|g' \
    -e 's|#dbusername#|'$dbusername'|g' \
    -e 's|#appinsightsconnectionstring#|'$appinsightsconnectionstring'|g' \
    k8s/common.yaml \
    | kubectl apply -f - -n $namespace

# List of services
services=("spring-petclinic-customers-service" "spring-petclinic-vets-service" "spring-petclinic-visits-service" "spring-petclinic-api-gateway")

for service in "${services[@]}"
do
    IMAGE="$registry/$service:$tag"
    echo "Deploying $service with image $IMAGE"
    
    # clean service variable removing the prefix spring-petclinic-
    servicesanitized=$(echo $service | sed 's/spring-petclinic-//g')

    sed -e 's|#image#|'$IMAGE'|g' -e \
        's|#appname#|'$servicesanitized'|g' \
        src/$service/k8s/application.yaml \
        | kubectl apply -f - -n $namespace
done

