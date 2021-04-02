# Kubernetes Local Security Testing Lab

The goal of this project is to make use of [Docker](https://www.docker.com) and specifically [kind](https://kind.sigs.k8s.io/) to create a lab environment for testing Kubernetes exploits and security tools entirely locally on a single machine without any requirement for remote resources or Virtual Machines being spun up.

To get the flexibility to set-up the various vulnerable clusters we're using [Ansible](https://www.ansible.com/) playbooks.

## Pre-requisites

Before starting you'll need to install

- Docker
- Ansible
  - Also install the docker python module (e.g. `pip install docker` or `pip3 install docker`)
- Kind 0.8.0+ - Install guide [here](https://kind.sigs.k8s.io/docs/user/quick-start/)

If you're running Ubuntu 18.04, you can use the `install_ansible_ubuntu.sh` file to do the ansible setup. If you're running Ubuntu 20.04 then you can just get ansible from apt.

## Client Machine

There's a client machine with tools for Kubernetes security testing which can be brought up with the `client-machine.yml` playbook. It's best to use this client machine for all CLI tasks when running the scenarios, so you don't accidentally pick up creds from the host, but remember to start the kind cluster before the client machine, or the Docker network to connect to, may not be available.

- `ansible-playbook client-machine.yml`

Once you've run the playbook, you can connect to the client machine with:-

`docker exec -it client /bin/bash`

The machine should be on the `172.18.0.0/24` network with the kind clusters (as well as being on the Docker default bridge)

## Vulnerable Clusters

There's a number of playbooks which will bring up cluster's with a specific mis-configuration that can be exploited.

- `etcd-noauth.yml` - ETCD Server available without authentication
- `insecure-port.yml` - Kubernetes API Server Insecure Port available
- `rokubelet.yml`
- `rwkubelet-noauth.yml` - Kubelet Read-Write Port available without authentication
- `ssh-to-cluster-master.yml` - Access to a running pod with a service account which has cluster-admin rights.
- `ssh-to-create-daemonsets-hard.yml`
- `ssh-to-create-pods-easy.yml` - Access to a running pod with a service account which has rights to manage pods.
- `ssh-to-create-pods-hard.yml` - Access to a running pod with a service account which has rights to create pods.
- `ssh-to-create-pods-multi-node.yaml`
- `ssh-to-get-secrets.yml` - Access to a running pod with a service account which has cluster level rights to get secrets.
- `ssrf-to-insecure-port.yml` - This cluster has a web application with an SSRF vulnerability in it, which can be exploited to target the insecure port.
- `tiller-noauth.yml` - Tiller service configured without authentication.
- `unauth-api-server.yml` - API Server with anonymous access possible to sensitive paths.
- `unauth-kubernetes-dashboard.yml` - Cluster with the Kubernetes Dashboard installed and available without authentication.

## Using the clusters

Each of these can be used to try out various techniques for attacking Kubernetes clusters.  In general the goal of each exercise should be to get access to the `/etc/kubernetes/pki/ca.key` file as that's a ["golden key"](https://raesene.github.io/blog/2019/04/16/kubernetes-certificate-auth-golden-key/) to persistent cluster access.

For each cluster the place to start is in the `Scenario Setups` which has details of how to get started.  

If you want some information on one possible solution look in the `Scenario Walkthroughs` folder

## Cleanup

When you're finished with your cluster(s) just use

```bash
kind delete cluster --name=[CLUSTERNAME]
```

and

```bash
docker stop client
```

## Demo Setup

There's a specific pair of playbooks which can be useful for demonstrating Kubernetes vulnerabilities.  the `demo-cluster.yml` brings up a kind cluster with multiple vulnerabilities and the `demo-client-machine.yml` brings up a client container with the Kubernetes Kubeconfig for the demo cluster already installed.  For this pair, it's important to bring up the cluster before the client machine, so that the kubeconfig file is available to be installed.
