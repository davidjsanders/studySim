serverIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`"
$simpath/Scenario-Setup/Safe-Sex-Notifications/4-context-start.sh

docker run \
  --name "v3_00_phone_screen_Bob_43232" \
  --net=isolated_nw \
  -t "dsanderscan/mscit_v3_00_phone_screen" \
  /Phone_Screen/Phone_Screen.py --server "$serverIP" --port 43232 > "Bob.txt" &

docker run \
  --name "v3_00_phone_screen_Jing_43232" \
  --net=isolated_nw \
  -t "dsanderscan/mscit_v3_00_phone_screen" \
  /Phone_Screen/Phone_Screen.py --server "$serverIP" --port 43232 > "Bob.txt" &

#$simpath/Scenario-Setup/Safe-Sex-Notifications/A1-configure-Bluetooth.sh
#
curl -X POST -d '{"key":"1234-5678-9012-3456", "bluetooth":"http://'${serverIP}':43126/v3_00"}' http://localhost:43132/v3_00/config/pair
#
curl -X POST -d '{"presence-engine":"http://'${serverIP}':43130/v3_00", "user-id":"Jing"}' http://localhost:43132/v3_00/config/presence ; echo
#
curl -X POST -d '{"relationship":"friend-of-friend"}' http://localhost:43130/v3_00/people/Jing/Bob ; echo
#
curl -X POST http://localhost:43126/v3_00/imnear/Bob ; echo
#
echo "Sleep for 5"
#
curl -X POST -d '{"key":"1234-5678-9012-3456", "sender":"me", "action":"none", "recipient":"http://192.168.0.210:43132/v3_00/notification", "message":"Sensitive message", "sensitivity":true}' http://localhost:43125/v3_00/notification
#
curl -X POST -d '{"key":"1234-5678-9012-3456", "sender":"me", "action":"none", "recipient":"http://192.168.0.210:43132/v3_00/notification", "message":"Urgent sensitive message", "sensitivity":true, "urgency":true}' http://localhost:43125/v3_00/notification
#
sleep 5
#
curl -X POST http://localhost:43126/v3_00/imnear/stuart ; echo
#
echo "Sleep for 5"
#
sleep 5
#
#curl -X DELETE http://localhost:43126/v3_00/imnear/Bob ; echo
#
$simpath/show_log.sh
#$simpath/Scenario-Setup/Safe-Sex-Notifications/stop-scenario.sh

