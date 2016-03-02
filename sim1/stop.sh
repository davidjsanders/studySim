if [ "X"$simpath == "X" ]; then
    echo "ERROR: simpath is not defined!"
    echo ""
    echo "Before running this script, ensure that simpath is defined:"
    echo ""
    echo "  export simpath=/path/to/studySim"
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
bolded_message "Stopping Test Set 1. Begins at $(date)"
set -e

echo " "
echo "Stopping services."
echo ""
stop_service "stage2_" $phonePort "phone"
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
bolded_message "Done."
echo
