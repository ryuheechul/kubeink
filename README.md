# kubeink
> kubectl in kuberntes cluster

## What it is and How it works
- this is more of a demonstration than anything
- it aims to show what needs to be done for kubectl to work inside a pod to talk to its own cluster
- it generates kube config (`.kube/config`) with kubectl itself
- it uses minikube and terraform to codify things to bd deployed

## How to

### run
`$ make provision && make apply`

### teardown
`$ make teardown`
