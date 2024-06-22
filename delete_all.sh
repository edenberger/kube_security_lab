#!/usr/bin/env bash

for c in $(kind get clusters); do

  kind delete cluster --name $c

done
