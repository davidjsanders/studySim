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
SIM_HEADING="Simulation set 6 setup"

source $simpath/$STAGE_PATH/includes/includes.sh

clear
set +e
start_message "${SIM_HEADING}"
set -e

run_docker $STAGE $loggerPort "logger" "Logger"
sleep 2

do_delete '{'$genKey'}' $loggerPort '/v1_00/log' "Clear logs."
sleep 1

run_docker_persist $STAGE $bluePort "bluetooth" "Bluetooth"                   # Bluetooth
run_docker $STAGE $locPort "location_service" "Location_Service"      # Location Service
run_docker $STAGE $monitorPort "monitor_app" "Monitor_App"            # Monitor App
run_docker $STAGE $notesvcPort "notification" "Notification_Service"  # Notification Service
run_docker_phone_persist "stage3_"                                               # Start the phone

echo ""
echo -n "Pausing to let services complete start-up: "
sleep 2
echo "done."

echo ""
echo "${underline}Starting phone screens${normal}"
echo ""

# Setup Jing to be able to see the phone
start_phone $STAGE Jing

# Setup Bob to be able to see the phone
start_phone $STAGE Bob

echo ""
echo "${underline}Configure logging.${normal}"
echo ""
config_logging $bluePort "Bluetooth"                 # Bluetooth
config_logging $locPort "Location Service"           # Location Service
config_logging $monitorPort "Monitor App"            # Monitor App
config_logging $notesvcPort "Notification Service"   # Notification Service
config_logging $phonePort "Phone"                    # Phone
echo ""
echo "Logging configured."
echo ""

set +e
stop_message "${SIM_HEADING}"

