#!/bin/bash

ramp=0
workers13=(1 3)
workers35=(3 5)
workers1=(1)
workers5=(5)
workers3=(3)

function automate_issue_cred () {
  	# Takes in , duration (1), string to echo (2), workers (3+)
  	duration=$1 && shift
  	string=$1 && shift
  	echo "Starting ${string}"
  	amount_of_workers=("$@")
  	for item in "${amount_of_workers[@]}" 
	do
		touch present-proof-${ramp}-${duration}-${item}.txt
		sudo docker compose -f perf-docker-compose.yml run perf molotov max_cred_issuance.py -s present_proof_existing_connection -w ${item} -d ${duration} -c --ramp-up ${ramp} --statsd --statsd-address tcp://statsd:8125 >&1 | tee present-proof-${ramp}-${duration}-${item}.txt
    		sleep 900
    		echo "Just finished with ${string}, downing issuer"
    		sleep 900
	done
}

# 12 hours
automate_issue_cred 43200 '12 Hours' "${workers1[@]}" 

# 1 hour
automate_issue_cred 3600 '1 Hour' "${workers1[@]}" 

# 6 hours
automate_issue_cred 21600 '6 Hours' "${workers1[@]}" 

# 2 hours
automate_issue_cred 7200 '2 Hours' "${workers1[@]}" 

# 4 hours
automate_issue_cred 14400 '4 Hours' "${workers1[@]}" 
