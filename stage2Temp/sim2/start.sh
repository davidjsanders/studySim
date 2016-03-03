#!/bin/bash
#References
# http://stackoverflow.com/questions/2924697/how-does-one-output-bold-text-in-bash
# http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-7.html
#
#set -o verbose

if [ "X"$simpath == "X" ]; then
    echo "ERROR: simpath is not defined!"
    echo ""
    echo "Before running this script, ensure that simpath is defined:"
    echo ""
    echo "  export simpath=/path/to/studySim"
    echo
    exit 1
fi

STAGE_PATH="stage2"
STAGE=$STAGE_PATH"_"
SIM_HEADING="Simulation set 2"

source $simpath/$STAGE_PATH/includes/includes.sh

pause "Please ensure setup has been run; simulation "

set +e
clear
start_message "${SIM_HEADING}"

# Connect to Monitor App
((test_id++))
export monitor_app='"monitor-app":"'$serverIPName':'$monitorPort'/v1_00"'
export service='"notification-service":"'$serverIPName':'$notesvcPort'/v1_00/notification"'
export recipient='"recipient":"'$serverIPName':'$phonePort'/v1_00/notification"'
export location='"location-service":"'$serverIPName':'$locPort'/v1_00/check"'
export provider='"location-provider":"'$serverIPName':'$phonePort'/v1_00/location"'
export data='{'$genKey', '$monitor_app', '$service', '$recipient', '$location', '$provider'}'
do_post "${data}" \
        $phonePort \
        "/v1_00/config/monitor" \
        "Connect to Monitor App. " \
        $test_id

# Define a location hot spot called downtown from 50,50 to 200,200
((test_id++))
export data='{'$genKey', "description":"The downtown hotspot", "lower-x":50, "lower-y":50, "upper-x":200, "upper-y":200}'
do_post "${data}" \
        $locPort \
        "/v1_00/config/hotspot/downtown" \
        "Define a location hot spot called downtown from 50,50 to 200,200" \
        $test_id

# Validate the hotspot downtown has been created
((test_id++))
export data='{'$genKey'}'
do_get "${data}" \
       $locPort \
       "/v1_00/config/hotspot/downtown" \
       "Validate the hotspot downtown has been created" \
        $test_id

# Set the phone current location to 100,100
((test_id++))
export data='{'$genKey', "x":100, "y":100}'
do_post "${data}" \
        $phonePort \
        "/v1_00/config/location" \
        "Set the phone current location to 100,100 (Notifications WILL be raised)" \
        $test_id

# Pause for 1 minute
echo "The phone will detect the location at the next timer check (every 30 seconds)"
echo "So sleep for 1 minute before setting the location out of a hotspot"
sleep 60

echo ""
# Set the phone current location to 1000,100
((test_id++))
export data='{'$genKey', "x":1000, "y":100}'
do_post "${data}" \
        $phonePort \
        "/v1_00/config/location" \
        "Set the phone current location to 1000,100 (Notifications WILL NOT be raised)" \
        $test_id

# Pause for 1 minute
echo "The phone will detect the location at the next timer check (every 30 seconds)"
echo "So sleep for 1 minute to allow detection of being out of the hotspot"
sleep 60

# Disconnect the Monitor App
((test_id++))
export data='{'$genKey'}'
do_delete "${data}" \
           $phonePort \
           "/v1_00/config/monitor" \
           "Connect to Monitor App. " \
           $test_id

# Save logs
finalize

stop_message "${SIM_HEADING}"

