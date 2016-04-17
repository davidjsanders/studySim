script_array=("1-Sending-Texts-Raising-Notifications" \
              "2-Hot-Spot-Notifications" \
              "3-Bluetooth-Sending-Texts-Raising-Notifications" \
              "4-Bluetooth-Hot-Spot-Notifications" \
              )

model_set="4-context-start"
simulation_name="Notifications"
simulation_includes=$simpath"/Simulation-Sets/"${simulation_name}"/includes"
scenario_name="Safe-Sex-Notifications"
scenario_stop="stop-scenario"
header_line=$(printf "%0.s-" {1..77})
array_length=${#script_array[*]}
source $simulation_includes/exec-steps.sh
exit

