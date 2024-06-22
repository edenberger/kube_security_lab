#!/usr/bin/env bash
set -ex
apt autoremove -y --purge unattended-upgrades
apt update
apt upgrade -y
apt install -y git ansible docker.io docker-buildx python3-pip make lolcat byobu
ln -sf /usr/games/lolcat /usr/local/bin/

python3 -m pip install docker

curl -fsSL https://falco.org/repo/falcosecurity-packages.asc | \
  sudo gpg --yes --dearmor -o /usr/share/keyrings/falco-archive-keyring.gpg
sudo apt install -y falco

git -C ~/ clone https://github.com/edenberger/redk8s ||:

cp -f ~/kube_security_lab/kind/kind /usr/local/bin/

kind create cluster
kind delete cluster --name kind
