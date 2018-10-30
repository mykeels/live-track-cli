#!/bin/bash

# Using the $PHPSESSID variable exported by the login script, 
# get the location of all vehicles belonging to the login user account

. ./login.sh

CMD="cmd=load_object_data"
HEADERS="cookie: PHPSESSID=$PHPSESSID;"

OUTPUT=$(curl -s -d "$CMD" -H "$HEADERS" -X POST https://live-track.net/func/fn_objects.php)

NODE_SCRIPT="
    if (process.argv.length < 2) {
        throw new Error('no argument specified');
    }
    var contents = process.argv[1];
    var data = JSON.parse(contents);
    if (data) {
        Object.entries(data).map(([key, obj]) => {
            if (obj) {
                console.log('vehicle:', key)
                console.log('status:', obj.ststr)
                console.log('odometer:', obj.o, 'km')
                const inner = (obj.d[0] || [])
                console.log('latitude:', inner[2])
                console.log('longitude:', inner[3])
                console.log('map:', 'https://maps.google.com/maps?q=' + inner[2] + ',' + inner[3] + '&t=m')
            }
        })
    }

"

if [ -z "$OUTPUT" ]
then
    echo "no output"
    exit 1
else
    echo "--------------------------"
    node -e "$NODE_SCRIPT" "$OUTPUT"
fi
