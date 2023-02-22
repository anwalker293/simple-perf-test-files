#!/bin/bash

workers13=(1 3)
workers35=(3 5)
workers5=(5)
workers3=(3)

function reset_issuer () {
  # Takes in duration (1), workers (3+)
  duration=$1 && shift
  workers=("$@")
	for item in "${workers[@]}" 
	do
    		sleep ${duration}
    		sleep 450
    		sudo docker compose -f issuer-docker-compose.yml down -v
    		sudo docker compose -f issuer-docker-compose.yml up -d
     		sleep 450
    		sleep 900 
	done
}

reset_issuer 43200 "${workers35}"
reset_issuer 345600 "${workers13}"
reset_issuer 86400 "${workers35}"
reset_issuer 172800 "${workers5}"

