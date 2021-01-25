#!/bin/bash

# start up running network
function networkUp() {
    kubectl create -f ./node-exporter.yaml
	# sudo kubectl apply -f ./prometheus
	kubectl create -f ./prometheus/blackbox-exporter.yaml
	kubectl create -f ./prometheus/rbac-setup.yaml
	kubectl create -f ./prometheus/configmap.yaml
	kubectl create -f ./prometheus/prometheus.svc.yml
	kubectl create -f ./prometheus/prometheus.deploy.yml
	# sudo kubectl apply -f ./grafana
	kubectl create -f ./grafana/grafana-svc.yaml
	kubectl create -f ./grafana/grafana-ing.yaml
	kubectl create -f ./grafana/grafana-volume.yaml
	kubectl create -f ./grafana/grafana-deploy.yaml
	kubectl apply -f ./kube-state-metrics

}


# Tear down running network
function networkDown() {
    kubectl delete -f ./node-exporter.yaml
	# sudo kubectl delete -f ./prometheus
	kubectl delete -f ./prometheus/blackbox-exporter.yaml
	kubectl delete -f ./prometheus/rbac-setup.yaml
	kubectl delete -f ./prometheus/configmap.yaml
	kubectl delete -f ./prometheus/prometheus.deploy.yml
	kubectl delete -f ./prometheus/prometheus.svc.yml
	# sudo kubectl delete -f ./grafana
	kubectl delete -f ./grafana/grafana-svc.yaml
	kubectl delete -f ./grafana/grafana-ing.yaml
	kubectl delete -f ./grafana/grafana-volume.yaml
	kubectl delete -f ./grafana/grafana-deploy.yaml
	kubectl delete -f ./kube-state-metrics
}

function networkRestart() {
	networkDown
	networkUp
}

export MODE=$1

if [ "${MODE}" == "up" ]; then
    networkUp
elif [ "${MODE}" == "down" ]; then
    networkDown
elif [ "${MODE}" == "restart" ]; then
    networkRestart
else
    exit 1
fi