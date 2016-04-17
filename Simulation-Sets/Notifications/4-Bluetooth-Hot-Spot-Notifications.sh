#!/bin/bash
#    Simulation Set: Hot spot notifications
#    ------------------------------------------------------------------------
#    Author:      David J. Sanders
#    Student No:  H00035340
#    Date:        12 Apr 2016
#    ------------------------------------------------------------------------
#    Overivew:   Jing is using the Besoain, et al., (2015) app on his smart
#                phone. He has given permission to the app to send him 
#                notifications when he enters a hot-spot area. On his train
#                journey into town with Bob, his trian passes through a hot spot
#                area and raises a notification.
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

simulation="4"
simulation_includes=$simpath/Simulation-Sets/Notifications/includes
source $simpath/includes/check_params.sh
source $simpath/includes/setup.sh
source $simpath/includes/set_version.sh
source $simpath/includes/set_outputs.sh
#
# Simulation 2 Configuration
#
sim_heading="Simulation 2: Hot Spot notifications."
over_view="Jing is using the Besoain, et al., (2015) app on his smart"
over_view=$over_view"phone. He has given permission to the app to send him"
over_view=$over_view"notifications when he enters a hot-spot area. On his train "
over_view=$over_view"journey into town with Bob, his train passes through a hot spot "
over_view=$over_view"area and raises a notification.\n\n"
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

# Setup the phone for monitored apps
source $simulation_includes/configure-monitored-locations.sh

# Setup the phone for Bluetooth
source $simulation_includes/configure-Bluetooth.sh

# Starting Jing's phone screen
let test_id=test_id+1
pre_test $test_id "Sarting Jing's phone screen."
# Phone Screen must be version 3
start_phone Jing "v3_00"

let test_id=test_id+1
do_log "Log Jing phone screen started." $test_id

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
pre_test $test_id "Bob sits with Jing, He cannot see the phone but can hear Bluetooth audio."

# Log Bob has left Jing
let test_id=test_id+1
do_log "Log Bob is listening to Bluetooth" $test_id

# The train starts moving
let test_id=test_id+1
pre_test $test_id "The train is moving"
let inner_counter=1
for i in `seq 100 100 450`;
do
    # Define the phone's starting location
    loc_x='"x":'${i}
    loc_y='"y":300'
    data='{'$genKey', '$loc_x', '$loc_y'}'
    do_put "${data}" \
           $phonePort \
           "/"$presentAs"/config/location" \
           "The phone's location is set to ($loc_x,$loc_y)" \
           "$test_id.$inner_counter"
#           $test_id
    let inner_counter=inner_counter+1
    echo "Sleep to simulate journey and allow hot spot detection"
    sleep 30
done

# Unlock the phone
#let test_id=test_id+1
#data='{'$genKey'}'
#do_put "${data}" \
#       $phonePort \
#       "/"$presentAs"/config/unlock" \
#       "Jing unlocks the phone to use it." \
#       $test_id

# Lock the phone
#let test_id=test_id+1
#data=""
#do_post "${data}" \
#         $phonePort \
#         "/"$presentAs"/config/lock" \
#         "Jing rapidly locks his phone" \
#         $test_id

# Bob can no longer see the screen
let test_id=test_id+1
pre_test $test_id "Bob says bye to Jing and leaves the train at his stop. Bob can no longer hear notifications."

# Log Jing's phone screen has started
let test_id=test_id+1
do_log "Log Bob can no longer hear Bluetooth output." $test_id

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

# Disconnect the phone from monitored locations
source $simulation_includes/unconfigure-monitored-locations.sh

# Disconnect the phone from Bluetooth
source $simulation_includes/unconfigure-Bluetooth.sh

# Stopping Jing's phone screen
let test_id=test_id+1
pre_test $test_id "Jing arrives at his destination and is going into a meeting, so switches his phone off."
stop_phone Jing

# Write to the log that Jing's phone has stopped
let test_id=test_id+1
do_log "Log Jing phone screen stopped." $test_id

# Get the standard outputs
source $simpath/includes/get_standard_outputs.sh

# End simulation
let test_id=test_id+1
pre_test $test_id "Simulation completed. Remember to view the logs."
echo
stop_message "${sim_heading}"

