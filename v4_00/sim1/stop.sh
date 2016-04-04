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

stage_path="v3_00"
source $simpath/includes/check_params.sh

source $simpath/includes/_do_first.sh

#
# Simulation 1 Configuration
#
sim_heading="Simulation set 1 (with obfuscation) shutdown"

clear
set +e
start_message "${sim_heading}"
set -e

echo "Stopping services."
echo ""
stop_service $phonePort "phone"
stop_service $bluePort "bluetooth"
stop_service $locPort "location_service"
stop_service $monitorPort "monitor_app"
stop_service $notesvcPort "notification"
stop_service $contextPort "context"
stop_service $loggerPort "logger"
stop_phone Jing
echo "Services stopped."
echo ""
set +e

stop_message "${sim_heading}"

