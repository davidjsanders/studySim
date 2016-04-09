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

source $simpath/includes/_do_first.sh
presentAs="v4_00"

#
# Simulation 2 Configuration
#
sim_heading="Simulation set 2 (door bell) execution"

pause "Please ensure setup has been run; simulation "

set +e
clear
start_message "${sim_heading}"

# Add a user David to the presence engine, with status available
let test_id=test_id+1
userstatus='"status":"available"'
data='{'$userstatus'}'
do_post "${data}" \
        $presencePort \
        "/"$presentAs"/user/david" \
        "Add a user David to the presence engine, with status available" \
        $test_id


# Configure the door bell to recognize David
let test_id=test_id+1
first_name='"first-name":"David"'
family_name='"family-name":"Sanders"'
notification_service='"notification-service":"'$serverIPName':'$notesvcPort'/'$presentAs'/notification"'
call_back='"call-back":"'$serverIPName':'$phonePort'/'$presentAs'/notification"'
call_back_key='"call-back-key":"1234-5678-9012-3456"'
data='{'$genKey', '$notification_service', '$first_name', '$family_name', '$call_back', '$call_back_key'}'
do_post "${data}" \
          $doorbellPort \
          "/"$presentAs"/occupant/david" \
          "Configure the door to recognize David (david) as an occupant." \
          $test_id


# Configure the phone to use the presence engine
let test_id=test_id+1
presence_engine='"presence-engine":"'$serverIPName':'$presencePort'/'$presentAs'/user"'
data='{'$presence_engine'}'
do_post "${data}" \
        $doorbellPort \
        "/"$presentAs"/config/presence" \
        "Configure the phone to use the presence engine" \
        $test_id


# Delivery man rings the door bell (Phone 2)
let test_id=test_id+1
call_back='"call-back":"'$serverIPName':'$phone3Port'/'$presentAs'/notification"'
call_back_key='"call-back-key":"1234-5678-9012-3456"'
call_from='"call-from":"FedEx"'
data='{'$call_back', '$call_back_key', '$call_from'}'
do_put "${data}" \
        $doorbellPort \
        "/"$presentAs"/ring/david" \
        "Delivery man rings the door bell for David (Phone 2)" \
        $test_id

# Set David's presence to busy
let test_id=test_id+1
userstatus='"status":"busy"'
data='{'$userstatus'}'
do_post "${data}" \
        $presencePort \
        "/"$presentAs"/user/david" \
        "Add a user David to the presence engine, with status available" \
        $test_id


# Delivery man rings the door bell (Phone 2)
let test_id=test_id+1
call_back='"call-back":"'$serverIPName':'$phone3Port'/'$presentAs'/notification"'
call_back_key='"call-back-key":"1234-5678-9012-3456"'
call_from='"call-from":"FedEx"'
data='{'$call_back', '$call_back_key', '$call_from'}'
do_put "${data}" \
        $doorbellPort \
        "/"$presentAs"/ring/david" \
        "Delivery man rings the door bell for David (Phone 2)" \
        $test_id


# Get the phone's screen
let test_id=test_id+1
screen_filename="david-screen-"$(date +%d-%m-%Y-%H%M%S)".txt"
pre_test $test_id "Downloading David's phone screen saving to ${screen_filename}"
wget $serverIPName:$phonePort/$presentAs/config/screen -O "${screen_filename}"
echo

# Get the phone's screen
let test_id=test_id+1
screen_filename="friend-screen-"$(date +%d-%m-%Y-%H%M%S)".txt"
pre_test $test_id "Downloading friend phone screen saving to ${screen_filename}"
wget $serverIPName:$phone2Port/$presentAs/config/screen -O "${screen_filename}"
echo

# Get the phone's screen
let test_id=test_id+1
screen_filename="fedex-screen-"$(date +%d-%m-%Y-%H%M%S)".txt"
pre_test $test_id "Downloading delivery man's phone screen saving to ${screen_filename}"
wget $serverIPName:$phone3Port/$presentAs/config/screen -O "${screen_filename}"
echo

# Get the phone's screen
let test_id=test_id+1
screen_filename="stranger-screen-"$(date +%d-%m-%Y-%H%M%S)".txt"
pre_test $test_id "Downloading stranger's phone screen saving to ${screen_filename}"
wget $serverIPName:$phone4Port/$presentAs/config/screen -O "${screen_filename}"
echo

# Get the central log file
let test_id=test_id+1
log_filename="log-"$(date +%d-%m-%Y-%H%M%S)".csv"
pre_test $test_id "Downloading central log file (csv) to ${screen_filename}"
wget $serverIPName:$loggerPort/$presentAs/logfile -O "${log_filename}"
echo

# End simulation
let test_id=test_id+1
pre_test $test_id "Simulation completed. Remember to view the logs."
echo
stop_message "${sim_heading}"

