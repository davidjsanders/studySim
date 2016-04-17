script_array=("1-Sending-Texts-Raising-Notifications" \
              "2-Hot-Spot-Notifications" \
              "3-Bluetooth-Sending-Texts-Raising-Notifications" \
              "4-Bluetooth-Hot-Spot-Notifications" \
              )

model_set="2-obfuscation-start"
simulation_name="Notifications"
scenario_name="Safe-Sex-Notifications"
scenario_stop="stop-scenario"
header_line=$(printf "%0.s-" {1..77})
array_length=${#script_array[*]}
for i in `seq 0 1 ${array_length}`;
do
    echo
    echo $header_line
    echo "** Starting ${script_array[$i]} at "$(date +"%H:%M:%S")
    echo $header_line
    echo
    $simpath/Scenario-Setup/${scenario_name}/${model_set}.sh "$@"
    $simpath/Simulation-Sets/${simulation_name}/${script_array[$i]}.sh "$@"
    $simpath/Scenario-Setup/${scenario_name}/${scenario_stop}.sh "$@"
    echo
    echo $header_line
    echo "** Completed ${script_array[$i]} at "$(date +"%H:%M:%S")
    echo $header_line
    echo
done
exit

$simpath/Scenario-Setup/Safe-Sex-Notifications/1-no-context-start.sh "$@"
$simpath/Simulation-Sets/Notifications/1-Sending-Texts-Raising-Notifications.sh "$@"
$simpath/Scenario-Setup/Safe-Sex-Notifications/stop-scenario.sh "$@"
#
$simpath/Scenario-Setup/Safe-Sex-Notifications/1-no-context-start.sh "$@"
$simpath/Simulation-Sets/Notifications/2-Hot-Spot-Notifications.sh "$@"
$simpath/Scenario-Setup/Safe-Sex-Notifications/stop-scenario.sh "$@"
#
$simpath/Scenario-Setup/Safe-Sex-Notifications/1-no-context-start.sh "$@"
$simpath/Simulation-Sets/Notifications/3-Bluetooth-Sending-Texts-Raising-Notifications.sh "$@"
$simpath/Scenario-Setup/Safe-Sex-Notifications/stop-scenario.sh "$@"
#
$simpath/Scenario-Setup/Safe-Sex-Notifications/1-no-context-start.sh "$@"
$simpath/Simulation-Sets/Notifications/4-Bluetooth-Hot-Spot-Notifications "$@"
$simpath/Scenario-Setup/Safe-Sex-Notifications/1-no-context-stop.sh "$@"

