#    Scenario: no-context
#    ------------------------------------------------------------------------
#    Author:      David J. Sanders
#    Student No:  H00035340
#    Date:        12 Apr 2016
#    ------------------------------------------------------------------------
#    Overivew:    no-context-start.sh sets up two phones for Bob and Sue. They
#                 are travelling in their car on the way to work. Their smart
#                 phones are paired to the car's Bluetooth system. At certain
#                 points they have another person, Andrew, in the car.
#
#                 Bob is phone 1.
#                 Sue is phone 2.
#                 Andrew is phone 3.
#
#    Models:
#    1. dsanderscan/mscit_v3_00_logger - central logging
#    2. dsanderscan/mscit_v3_01_bluetooth - Bluetooth service
#    3. dsanderscan/mscit_v3_00_location - Location service
#    4. dsanderscan/mscit_v3_00_notification - Notification service
#    5. dsanderscan/mscit_v3_00_phone - Phone model
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
# Validate $simpath is defined and set
#
if [[ -z "$simpath" ]]; then
    echo "ERROR: simpath is not defined!"
    echo ""
    echo "Before running this script, ensure that simpath is defined:"
    echo ""
    echo "  export simpath=/path/to/studySim"
    echo
    exit 1
fi
#
#=================== Scenario Setup - Funciton Definition ======================
#
#
# do_initialize: Setup any variables and headings required
#
do_initialize() {
    sim_heading="NOTIFICATIONS: No Context - Send notifications with no context - Start"
    scenario_includes=$simpath/Scenario-Setup/In-Car-Notifications/includes
}
#
# do_start: Define the services that will be started for this Scenario setup
#
do_start() {
    # Logger
    cv="v3_00"
    cPort=$loggerPort
    cModule="logger"
    run_docker
    sleep 2

    do_delete '{'$genKey'}' $loggerPort '/'$presentAs'/log' "Clear logs."
    sleep 1

    # Bluetooth Service
    cv="v3_01"
    cPort=$bluePort
    cModule="bluetooth"
    run_docker
    sleep 1

    # Location Service
    cv="v3_00"
    cPort=$locPort
    cModule="location_service"
    run_docker
    sleep 1

    # Notification Service
    cv="v3_00"
    cPort=$notesvcPort
    cModule="notification"
    run_docker
    sleep 1

    # Phone 1
    cv="v3_00"
    cPort=$phonePort
    cModule="phone"
    run_docker $phoneRedisPort

    # Phone 2
    cv="v3_00"
    cPort=$phone2Port
    cModule="phone"
    run_docker $phone2RedisPort
    phone2InUse='TRUE'

    # Phone 3
    cv="v3_00"
    cPort=$phone3Port
    cModule="phone"
    run_docker $phone3RedisPort
    phone3InUse='TRUE'

    echo ""
    echo -n "Pausing to let services complete start-up: "
    sleep 2
    echo "done."

}
#
# do_logging: Define the logging required for this scenario
#
do_logging() {
    echo ""
    echo "Configure logging."
    echo "=================="
    echo
    config_logging $bluePort "Bluetooth"
    config_logging $locPort "Location Service"
    config_logging $notesvcPort "Notification Service"
    config_logging $phonePort "Phone"
    config_logging $phone2Port "Phone 2"
    config_logging $phone3Port "Phone 3"
    echo ""
    echo "Done."
    echo ""
    echo
}
#
# do_settings: Set data, apps, and settings for the phone and conencted devices.
#
do_settings() {
    source $scenario_includes/core-settings.sh
}
#
# do_summary: Show the summary of ports for each service used.
#
do_summary() {
    echo
    echo
    echo "Summary of services"
    echo "==================="
    echo "Central logger:       "$serverIPName":"$loggerPort"/"$presentAs
    echo "Notification service: "$serverIPName":"$notesvcPort"/"$presentAs
    echo "Bluetooth:            "$serverIPName":"$bluePort"/"$presentAs
    echo "Location Service:     "$serverIPName":"$locPort"/"$presentAs
    echo "Phone:                "$serverIPName":"$phonePort"/"$presentAs
    echo "Phone Redis:          Port "$phoneRedisPort" on "$serverIP
    echo "Phone 2:              "$serverIPName":"$phone2Port"/"$presentAs
    echo "Phone 2 Redis:        Port "$phone2RedisPort" on "$serverIP
    echo "Phone 3:              "$serverIPName":"$phone3Port"/"$presentAs
    echo "Phone 3 Redis:        Port "$phone3RedisPort" on "$serverIP
    echo
    echo
}
#
#========================== Scenario Setup - Main Logic ========================
#
do_initialize

source $simpath/includes/check_params.sh
source $simpath/includes/setup.sh
source $scenario_includes/additional_ports.sh
source $simpath/includes/set_version.sh

set +e
start_message "${sim_heading}"
set -e

do_start
set +e      # Ignore errors during settings and logging
do_logging
do_settings
set -e      # Turn error handling back on
do_summary

set +e
stop_message "${sim_heading}"
#
#============================= Scenario Setup End ==============================
#

