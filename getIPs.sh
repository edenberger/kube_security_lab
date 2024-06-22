#!/usr/bin/env bash

for pod in $(kind get clusters) ; do

  echo $pod: $(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ${pod}-control-plane)

done
