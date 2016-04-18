serverIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`"
$simpath/Scenario-Setup/Safe-Sex-Notifications/4-context-start.sh
#$simpath/Scenario-Setup/Safe-Sex-Notifications/A1-configure-Bluetooth.sh

#bluetooth_device='"bluetooth":"'$serverIPName':'$bluePort'/'$presentAs'"'
#data='{'$genKey', '$bluetooth_device'}'
#do_post "${data}" \
#        $phonePort \
#        "/"$presentAs"/config/pair" \
#        "The phone is paired to the Bluetooth controller" \
#        $test_id

curl -X POST -d '{"key":"1234-5678-9012-3456", "bluetooth":"http://'${serverIP}':43126/v3_00"}' http://localhost:43132/v3_00/config/pair
curl -X POST -d '{"presence-engine":"http://'${serverIP}':43130/v3_00", "user-id":"Jing"}' http://localhost:43132/v3_00/config/presence ; echo
curl -X POST -d '{"relationship":"friend"}' http://localhost:43130/v3_00/people/Jing/Bob ; echo
curl -X POST http://localhost:43126/v3_00/imnear/Bob ; echo
echo "Sleep for 5"
sleep 5
curl -X POST http://localhost:43126/v3_00/imnear/stuart ; echo
echo "Sleep for 5"
sleep 5
curl -X DELETE http://localhost:43126/v3_00/imnear/Bob ; echo
$simpath/show_log.sh
#$simpath/Scenario-Setup/Safe-Sex-Notifications/stop-scenario.sh

