#    Scenario: no-context
#    ------------------------------------------------------------------------
#    Author:      David J. Sanders
#    Student No:  H00035340
#    Date:        12 Apr 2016
#    ------------------------------------------------------------------------
#    Overivew:    stop-scenario stops all models in the scenario, whether in use
#                 or not. Any models already stopped simply report back they are
#                 stopped.
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

source $simpath/includes/check_params.sh
source $simpath/includes/setup.sh
source $simpath/Scenario-Setup/Safe-Sex-Notifications/includes/additional_ports.sh
source $simpath/includes/set_version.sh

#version="v4_00"
#presentAs="v4_00"
#
# Simulation 1 Configuration
#
sim_heading="Scenario: Safe Sex Notificiations - Stop Scenario"

set +e
start_message "${sim_heading}"
set -e

echo "Stopping services."
echo ""
stop_service $phonePort "phone"
stop_service $phone2Port "phone"
stop_service $phone3Port "phone"
stop_service $phone4Port "phone"
stop_service $contextPort "context"
stop_service $presencePort "presence"
stop_service $locPort "location_service"
stop_service $bluePort "bluetooth"
stop_service $monitorPort "monitor_app"
stop_service $notesvcPort "notification"
stop_service $loggerPort "logger"
echo "Services stopped."
echo ""
set +e

stop_message "${sim_heading}"

