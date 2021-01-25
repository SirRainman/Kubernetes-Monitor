.PHONY: up down
up:
	kubectl create -f ./node-exporter.yaml
	# sudo kubectl apply -f ./prometheus
	kubectl create -f ./prometheus/rbac-setup.yaml
	kubectl create -f ./prometheus/configmap.yaml
	kubectl create -f ./prometheus/prometheus.deploy.yml
	kubectl create -f ./prometheus/prometheus.svc.yml
	# sudo kubectl apply -f ./grafana
	kubectl create -f ./grafana/grafana-deploy.yaml
	kubectl create -f ./grafana/grafana-svc.yaml
	kubectl create -f ./grafana/grafana-ing.yaml
	kubectl apply -f ./kube-state-metrics

down:
	kubectl delete -f ./node-exporter.yaml
	# sudo kubectl delete -f ./prometheus
	kubectl delete -f ./prometheus/rbac-setup.yaml
	kubectl delete -f ./prometheus/configmap.yaml
	kubectl delete -f ./prometheus/prometheus.deploy.yml
	kubectl delete -f ./prometheus/prometheus.svc.yml
	# sudo kubectl delete -f ./grafana
	kubectl delete -f ./grafana/grafana-deploy.yaml
	kubectl delete -f ./grafana/grafana-svc.yaml
	kubectl delete -f ./grafana/grafana-ing.yaml
	kubectl delete -f ./kube-state-metrics
