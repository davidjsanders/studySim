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

source $simpath/includes/_do_first.sh
version="v4_00"
presentAs="v4_00"
#
# Simulation 1 Configuration
#
sim_heading="Simulation set 2 (door bell) setup"

clear
set +e
start_message "${sim_heading}"
set -e

# Logger
run_docker "v3_00" $loggerPort "logger" "Logger" "${save_param}"
sleep 2

do_delete '{'$genKey'}' $loggerPort '/'$version'/log' "Clear logs."
sleep 1

# Notification Service
run_docker "v4_00" $notesvcPort "notification" "Notification_Service" "${save_param}"

# Context Service
run_docker "v4_00" $contextPort "context" "Context" "${save_param}"

# Presence
run_docker "v1_00" $presencePort "presence" "Presence" "${save_param}"

# Door Bell
run_docker "v1_00" $doorbellPort "door_bell" "Door_Bell" "${save_param}"

# Start the phone
run_docker_phone "v4_00" "${save_param}"
run_docker_phone "v4_00" "${save_param}" $phone2Port $phone2RedisPort
run_docker_phone "v4_00" "${save_param}" $phone3Port $phone3RedisPort
run_docker_phone "v4_00" "${save_param}" $phone4Port $phone4RedisPort

echo ""
echo -n "Pausing to let services complete start-up: "
sleep 2
echo "done."

echo ""
echo "${underline}Starting phone screens${normal}"
echo ""
#
# Setup phones - adding screens
#
start_phone Phone1 "v3_00" $phoneRedisPort
start_phone Phone2 "v3_00" $phone2RedisPort
start_phone Phone3 "v3_00" $phone3RedisPort
start_phone Phone4 "v3_00" $phone4RedisPort

echo ""
echo "${underline}Configure logging.${normal}"
config_logging $notesvcPort "Notification Service"
config_logging $presencePort "Presence"
config_logging $doorbellPort "Door Bell"
config_logging $contextPort  "Context Service"
config_logging $phonePort "David's Phone"
config_logging $phone2Port "Friend's Phone"
config_logging $phone3Port "Delivery Man's Phone"
config_logging $phone4Port "Stranger's Phone"
echo ""
echo "Logging configured."
echo ""
echo ""
echo ${underline}"Summary of services"${normal}
echo "Central logger:       "$serverIPName":"$loggerPort"/"$presentAs
echo "Notification service: "$serverIPName":"$notesvcPort"/"$presentAs
echo "Presence Engine:      "$serverIPName":"$presencePort"/"$presentAs
echo "Door bell:            "$serverIPName":"$doorbellPort"/"$presentAs
echo "Phone context engine: "$serverIPName":"$contextPort"/"$presentAs
echo "David's phone:        "$serverIPName":"$phonePort"/"$presentAs
echo "Friend's phone:       "$serverIPName":"$phone2Port"/"$presentAs
echo "Delivery man's phone: "$serverIPName":"$phone3Port"/"$presentAs
echo "Stranger's phone:     "$serverIPName":"$phone4Port"/"$presentAs
echo
echo
set +e
stop_message "${sim_heading}"

