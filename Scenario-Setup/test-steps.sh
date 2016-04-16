$simpath/Scenario-Setup/Safe-Sex-Notifications/4-context-start.sh
$simpath/Scenario-Setup/Safe-Sex-Notifications/A1-configure-Bluetooth.sh
curl -X POST -d '{"presence-engine":"http://192.168.0.210:43130/v3_00", "user-id":"Jing"}' http://192.168.0.210:43132/v3_00/config/presence ; echo
curl -X POST -d '{"relationship":"friend"}' http://192.168.0.210:43130/v3_00/people/Jing/Bob ; echo
curl -X POST http://192.168.0.210:43126/v3_00/imnear/Bob ; echo
echo "Sleep for 5"
sleep 5
curl -X POST http://192.168.0.210:43126/v3_00/imnear/stuart ; echo
echo "Sleep for 5"
sleep 5
curl -X DELETE http://192.168.0.210:43126/v3_00/imnear/Bob ; echo
$simpath/show_log.sh
#$simpath/Scenario-Setup/Safe-Sex-Notifications/stop-scenario.sh

