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

source $simpath/includes/check_params.sh
tVersion=$version

source $simpath/includes/_do_first.sh
if ! [[ -z "$tVersion" ]]; then
    presentAs=$tVersion
    version=$tVersion
else
    presentAs=$version
fi

#
# Simulation 2 Configuration
#
sim_heading="Simulation 1: Sending texts and raising notifications."
over_view="Jing is using a smart phone to receive notifications. He is travelling "
over_view=$over_view"on a train with his friend Bob. At certain points in the train journey, "
over_view=$over_view"Bob can see Jing's phone. The objective of the simulation is to "
over_view=$over_view"understand if Bob sees any sensitive or confidential notifications "
over_view=$over_view"during the journey.\n\n"
over_view=$over_view"Bob's view of the phone is saved in Bob.txt\n"
over_view=$over_view"Jing's view of the phone is saved in Jing.txt\n"
over_view=$over_view"Logs and the actual phone screen are saved at the end of the "
over_view=$over_view"simulation"

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
message='"message":"Can you profanity pick me up at Starbucks, please? Its the one at Clair and Gordon. Thanks John."'
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

# Unlock the phone
let test_id=test_id+1
data='{'$genKey'}'
do_put "${data}" \
       $phonePort \
       "/"$presentAs"/config/unlock" \
       "Jing unlocks the phone to use it" \
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

# Get the phone's screen
let test_id=test_id+1
screen_filename="screen-"$(date +%d-%m-%Y-%H%M%S)".txt"
pre_test $test_id "Downloading phone main screen saving to ${screen_filename}"
wget $serverIPName:$phonePort/$presentAs/config/screen -O "${screen_filename}"
echo

# Get the central log file
let test_id=test_id+1
log_filename="log-"$(date +%d-%m-%Y-%H%M%S)".csv"
pre_test $test_id "Downloading central log file (csv) to ${log_filename}"
wget $serverIPName:$loggerPort/$presentAs/logfile -O "${log_filename}"
echo

# End simulation
let test_id=test_id+1
pre_test $test_id "Simulation completed. Remember to view the logs."
echo
stop_message "${sim_heading}"

