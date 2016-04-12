#    Scenario: obfuscation
#    ------------------------------------------------------------------------
#    Author:      David J. Sanders
#    Student No:  H00035340
#    Date:        12 Apr 2016
#    ------------------------------------------------------------------------
#    Overivew:    obfuscation-start.sh sets up the Notification scenario to be
#                 used with obfuscation settings where a user can mask 
#                 sensitivie notifications by asking an application (the monitor
#                 app) to send a user defined notification.
#
#                 Variations from no-context are marked with asterisks (*)
#
#    Models:
#    1. dsanderscan/mscit_v3_00_logger - central logging
#    2. dsanderscan/mscit_v3_00_bluetooth - Bluetooth service
#    3. dsanderscan/mscit_v3_00_location - Location service
# *  4. dsanderscan/mscit_v3_01_monitor_app - Monitor App service     *
#    5. dsanderscan/mscit_v3_00_notification - Notification service
#    6. dsanderscan/mscit_v3_00_phone - Phone model
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
    scenario_includes=$simpath/Scenario-Setup/Notifications/includes
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
    cv="v3_00"
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

    # Monitor Apps Service
    cv="v3_01"
    cPort=$monitorPort
    cModule="monitor_app"
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
    config_logging $monitorPort "Monitor App"
    config_logging $notesvcPort "Notification Service"
    config_logging $phonePort "Phone"
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
    source $scenario_includes/configure-obfuscation.sh
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
    echo "Monitor App:          "$serverIPName":"$monitorPort"/"$presentAs
    echo "Phone:                "$serverIPName":"$phonePort"/"$presentAs
    echo "Phone Redis:          Port "$phoneRedisPort" on "$serverIP
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

clear
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

