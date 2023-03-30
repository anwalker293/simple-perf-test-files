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
		#touch issue-credential-${ramp}-${duration}-${item}.txt
		sudo docker compose -f perf-docker-compose.yml run perf molotov max_cred_issuance.py -s present_proof_existing_connection -w ${item} -d ${duration} --ramp-up ${ramp} 
		#>&1 | tee issue-credential-${ramp}-${duration}-${item}.txt
    		sleep 900
    		echo "Just finished with ${string}, downing issuer"
    		sleep 900
	done
}

# 5 days
automate_issue_cred 432000 '5 days' "${workers1[@]}" 

# 3 days
automate_issue_cred 259200 '3 days' "${workers1[@]}" 

# 4 days
automate_issue_cred 345600 '4 days' "${workers1[@]}" 

# 7 days
automate_issue_cred 604800 '7 days' "${workers1[@]}" 
