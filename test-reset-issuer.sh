#!/bin/bash

workers13=(1 3)
workers35=(3 5)

function reset_issuer () {
  # Takes in duration (1), workers (3+)
  duration=$1 && shift
  workers=("$@")
	for item in "${workers[@]}" 
	do
    echo sleep ${duration}
    echo sleep 450
    echo sudo docker compose -f issuer-docker-compose.yml down -v
    echo sudo docker compose -f issuer-docker-compose.yml up -d
    echo sleep 450
    echo sleep 900 
	done
}

reset_issuer 43200 "${workers35}"
reset_issuer 345600 "${workers13}"
reset_issuer 86400 "${workers35}"
reset_issuer 172800 "${workers5}"

