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
SIM_HEADING="Simulation set 3"

source $simpath/$STAGE_PATH/includes/includes.sh

pause "Please ensure setup has been run; simulation "

set +e
clear
start_message "${SIM_HEADING}"

set +e
# Get the app_msg
let test_id=test_id+1
do_get "" \
       $monitorPort \
       "/v1_00/config/message/app_msg" \
       "Get the message shown when a monitored app launch is detected" \
       $test_id

# Delete the app_msg to reset it
let test_id=test_id+1
export data='{'$genKey'}'
do_delete "${data}" \
          $monitorPort \
          "/v1_00/config/message/app_msg" \
          "Reset the message shown when a monitored app launch is detected" \
          $test_id

# Get the app_msg
let test_id=test_id+1
do_get "" \
       $monitorPort \
       "/v1_00/config/message/app_msg" \
       "Get the message shown when a monitored app launch is detected" \
       $test_id

# Set the app_msg
let test_id=test_id+1
export data='{'$genKey', "message-text":"Hey Jing! Ring, ring!"}'
do_put "${data}" \
       $monitorPort \
       "/v1_00/config/message/app_msg" \
       "Set the message shown when a monitored app launch is detected" \
       $test_id

# Get the app_msg
let test_id=test_id+1
do_get "" \
       $monitorPort \
       "/v1_00/config/message/app_msg" \
       "Get the current message shown when an app is detected" \
       $test_id

# Get lock status of the phone
let test_id=test_id+1
do_get "" \
       $phonePort \
       "/v1_00/config/lock" \
       "Get the current lock status of the phone" \
       $test_id

# Unlock the phone
let test_id=test_id+1
export data='{'$genKey'}'
do_put "${data}" \
       $phonePort \
       "/v1_00/config/unlock" \
       "Ensure the phone is unlocked" \
       $test_id

# Connect to Monitor App
let test_id=test_id+1
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

# Configure Grindr as a monitored application
let test_id=test_id+1
export data='{'$genKey', "description":"Grindr is an app for men seeking men"}'
do_post "${data}" \
        $monitorPort \
        "/v1_00/app/grindr" \
        "Configure Grindr as a monitored application" \
        $test_id

# Launch Grindr - A Notification will be issued
let test_id=test_id+1
export data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/v1_00/config/launch/grindr" \
        "Launch Grindr - A Notification will be issued" \
        $test_id

# Stop monitoring Grindr
let test_id=test_id+1
export data='{'$genKey'}'
do_delete "${data}" \
          $monitorPort \
          "/v1_00/app/grindr" \
          "Stop monitoring Grindr" \
          $test_id

# Disconnect the Monitor App
let test_id=test_id+1
export data='{'$genKey'}'
do_delete "${data}" \
           $phonePort \
           "/v1_00/config/monitor" \
           "Connect to Monitor App. " \
           $test_id

# Save logs
finalize

stop_message "${SIM_HEADING}"

