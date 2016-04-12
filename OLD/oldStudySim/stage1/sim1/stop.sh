if [ "X"$simpath == "X" ]; then
    echo "ERROR: simpath is not defined!"
    echo ""
    echo "Before running this script, ensure that simpath is defined:"
    echo ""
    echo "  export simpath=/path/to/studySim"
    echo
    exit 1
fi

STAGE="stage2_"

source $simpath/includes/startup.sh
source $simpath/includes/variables.sh
source $simpath/includes/general_ports.sh
source $simpath/includes/stop_phone_fn.sh
source $simpath/includes/stop_service_fn.sh
source $simpath/includes/screen_decorations.sh
source $simpath/includes/bolded_message_fn.sh

echo
set +e
bolded_message "Stopping Test Set 1. Begins at $(date)"
set -e

echo " "
echo "Stopping services."
echo ""
stop_service $STAGE $phonePort "phone"
stop_service $STAGE $bluePort "bluetooth"
stop_service $STAGE $locPort "location_service"
stop_service $STAGE $monitorPort "monitor_app"
stop_service $STAGE $notesvcPort "notification"
stop_service $STAGE $loggerPort "logger"
stop_phone $STAGE Jing
stop_phone $STAGE Bob
echo "Services stopped."
echo ""
set +e
bolded_message "Done."
echo
