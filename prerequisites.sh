#!/usr/bin/env bash
set -ex
sudo -v
DIR="$(realpath "$(dirname $0)")"
sudo apt autoremove -y --purge unattended-upgrades
sudo apt update
sudo apt upgrade -y
sudo apt install -y git ansible docker.io docker-buildx python3-pip make lolcat byobu curl
sudo ln -sf /usr/games/lolcat /usr/local/bin/

python3 -m pip install docker

curl -fsSL https://falco.org/repo/falcosecurity-packages.asc | \
  sudo gpg --yes --dearmor -o /usr/share/keyrings/falco-archive-keyring.gpg
sudo apt install -y falco

git -C ~/ clone https://github.com/edenberger/redk8s ||:

cp -f $DIR/kind/kind /usr/local/bin/

kind create cluster
kind delete cluster --name kind
