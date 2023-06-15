#!/bin/bash

sudo docker-compose build && sudo docker-compose up -d

echo "Make sure to up everything by hand."
echo "Run a preliminary test first."
echo "Continue when you are ready."
read status

users_per_second=(1 1 1 2 3 4 5)
durations=(1 5 15 30 45 60) # minutes
peaks=(1 2 3 4 5)

for peak in "${peaks[@]}" 
	do
    for duration in "${durations[@]}"
      do
        for rate in "${users_per_second[@]}"
          do
            # Let the test run
            duration_seconds = $((duration * 60))
            sleep ${duration_seconds}
            # Let test wrap up
            sleep 60 
            sleep 450
            sudo docker-compose down -v && sudo docker-compose build && sudo docker-compose up -d
            sleep 400
            sleep 900
          done
      done
done

