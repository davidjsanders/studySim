#!/bin/bash
#    Simulation Set: Sending text raising notifications
#    ------------------------------------------------------------------------
#    Author:      David J. Sanders
#    Student No:  H00035340
#    Date:        12 Apr 2016
#    ------------------------------------------------------------------------
#    Overivew:   
#                Bob's phone is phone-43132
#                Sue's phone is phone-43133
#                Andrew's phone is phone-43134
#
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

simulation="3"
simulation_includes=$simpath/Simulation-Sets/Notifications/includes
scenario_includes=$simpath/Scenario-Setup/In-Car-Notifications/includes

source $simpath/includes/check_params.sh
source $simpath/includes/setup.sh
source $simpath/includes/set_version.sh
source $simpath/includes/set_outputs.sh
source $scenario_includes/additional_ports.sh
#
# Simulation 2 Configuration
#
sim_heading="Simulation 1: Sensitive notifications with different people present."
over_view="Jing is using a smart phone to receive notifications. He is travelling "
over_view=$over_view"on a train (or car) with his friend Bob. At certain points in the train journey, "
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
start_message "${sim_heading}"

# Bob sits with Jing and can see the phone screen
let test_id=test_id+1
pre_test $test_id "Bob sits with Jing and can see the phone screen."
# Phone Screen must be version 3
start_phone Bob "v3_00" $phoneRedisPort

let test_id=test_id+1
do_log "Log Bob phone screen started." $test_id

# If Presence engine is available, set it up.
container_name=""$presentAs"_presence_"$presencePort
check_docker "${container_name}"   # sets $DOCKER_CHECK
if ! [ "X" == "${DOCKER_CHECK}" ]; then
    echo "*** PRESENCE ENGINE EXISTS ***"
    # Connect to the presence engine
    let test_id=test_id+1
    presence_engine='"presence-engine":"'$serverIPName':'$presencePort'/'$presentAs'"'
    user_id='"user-id":"Bob"'
    data='{'$genKey', '$presence_engine', '$user_id'}'
    do_post "${data}" \
            $phonePort \
            "/"$presentAs"/config/presence" \
            "Bob's phone is connected to the presence system." \
            $test_id

    let test_id=test_id+1
    do_log "SIMENGINE Setting Sue as Bob's spouse." $test_id

    # Set Sue up as Bob's spouse
    let test_id=test_id+1
    relationship='"relationship":"spouse"'
    data='{'$genKey', '$relationship'}'
    do_post "${data}" \
            $presencePort \
            "/"$presentAs"/people/Bob/Sue" \
            "Sue is defined in presence as spouse of Bob" \
            $test_id

    let test_id=test_id+1
    do_log "SIMENGINE Setting Andrew as a stranger to Bob." $test_id

    #
    # DONT define Andrew - he's a stranger in this simulation.
    #
    # Set Andrew up as Bob's colleague
    #let test_id=test_id+1
    #relationship='"relationship":"colleague"'
    #data='{'$genKey', '$relationship'}'
    #do_post "${data}" \
    #        $presencePort \
    #        "/"$presentAs"/people/Bob/Andrew" \
    #        "Andrew is defined in presence as colleague of Bob" \
    #        $test_id
fi

# If context is available, configure it.
container_name=""$presentAs"_context_"$contextPort
check_docker "${container_name}"   # sets $DOCKER_CHECK
if ! [ "X" == "${DOCKER_CHECK}" ]; then
    echo "*** CONTEXT ENGINE EXISTS ***"
    # Connect Bob's phone to the context engine
    let test_id=test_id+1
    context='"context-engine":"'$serverIPName':'$contextPort'/'$presentAs'/subscribe"'
    data='{'$genKey', '$context'}'
    do_put "${data}" \
           $phonePort \
           "/"$presentAs"/config/context" \
           "Connect Bob's phone to the context engine at "$serverIPName":"$contextPort \
           $test_id
fi

source $simpath/Simulation-Sets/In-Car/with-someone-steps.sh
