#!/bin/bash

# start up running network
function networkUp() {
    kubectl create -f ./k8sDashboard.yaml
    kubectl create -f ./auth.yaml
}


# Tear down running network
function networkDown() {
    kubectl delete -f ./k8sDashboard.yaml
	kubectl delete -f ./auth.yaml
}

# print token to login
function printToken() {
    kubectl -n kubernetes-dashboard describe secret $(kubectl -n kubernetes-dashboard get secret | grep admin-user | awk '{print $1}')
}

export MODE=$1

if [ "${MODE}" == "up" ]; then
    networkUp
elif [ "${MODE}" == "down" ]; then
    networkDown
elif [ "${MODE}" == "token" ]; then
    printToken
else
    exit 1
fi
