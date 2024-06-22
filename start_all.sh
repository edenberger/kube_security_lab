#!/usr/bin/env bash
#Original author : @mrintern

declare -a scenarios
scenarios=("etcd-noauth.yml" \
 "insecure-port.yml" \
 "rwkubelet-noauth.yml" \
 "ssh-to-cluster-admin.yml" \
 "ssh-to-create-daemonsets-hard.yml" \
 "ssh-to-create-pods-easy.yml" \
 "ssh-to-create-pods-hard.yml" \
 "ssh-to-create-pods-multi-node.yml" \
 "ssh-to-get-secrets.yml" \
 "ssrf-to-insecure-port.yml" \
 "unauth-api-server.yml" \
 "unauth-kubernetes-dashboard.yml")

for scenario in ${scenarios[@]}; do
  echo $scenario
  ansible-playbook $scenario
done
