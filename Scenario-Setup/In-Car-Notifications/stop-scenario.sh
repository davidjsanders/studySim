#    Scenario: no-context
#    ------------------------------------------------------------------------
#    Author:      David J. Sanders
#    Student No:  H00035340
#    Date:        12 Apr 2016
#    ------------------------------------------------------------------------
#    Overivew:    no-context-start.sh sets up the Notification scenario to be
#                 used exactly as the notification app - all notifications
#                 sensitive, or not, are shown whether the phone is locked or
#                 unlocked.
#
#    Models:
#    1. dsanderscan/mscit_v3_00_logger - central logging
#    2. dsanderscan/mscit_v3_00_bluetooth - Bluetooth service
#    3. dsanderscan/mscit_v3_00_location - Location service
#    4. dsanderscan/mscit_v3_00_monitor_app - Monitor App service
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

source $simpath/includes/check_params.sh
source $simpath/includes/setup.sh
source $simpath/Scenario-Setup/In-Car-Notifications/includes/additional_ports.sh
source $simpath/includes/set_version.sh

#version="v4_00"
#presentAs="v4_00"
#
# Simulation 1 Configuration
#
sim_heading="NOTIFICATIONS: Stopping active scenarios."

set +e
start_message "${sim_heading}"
set -e

echo "Stopping services."
echo ""
stop_service $phonePort "phone"
stop_service $phone2Port "phone"
stop_service $phone3Port "phone"
stop_service $contextPort "context"
stop_service $presencePort "presence"
stop_service $locPort "location_service"
stop_service $bluePort "bluetooth"
stop_service $notesvcPort "notification"
stop_service $loggerPort "logger"
echo "Services stopped."
echo ""
set +e

stop_message "${sim_heading}"

