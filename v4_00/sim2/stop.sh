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

source $simpath/includes/check_params.sh

source $simpath/includes/_do_first.sh
version="v4_00"
presentAs="v4_00"
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
stop_service $phone2Port "phone"
stop_service $phone3Port "phone"
stop_service $phone4Port "phone"
stop_service $presencePort "presence"
stop_service $doorbellPort "door_bell"
stop_service $notesvcPort "notification"
stop_service $contextPort "context"
stop_service $loggerPort "logger"
set +x
stop_phone Phone1 "v3_00" $phoneRedisPort
stop_phone Phone2 "v3_00" $phone2RedisPort
stop_phone Phone3 "v3_00" $phone3RedisPort
stop_phone Phone4 "v3_00" $phone4RedisPort
echo "Services stopped."
echo ""
set +e

stop_message "${sim_heading}"

