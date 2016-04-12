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

#set -e
source $simpath/includes/check_params.sh
tVersion=$version

source $simpath/includes/_do_first.sh
if ! [[ -z "$tVersion" ]]; then
    echo "tVersion is not empty"
    presentAs=$tVersion
    version=$tVersion
else
    echo "tVersion is empty"
    presentAs=$version
fi

#
# Simulation 1 Configuration
#
sim_heading="Simulation Set 1 - setup"

clear
set +e
start_message "${sim_heading}"
set -e

# Logger
#run_docker "v3_00" $loggerPort "logger" "Logger" "${save_param}"
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
cv="v3_00"
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

# Context Service
#run_docker "v4_00" $contextPort "context" "Context" "${save_param}"
#cv="v4_00"
#cPort=$contextPort
#cModule="context"
#run_docker
#sleep 1

# Phone 1
cv="v3_00"
cPort=$phonePort
cModule="phone"
run_docker $phoneRedisPort

echo ""
echo -n "Pausing to let services complete start-up: "
sleep 2
echo "done."

echo ""
echo "${underline}Configure logging.${normal}"
config_logging $bluePort "Bluetooth"                 # Bluetooth
config_logging $locPort "Location Service"           # Location Service
config_logging $monitorPort "Monitor App"            # Monitor App
config_logging $notesvcPort "Notification Service"
#config_logging $contextPort  "Context Service"
config_logging $phonePort "David's Phone"
echo ""
echo "Logging configured."
echo ""
echo ""
echo ${underline}"Summary of services"${normal}
echo "Central logger:       "$serverIPName":"$loggerPort"/"$presentAs
echo "Notification service: "$serverIPName":"$notesvcPort"/"$presentAs
echo "Presence Engine:      "$serverIPName":"$presencePort"/"$presentAs
echo "Door bell:            "$serverIPName":"$doorbellPort"/"$presentAs
#echo "Phone context engine: "$serverIPName":"$contextPort"/"$presentAs
echo "Phone:                "$serverIPName":"$phonePort"/"$presentAs
echo
echo
set +e
stop_message "${sim_heading}"

