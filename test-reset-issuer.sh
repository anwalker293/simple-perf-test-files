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
# 1 hour
reset_issuer 3600 "${workers1[@]}"

# 12 hours
reset_issuer 43200 "${workers1[@]}"

# 2 hours
reset_issuer 7200 "${workers1[@]}"

# 1 day
reset_issuer 86400 "${workers1[@]}"

# 6 hours
reset_issuer 21600 "${workers1[@]}"

# 4 hours
reset_issuer 14400 "${workers1[@]}"

# 8 hours
reset_issuer 28800 "${workers1[@]}"

# 3 days






