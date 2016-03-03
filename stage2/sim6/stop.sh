if [ "X"$simpath == "X" ]; then
    echo "ERROR: simpath is not defined!"
    echo ""
    echo "Before running this script, ensure that simpath is defined:"
    echo ""
    echo "  export simpath=/path/to/studySim"
    echo
    exit 1
fi

STAGE_PATH="stage2"
STAGE=$STAGE_PATH"_"
SIM_HEADING="Simulation set 6 shutdown"

source $simpath/$STAGE_PATH/includes/includes.sh

clear
set +e
start_message "${SIM_HEADING}"
set -e

echo "Stopping services."
echo ""
stop_service "stage3_" $phonePort "phone"
stop_service "stage2_" $bluePort "bluetooth"
stop_service "stage2_" $locPort "location_service"
stop_service "stage2_" $monitorPort "monitor_app"
stop_service "stage2_" $notesvcPort "notification"
stop_service "stage2_" $loggerPort "logger"
stop_phone "stage2_" Jing
stop_phone "stage2_" Bob
echo "Services stopped."
echo ""
set +e

stop_message "${SIM_HEADING}"

