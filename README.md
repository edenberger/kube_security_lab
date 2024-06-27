# Kubernetes Local Security Testing Lab

The goal of this project is to make use of [Docker](https://www.docker.com) and specifically [kind](https://kind.sigs.k8s.io/) to create a lab environment for testing Kubernetes exploits and security tools entirely locally on a single machine without any requirement for remote resources or Virtual Machines being spun up.

To get the flexibility to set-up the various vulnerable clusters we're using [Ansible](https://www.ansible.com/) playbooks.

If you want to get an idea of how this works and where to start, there's an episode of [rawkode live](https://www.youtube.com/watch?reload=9&v=Srd1qqxDReA&t=6s) where we go through it all.

## Pre-requisites

The setup that worked for me (Eden) is:
- Ubuntu 20.04.6 LTS host
- 5.4.0-186-generic x86_64
- Docker version 24.0.7, build 24.0.7-0ubuntu2~20.04.1
- Ansible 2.9.6
- Kind version 0.11.1
- Docker python module (e.g. `python3 -m pip install docker`) version 7.1.0

* You can try the ```prerequisites.sh``` script (read it first), it might help with setting up the host machine.

## Getting Started

 1. Start up the vulnerable cluster you want to use, from the list below. At the end of the playbook you'll get an IP address for the cluster.
 2. Start the client machine container, and exec into a shell on it
 3. For the SSH clusters (the playbooks start ssh-to-*) SSH into a pod on the cluster with `ssh -p 32001 sshuser@[Kubernetes Cluster IP]` and a password of `sshuser`
 4. Attack away :)

More detailed explanations below.

## Client Machine

There's a client machine with tools for Kubernetes security testing which can be found [here](https://github.com/edenberger/redk8s).  
  
Note: to make the client machine in the same network with the kind clusters, use [these](https://github.com/edenberger/redk8s?tab=readme-ov-file#if-youre-running-it-for-the-lab-githubcomedenbergerkube_security_lab-after-you-set-up-the-lab-run) instructions to run it.

## Vulnerable Clusters

There's a number of playbooks which will bring up cluster's with a specific mis-configuration that can be exploited.

- `etcd-noauth.yml` - ETCD Server available without authentication
- `insecure-master-api-port.yml` - Kubernetes API Server Insecure Port available
- `rwkubelet-noauth.yml` - Kubelet Read-Write Port available without authentication
- `ssh-to-cluster-admin.yml` - Access to a running pod with a service account which has cluster-admin rights.
- `ssh-to-create-daemonsets-hard.yml`
- `ssh-to-create-pods-easy.yml` - Access to a running pod with a service account which has rights to manage pods.
- `ssh-to-create-pods-hard.yml` - Access to a running pod with a service account which has rights to create pods.
- `ssh-to-create-pods-multi-node.yaml`
- `ssh-to-get-secrets.yml` - Access to a running pod with a service account which has cluster level rights to get secrets.
- `ssrf-to-insecure-port.yml` - This cluster has a web application with an SSRF vulnerability in it, which can be exploited to target the insecure port.
- `unauth-api-server.yml` - API Server with anonymous access possible to sensitive paths.
- `unauth-kubernetes-dashboard.yml` - Cluster with the Kubernetes Dashboard installed and available without authentication.

## Using the clusters

Each of these can be used to try out various techniques for attacking Kubernetes clusters.  In general the goal of each exercise should be to get access to the `/etc/kubernetes/pki/ca.key` file as that's a ["golden key"](https://raesene.github.io/blog/2019/04/16/kubernetes-certificate-auth-golden-key/) to persistent cluster access.

For each cluster the place to start is in the `setupScenarios` which has details of how to get started.  

If you want some information on one possible solution look in the `walkthroughScenarios` folder

## Cleanup

To delete the clusters when you're finished with them you can use:

```bash
./delete_all.sh
```

## License
Original repo had no license, so I cannot assign one myself.  
But anyway, I am not responsible of any use or misuse of the software here (:  
