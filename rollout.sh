#!/usr/bin/env bash
kubectl config current-context
kubectl config get-contexts
kubectl apply -f deployment/deployment.yml
#kubectl get deployment capstone-$target -o=yaml | sed -e "s/$target/$appver/g" | kubectl apply -f - 
kubectl rollout status deployment/projectcapstone
