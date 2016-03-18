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
source $simpath/$stage_path/includes/_do_first.sh

#
# Simulation 1 Configuration
#
sim_heading="Simulation set 1 setup"

clear
set +e
start_message "${sim_heading}"
set -e

run_docker_persist "v3_00" $loggerPort "logger" "Logger"
sleep 2

do_delete '{'$genKey'}' $loggerPort '/'$version'/log' "Clear logs."
sleep 1

run_docker_persist "v3_00" $bluePort "bluetooth" "Bluetooth"                   # Bluetooth
run_docker_persist "v3_00" $locPort "location_service" "Location_Service"      # Location Service
run_docker_persist "v3_00" $monitorPort "monitor_app" "Monitor_App"            # Monitor App
run_docker_persist "v3_00" $notesvcPort "notification" "Notification_Service"  # Notification Service
run_docker_phone_persist "v3_00"                                               # Start the phone

echo ""
echo -n "Pausing to let services complete start-up: "
sleep 2
echo "done."

echo ""
echo "${underline}Starting phone screens${normal}"
echo ""
# Setup Jing to be able to see the phone
start_phone Jing

# Setup Bob to be able to see the phone
start_phone Bob

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
stop_message "${sim_heading}"

