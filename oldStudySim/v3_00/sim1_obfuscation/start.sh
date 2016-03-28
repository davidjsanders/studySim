#!/bin/bash
#References
# http://stackoverflow.com/questions/2924697/how-does-one-output-bold-text-in-bash
# http://tldp.org/HOWTO/Bash-Prog-Intro-HOWTO-7.html
#
#set -o verbose

#
# Simulation Setup
#
if [ "X"$simpath == "X" ]; then
    echo "ERROR: simpath is not defined!"
    echo ""
    echo "Before running this script, ensure that simpath is defined:"
    echo ""
    echo "  export simpath=/path/to/studySim"
    echo
    exit 1
fi

stage_path="v3_00"

source $simpath/$stage_path/includes/check_params.sh

source $simpath/$stage_path/includes/_do_first.sh

#
# Simulation 1 Configuration
#
sim_heading="Simulation set 1 (with obfuscation) execution"

pause "Please ensure setup has been run; simulation "

set +e
clear
start_message "${sim_heading}"

# Get lock status of the phone
let test_id=test_id+1
do_get "" \
       $phonePort \
       "/"$presentAs"/config/lock" \
       "Get the current lock status of the phone" \
       $test_id

# Unlock the phone
let test_id=test_id+1
data='{'$genKey'}'
do_put "${data}" \
       $phonePort \
       "/"$presentAs"/config/unlock" \
       "Unlock the phone" \
       $test_id

# Send an SMS Message to the phone
let test_id=test_id+1
recipient='"recipient":"'$serverIPName':'$phonePort'/'$presentAs'/notification"'
sender='"sender":"SMS Service"'
action='"action":"Read Text"'
message='"message":"This is a text message received via SMS"'
data='{'$genKey', '$recipient', '$sender', '$action', '$message'}'
do_post "${data}" \
         $notesvcPort \
         "/"$presentAs"/notification" \
         "Send an SMS Message to the phone" \
         $test_id

# Connect to Monitor App
let test_id=test_id+1
monitor_app='"monitor-app":"'$serverIPName':'$monitorPort'/'$presentAs'"'
service='"notification-service":"'$serverIPName':'$notesvcPort'/'$presentAs'/notification"'
recipient='"recipient":"'$serverIPName':'$phonePort'/'$presentAs'/notification"'
location='"location-service":"'$serverIPName':'$locPort'/'$presentAs'/check"'
provider='"location-provider":"'$serverIPName':'$phonePort'/'$presentAs'/location"'
data='{'$genKey', '$monitor_app', '$service', '$recipient', '$location', '$provider'}'
do_post "${data}" \
        $phonePort \
        "/"$presentAs"/config/monitor" \
        "Connect to Monitor App. " \
        $test_id

# Configure Grindr as a monitored application
let test_id=test_id+1
data='{'$genKey', "description":"Grindr is an app for men seeking men"}'
do_post "${data}" \
        $monitorPort \
        "/"$presentAs"/app/grindr" \
        "Configure Grindr as a monitored application" \
        $test_id

# Validate Grindr is being monitored
let test_id=test_id+1
data='{'$genKey'}'
do_get "${data}" \
       $monitorPort \
       "/"$presentAs"/app/grindr" \
       "Validate Grindr is being monitored" \
        $test_id

# Configure ManHunt as a monitored application
let test_id=test_id+1
data='{'$genKey', "description":"ManHunt is a location based app for men seeking men"}'
do_post "${data}" \
        $monitorPort \
        "/"$presentAs"/app/manhunt" \
        "Configure ManHunt as a monitored application" \
        $test_id

# Lock the phone
let test_id=test_id+1
data=""
do_post "${data}" \
         $phonePort \
         "/"$presentAs"/config/lock" \
         "Lock the phone" \
         $test_id

# Launch the Facebook client - A Notification will NOT be issued
let test_id=test_id+1
data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/"$presentAs"/config/launch/facebook" \
        "Launch the Facebook client - A Notification will NOT be issued" \
        $test_id

# Launch Grindr - A Notification will be issued
let test_id=test_id+1
data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/"$presentAs"/config/launch/grindr" \
        "Launch Grindr - A Notification will be issued" \
        $test_id

# Launch the phone mail client - A Notification will NOT be issued
let test_id=test_id+1
data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/"$presentAs"/config/launch/mailclient" \
        "Launch the phone mail client - A Notification will NOT be issued" \
        $test_id

# Send an SMS Message to the phone
let test_id=test_id+1
recipient='"recipient":"'$serverIPName':'$phonePort'/'$presentAs'/notification"'
sender='"sender":"SMS Service"'
action='"action":"Read Text"'
message='"message":"Can you pick me up at Starbucks, please? Its the one at Clair and Gordon. Thanks John."'
data='{'$genKey', '$recipient', '$sender', '$action', '$message'}'
do_post "${data}" \
         $notesvcPort \
         "/"$presentAs"/notification" \
         "Send an SMS Message to the phone" \
         $test_id

# Stop monitoring Grindr
let test_id=test_id+1
data='{'$genKey'}'
do_delete "${data}" \
          $monitorPort \
          "/"$presentAs"/app/grindr" \
          "Stop monitoring Grindr" \
          $test_id

# Validate Grindr is no longer being monitored
let test_id=test_id+1
data='{'$genKey'}'
do_get "${data}" \
       $monitorPort \
       "/"$presentAs"/app/grindr" \
       "Validate Grindr is no longer being monitored. Monitor_App returns 404" \
        $test_id

# Launch Grindr - A Notification will NOT be issued
let test_id=test_id+1
data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/"$presentAs"/config/launch/grindr" \
        "Launch Grindr - A Notification will NOT be issued" \
        $test_id

# Bob can no longer see the screen
let test_id=test_id+1
pre_test $test_id "Bob leaves and can no longer see the phone screen."
stop_phone Bob

# Pause for 5 seconds to let the notification be detected
let test_id=test_id+1
pre_test $test_id "Sleeping for 5 seconds to persist notifications."
sleep 5
echo

# Unlock the phone
let test_id=test_id+1
data='{'$genKey'}'
do_put "${data}" \
       $phonePort \
       "/"$presentAs"/config/unlock" \
       "Unlock the phone" \
       $test_id

# Disconnect the Monitor App
let test_id=test_id+1
data='{'$genKey'}'
do_delete "${data}" \
           $phonePort \
           "/"$presentAs"/config/monitor" \
           "Disconnect from Monitor App. " \
           $test_id


# End simulation
let test_id=test_id+1
pre_test $test_id "Simulation completed. Remember to view the logs."
echo
stop_message "${sim_heading}"

