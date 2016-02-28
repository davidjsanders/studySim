if [ "X"$testpath == "X" ]; then
    echo "ERROR: testpah is not defined!"
    echo ""
    echo "Before running this script, ensure that testpath is defined:"
    echo ""
    echo "  export testpath=/path/to/studyTest"
    echo
    exit 1
fi

source $testpath/includes/variables.sh
source $testpath/includes/general_ports.sh
source $testpath/includes/stop_phone_fn.sh
source $testpath/includes/stop_service_fn.sh
source $testpath/includes/screen_decorations.sh
source $testpath/includes/bolded_message_fn.sh

echo
set +e
bolded_message "Stopping Test Set 1. Begins at $(date)"
set -e

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
