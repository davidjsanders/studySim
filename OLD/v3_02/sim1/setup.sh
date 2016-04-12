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

#set -e
source $simpath/includes/check_params.sh

source $simpath/includes/_do_first.sh

#
# Simulation 1 Configuration
#
sim_heading="Simulation set 1 (with obfuscation) setup"

clear
set +e
start_message "${sim_heading}"
set -e

# Logger
run_docker "v3_00" $loggerPort "logger" "Logger" "${save_param}"
sleep 2

do_delete '{'$genKey'}' $loggerPort '/'$version'/log' "Clear logs."
sleep 1

# Bluetooth
run_docker "v3_00" $bluePort "bluetooth" "Bluetooth" "${save_param}"

# Location Service
run_docker "v3_00" $locPort "location_service" "Location_Service" "${save_param}"

# Monitor App
run_docker "v3_01" $monitorPort "monitor_app" "Monitor_App" "${save_param}"

# Notification Service
run_docker "v3_00" $notesvcPort "notification" "Notification_Service" "${save_param}"

# Start the phone
run_docker_phone "v3_02" "${save_param}"

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

