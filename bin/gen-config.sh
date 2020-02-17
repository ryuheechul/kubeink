#!/usr/bin/env sh

kubeink_name=${1:-"kubeink"}

kubectl config set-cluster $kubeink_name --server=https://${KUBERNETES_SERVICE_HOST} --certificate-authority=${KUBERNETES_SA_CA_CERT}

kubectl config set-credentials $kubeink_name --token=$(cat ${KUBERNETES_SA_TOKEN})

kubectl config set-context $kubeink_name --cluster=${kubeink_name} --user=${kubeink_name}
kubectl config use-context $kubeink_name

