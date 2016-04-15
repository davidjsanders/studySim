#    Scenario: Additional 1 - Configure Bluetooth
#    ------------------------------------------------------------------------
#    Author:      David J. Sanders
#    Student No:  H00035340
#    Date:        12 Apr 2016
#    ------------------------------------------------------------------------
#    Overivew:    A1-configure-Bluetooth.sh pairs the registered first
#                 phone with the Bluetooth service. All notifications received
#                 are 'read' aloud by the service (the actually go into a text
#                 file called hostname_phonePort). The Bluetooth audio is 
#                 retrieved by asking the Bluetooth service to deliver the 
#                 default audio file by the config interface.
#
#                 NOTE: No model changes are made here.
#                 DEPENDENCY: A previous scenario MUST have been setup first.
#
#    Models:
#    None.
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
    sim_heading="NOTIFICATIONS: Configure Bluetooth - Pair phone"
    scenario_includes=$simpath/Scenario-Setup/In-Car-Notifications/includes
}
#
# do_settings: Set data, apps, and settings for the phone and conencted devices.
#
do_settings() {
    source $scenario_includes/Bluetooth-settings.sh
}
#
# do_summary: Show the summary of ports for each service used.
#
do_summary() {
    echo
    echo
    echo "Summary of services"
    echo "==================="
    echo "Phone ${serverName}_${phonePort} has been paired with ${serverIPName}:${bluePort}/${presentAs}/pair"
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

do_settings
do_summary

set +e
stop_message "${sim_heading}"
#
#============================= Scenario Setup End ==============================
#

