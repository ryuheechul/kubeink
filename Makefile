profile = kubectl-in-cluster

cluster-up:
	minikube -p $(profile) start
	minikube -p $(profile) addons enable metrics-server

stop-cluster:
	minikube stop -p $(profile)

delete-cluster: stop-cluster
	minikube delete -p $(profile)

use-context:
	kubectx $(profile)

teardown: destroy delete-cluster

oneshot-run: provision plan apply

provision: cluster-up use-context

plan: use-context
	cd terraform && make plan

apply: use-context
	cd terraform && make apply

destroy:
	cd terraform && make destroy
