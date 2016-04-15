#!/bin/bash
#    Simulation Set: Sending text raising notifications
#    ------------------------------------------------------------------------
#    Author:      David J. Sanders
#    Student No:  H00035340
#    Date:        12 Apr 2016
#    ------------------------------------------------------------------------
#    Overivew:    Bob and Sue are travelling in their car with their Daughter 
#                 Sam. Their phones are paired to the car's Bluetooth system. At
#                 one point in their journey, they pick up Sue's work colleague 
#                 Andrew who's car is in the shop and they are giving a ride to.
#                 Bob is taking medication for a cardiac condition and his
#                 smart phone issues notifications to remind him to take his
#                 meds at regular occassions.
#
#                 The objective of the simulation is to measure how notifications
#                 can change based on context.
#
#    Revision History
#    --------------------------------------------------------------------------
#    Date         | By             | Reason
#    --------------------------------------------------------------------------
#    12 Apr 2016  | D Sanders      | Revised structure for simulations.
#
#
#================= Scenario Init - Validate $simpath exists ====================
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

source $simpath/includes/check_params.sh
source $simpath/includes/setup.sh
source $simpath/includes/set_version.sh
source $simpath/includes/set_outputs.sh
#
# Simulation 2 Configuration
#
sim_heading="Simulation 1: Sending texts and raising notifications."
over_view="Bob and Sue are travelling in their car with their Daughter "
over_view=$over_view"Sam. Their phones are paired to the car's Bluetooth system. At "
over_view=$over_view"one point in their journey, they pick up Sue's work colleague "
over_view=$over_view"Andrew who's car is in the shop and they are giving a ride to. "
over_view=$over_view"Bob is taking medication for a cardiac condition and his "
over_view=$over_view"smart phone issues notifications to remind him to take his "
over_view=$over_view"meds at regular occassions. "
over_view=$over_view"Andrew's phone is not paired to the car, but it is detected "
over_view=$over_view"by the Bluetooth system, which broadcasts its pairing info.\n\n"
over_view=$over_view"As Bob is driving, the simulation focuses on the Bluetooth "
over_view=$over_view"audio output NOT screens.\n\n"
over_view=$over_view"The objective of the simulation is to measure how notifications "
over_view=$over_view"can change based on context. "
over_view=$over_view"Logs, actual phone screens, and Bluetooth audio are saved "
over_view=$over_view"at the end of the simulation."

echo
echo "Simulation Overview"
echo "==================="
printf "$over_view"
echo

pause "Please ensure setup has been run before the simulation "

set +e
clear
start_message "${sim_heading}"

# Starting Jing's phone screen
let test_id=test_id+1
pre_test $test_id "Sarting Jing's phone screen."
start_phone Jing

let test_id=test_id+1
sender='"sender":"SIM-ENGINE"'
logtype='"log-type":"normal"'
message='"message":"Starting phone screen: Jing"'
data='{'$genKey', '$logtype', '$sender', '$message'}'
do_post "${data}" \
         $loggerPort \
         "/"$presentAs"/log" \
         "Log phone screen start for Jing" \
         $test_id

# Lock the phone
let test_id=test_id+1
data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/"$presentAs"/config/lock" \
        "Jing locks his phone and places it on the train table." \
        $test_id

# Bob sits with Jing and can see the phone screen
let test_id=test_id+1
pre_test $test_id "Bob sits with Jing and can see the phone screen."
start_phone Bob

let test_id=test_id+1
sender='"sender":"SIM-ENGINE"'
logtype='"log-type":"normal"'
message='"message":"Starting phone screen: Bob"'
data='{'$genKey', '$logtype', '$sender', '$message'}'
do_post "${data}" \
         $loggerPort \
         "/"$presentAs"/log" \
         "Log phone screen start for Bob" \
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
         "Jing receives an SMS (text) Message." \
         $test_id

# Send an SMS Message to the phone
let test_id=test_id+1
recipient='"recipient":"'$serverIPName':'$phonePort'/'$presentAs'/notification"'
sender='"sender":"SMS Service"'
action='"action":"Read Text"'
message='"message":"profanity !!**!! What a day I have had"'
data='{'$genKey', '$recipient', '$sender', '$action', '$message'}'
do_post "${data}" \
         $notesvcPort \
         "/"$presentAs"/notification" \
         "Jing receives an SMS (text) Message with a profanity." \
         $test_id

# Unlock the phone
let test_id=test_id+1
data='{'$genKey'}'
do_put "${data}" \
       $phonePort \
       "/"$presentAs"/config/unlock" \
       "Jing unlocks the phone to use it." \
       $test_id

# Launch the Facebook client - A Notification will NOT be issued
let test_id=test_id+1
data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/"$presentAs"/config/launch/facebook" \
        "Jing launches Facebook on his phone and uses the app." \
        $test_id

# Launch Grindr - A Notification will be issued
let test_id=test_id+1
data='{'$genKey'}'
do_post "${data}" \
        $phonePort \
        "/"$presentAs"/config/launch/grindr" \
        "By mistake, Jing launches Grindr and a notification on safe sex appears. Can Bob see it?" \
        $test_id

# Pause for 5 seconds to let the notification be detected
let test_id=test_id+1
pre_test $test_id "It is 30 seconds before Jing notices the notification."
sleep 30
echo

# Lock the phone
let test_id=test_id+1
data=""
do_post "${data}" \
         $phonePort \
         "/"$presentAs"/config/lock" \
         "Jing rapidly locks his phone" \
         $test_id

# Send an SMS Message to the phone
let test_id=test_id+1
recipient='"recipient":"'$serverIPName':'$phonePort'/'$presentAs'/notification"'
sender='"sender":"SMS Service"'
action='"action":"Read Text"'
message='"message":"Can you profanity pick me up at Starbucks, please? Clair and Gordon."'
data='{'$genKey', '$recipient', '$sender', '$action', '$message'}'
do_post "${data}" \
         $notesvcPort \
         "/"$presentAs"/notification" \
         "Jing receives another SMS Message but this time the message includes a profanity" \
         $test_id

# Bob can no longer see the screen
let test_id=test_id+1
pre_test $test_id "Bob says bye to Jing and leaves the train at his stop. Bob can no longer see Jing's phone screen."
stop_phone Bob

# Log Bob has left Jing
let test_id=test_id+1
sender='"sender":"SIM-ENGINE"'
logtype='"log-type":"normal"'
message='"message":"Phone screen Bob has been stopped."'
data='{'$genKey', '$logtype', '$sender', '$message'}'
do_post "${data}" \
         $loggerPort \
         "/"$presentAs"/log" \
         "Log phone screen stop for Bob" \
         $test_id

# Pause for 5 seconds to let the notification be detected
let test_id=test_id+1
pre_test $test_id "Sleeping for 5 seconds to persist notifications."
sleep 5
echo

# Unlock the phone - will cause stored notifications to be processed.
let test_id=test_id+1
data='{'$genKey'}'
do_put "${data}" \
       $phonePort \
       "/"$presentAs"/config/unlock" \
       "Jing unlocks the phone to use it - stored notifications will be shown." \
       $test_id

# Pause for 10 seconds to allow any notifications to be detected.
let test_id=test_id+1
pre_test $test_id "Pause for 10 seconds to allow any notifications to be detected."
sleep 10
echo

# Stopping Jing's phone screen
let test_id=test_id+1
pre_test $test_id "Jing arrives at his destination and is going into a meeting, so switches his phone off."
stop_phone Jing

# Write to the log that Jing's phone has stopped
let test_id=test_id+1
sender='"sender":"SIM-ENGINE"'
logtype='"log-type":"normal"'
message='"message":"Phone screen Jing has been stopped."'
data='{'$genKey', '$logtype', '$sender', '$message'}'
do_post "${data}" \
         $loggerPort \
         "/"$presentAs"/log" \
         "Log phone screen stop for Jing" \
         $test_id

# Get the standard outputs
source $simpath/includes/get_standard_outputs.sh

# End simulation
let test_id=test_id+1
pre_test $test_id "Simulation completed. Remember to view the logs."
echo
stop_message "${sim_heading}"

