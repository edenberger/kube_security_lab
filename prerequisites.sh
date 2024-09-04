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

git -C ~/ clone https://github.com/edenberger/redk8s ||:

sudo cp -f $DIR/kind/kind /usr/local/bin/

sudo kind create cluster
sudo kind delete cluster --name kind
