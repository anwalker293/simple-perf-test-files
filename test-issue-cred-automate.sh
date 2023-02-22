#!/bin/bash

ramp=0
workers13=(1 3)
workers35=(3 5)
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
		touch issue-credential-${ramp}-${1}-${item}.txt
		sudo docker compose -f perf-docker-compose.yml run perf molotov max_cred_issuance.py -s issue_credential_new_connection -w ${item} -d ${1} --ramp-up ${ramp} --statsd --statsd-address tcp://statsd:8125 >&1 | tee issue-credential-${ramp}-${1}-${item}.txt
    		sleep 900
    		echo "Just finished with ${string}, downing issuer"
    		sleep 900
	done
}

# 12 hours (3,5)
automate_issue_cred 43200 '12 Hours' "${workers35[@]}" 
#4 Days (1 worker, 3 workers)
automate_issue_cred 345600 '4 days' "${workers13[@]}"
#1 day (3, 5 workers)
automate_issue_cred 86400 '1 day' "${workers35[@]}"
#2 days (5 workers)
automate_issue_cred 172800 '2 days' "${workers5[@]}"
