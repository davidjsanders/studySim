if [ "X"$simpath == "X" ]; then
    echo "ERROR: simpath is not defined!"
    echo ""
    echo "Before running this script, ensure that simpath is defined:"
    echo ""
    echo "  export simpath=/path/to/studyTest"
    echo
    exit 1
fi

source $simpath/includes/variables.sh
source $simpath/includes/general_ports.sh
source $simpath/includes/stop_phone_fn.sh
source $simpath/includes/stop_service_fn.sh
source $simpath/includes/screen_decorations.sh
source $simpath/includes/bolded_message_fn.sh

echo
set +e
bolded_message "Stopping Test Set 2. Begins at $(date)"
set -e

#export loggerPort=100
#export notesvcPort=101
#export bluePort=102
#export monitorPort=103
#export locPort=104
#export phonePort=1080
#export serverName="dasanderUty01"
#export serverIPName="192.168.0.210"

echo " "
echo "Stopping services."
echo ""
stop_service $phonePort "phone"
stop_service $bluePort "bluetooth"
stop_service $locPort "location_service"
stop_service $monitorPort "monitor_app"
stop_service $notesvcPort "notification"
stop_service $loggerPort "logger"
stop_phone Jing
stop_phone Bob
echo "Services stopped."
echo ""
set +e
bolded_message "Done."
echo
