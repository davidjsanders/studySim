script_array=("1-with-spouse-only" \
              "2-with-spouse-and-colleague"
              )

model_set="1-no-context-start"
simulation_name="In-Car"
simulation_includes=$simpath"/Simulation-Sets/includes"
scenario_name="In-Car-Notifications"
scenario_stop="stop-scenario"
header_line=$(printf "%0.s-" {1..77})
array_length=${#script_array[*]}
source $simulation_includes/exec-steps.sh -v v1
exit

