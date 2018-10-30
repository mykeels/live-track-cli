#!/bin/bash

# Provided a valid username (email) and password exists for live-track.net, 
# this script will echo a PHPSESSID

if [ -z "$LIVETRACK_USERNAME" ]
then
    read -p "Enter Login Username: " LIVETRACK_USERNAME
fi

if [ -z "$LIVETRACK_PASSWORD" ]
then
    read -s -p "Enter Password: " LIVETRACK_PASSWORD
    echo "*****"
fi

CMD="cmd=login&username=$LIVETRACK_USERNAME&password=$LIVETRACK_PASSWORD&remember_me=false&mobile=false"

export PHPSESSID=$(curl -s -d "$CMD" -X POST -c - https://live-track.net/func/fn_connect.php | 
    grep -e "PHPSESSID" | 
    sed -n -e 's/^.*PHPSESSID[[:space:]]*//p')

echo $PHPSESSID
