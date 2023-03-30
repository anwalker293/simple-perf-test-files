#!/bin/bash

workers13=(1 3)
workers35=(3 5)
workers5=(5)
workers3=(3)
workers1=(1)

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

# fixing up for present proof
# 5 days
reset_issuer 432000 "${workers1[@]}"

# 3 days
reset_issuer 259200 "${workers1[@]}"

# 4 days
reset_issuer 345600 "${workers1[@]}"

# 7 days
reset_issuer 604800 "${workers1[@]}"






