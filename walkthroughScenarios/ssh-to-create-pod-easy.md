# SSH to Create Pod - Easy

### Compromising the cluster

This scenario begins with ssh access to a pod. The ssh credentials can be found in the scenario setup.

1. `kubectl get po -n kube-system` will fail (user doesn't have those rights)
2. `kubectl get po` will work and give you a list of pods in the default namespace
3. We check our permissions using `kubectl auth can-i --list` and notice we can create pods

At this point there's several ways to achieve the goal, lets go with hostpath

4. To create a malicious pod, we need a malicious pod manifest. Let's copy `key-dumper-pod.yml` from `kube_security_lab/attacker_manifests/` and paste it into a file in our ssh session called `key-dumper-pod.yml`
3. Now we can create a pod that dumps out the PKI private key `kubectl create -f /key-dumper-pod.yml`
4. and the key should be in the logs `kubectl logs keydumper-pod`
5. profit!
