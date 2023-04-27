#!/bin/bash

ramp=0
workers13=(1 3)
workers35=(3 5)
workers5=(5)
workers1=(1)

function automate_issue_cred () {
	# Takes in , duration (1), string to echo (2), rate per second (3), workers (4+)
	duration=$1 && shift
	string=$1 && shift
	rate=$1 && shift
	echo "Starting ${string}"
	amount_of_workers=("$@")
	for item in "${amount_of_workers[@]}" 
	do
		touch issue-credential-${rate}-${duration}-${item}.txt
		sudo docker compose -f perf-docker-compose.yml run perf molotov --delay ${rate} max_cred_issuance.py -s issue_credential_new_connection -w ${item} -d ${duration} -c
		#>&1 
		#| tee issue-credential-${rate}-${duration}-${item}.txt    
		sleep 900
		echo "Just finished with ${rate}, downing issuer"
		sleep 900
	done
}

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 0.4 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 0.35 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 0.5 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 0.7 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 0.3 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 0.9 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 0.25 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 1 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 0.2 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 2 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 0.15 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 5 "${workers1[@]}"

# All running for 8 hours 
automate_issue_cred 28800 '8 Hours' 0.1 "${workers1[@]}"
