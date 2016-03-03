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
SIM_HEADING="Simulation set 1"

source $simpath/$STAGE_PATH/includes/includes.sh

pause "Please ensure setup has been run; simulation "

set +e
clear
start_message "${SIM_HEADING}"

# Get lock status of the phone
let test_id=test_id+1
do_get "" \
       $phonePort \
       "/v1_00/config/lock" \
       "Get the current lock status of the phone" \
       $test_id

# Lock the phone
let test_id=test_id+1
export data=""
do_post "${data}" \
         $phonePort \
         "/v1_00/config/lock" \
         "Send an SMS Message to the phone" \
         $test_id

# Send an SMS Message to the phone
let test_id=test_id+1
export data='{'$phoneKey', "sender":"SMS", "message":"This is a text message received via SMS", "action":"open"}'
do_post "${data}" \
         $phonePort \
         "/v1_00/notification" \
         "Send an SMS Message to the phone" \
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

# Validate Grindr is being monitored
let test_id=test_id+1
export data='{'$genKey'}'
do_get "${data}" \
       $monitorPort \
       "/v1_00/app/grindr" \
       "Validate Grindr is being monitored" \
        $test_id

# Configure ManHunt as a monitored application
let test_id=test_id+1
export data='{'$genKey', "description":"ManHunt is a location based app for men seeking men"}'
do_post "${data}" \
        $monitorPort \
        "/v1_00/app/manhunt" \
        "Configure ManHunt as a monitored application" \
        $test_id

# Launch the Facebook client - A Notification will NOT be issued
let test_id=test_id+1
export data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/v1_00/config/launch/facebook" \
        "Launch the Facebook client - A Notification will NOT be issued" \
        $test_id

# Launch Grindr - A Notification will be issued
let test_id=test_id+1
export data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/v1_00/config/launch/grindr" \
        "Launch Grindr - A Notification will be issued" \
        $test_id

# Launch the phone mail client - A Notification will NOT be issued
let test_id=test_id+1
export data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/v1_00/config/launch/mailclient" \
        "Launch the phone mail client - A Notification will NOT be issued" \
        $test_id

# Send a text message to the phone
let test_id=test_id+1
export data='{'$phoneKey', "sender":"SMS", "message":"Can you pick me up at Starbucks, please? Its the one at Clair and Gordon. Thanks John.", "action":"open"}'
do_post "${data}" \
        $phonePort \
        "/v1_00/notification" \
        "Send a text message to the phone" \
        $test_id

# Stop monitoring Grindr
let test_id=test_id+1
export data='{'$genKey'}'
do_delete "${data}" \
          $monitorPort \
          "/v1_00/app/grindr" \
          "Stop monitoring Grindr" \
          $test_id

# Validate Grindr is no longer being monitored
let test_id=test_id+1
export data='{'$genKey'}'
do_get "${data}" \
       $monitorPort \
       "/v1_00/app/grindr" \
       "Validate Grindr is no longer being monitored. Monitor_App returns 404" \
        $test_id

# Launch Grindr - A Notification will NOT be issued
let test_id=test_id+1
export data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/v1_00/config/launch/grindr" \
        "Launch Grindr - A Notification will NOT be issued" \
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

