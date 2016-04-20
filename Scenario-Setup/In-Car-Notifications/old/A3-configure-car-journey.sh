#    Scenario: Additional 3 - Configure car journey
#    ------------------------------------------------------------------------
#    Author:      David J. Sanders
#    Student No:  H00035340
#    Date:        12 Apr 2016
#    ------------------------------------------------------------------------
#    Overivew:    A3-configure-car-journey.sh defines an additional smart phone
#                 for Bob's wife Sue.
#
#                 NOTE: No model changes are made here.
#                 DEPENDENCY: A previous scenario MUST have been setup first.
#
#    Models:
#    1. dsanderscan/mscit_v3_00_notification - Notification service
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
    sim_heading="NOTIFICATIONS: Additional Phone - Start"
    scenario_includes=$simpath/Scenario-Setup/Notifications/includes
}
#
# do_start: Define the services that will be started for this Scenario setup
#
do_start() {
    # Phone 2
    cv="v3_00"
    cPort=$phone2Port
    cModule="phone"
    run_docker $phone2RedisPort

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
    config_logging $phone2Port "Phone2"
    echo ""
    echo "Done."
    echo ""
    echo
}
#
# do_settings: Set data, apps, and settings for the phone and conencted devices.
#
do_settings() {
    tmp_date=$(date +%d-%b-%Y--%H-%M-%S)
    echo "PASS" > /tmp/$tmp_date
    rm /tmp/$tmp_date
#    source $scenario_includes/core-settings.sh
}
#
# do_summary: Show the summary of ports for each service used.
#
do_summary() {
    echo
    echo
    echo "Summary of services"
    echo "==================="
    echo "Phone 2:              "$serverIPName":"$phone2Port"/"$presentAs
    echo "Phone 2 Redis:        Port "$phone2RedisPort" on "$serverIP
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

