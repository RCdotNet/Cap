#!/usr/bin/env bash

./create-stack.sh cluster file-cluster.json parameters.json
aws cloudformation wait stack-create-complete --stack-name cluster

./create-stack.sh nodes file-node.json parameters.json
aws cloudformation wait stack-create-complete --stack-name nodes

aws eks update-kubeconfig --name capstonecluster

kubectl apply -f deployment/deploymet.yml
kubectl apply -f deployment/load-balancer.yml

kubectl rollout status deployment/projectcapstone
kubectl get service