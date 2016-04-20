#!/bin/bash
#
# Get the parameters for the script
#
source $simpath/includes/check_exec_params.sh

echo
echo "Starting execution of all simulations for scenario "$scenario_param
echo "Start port: "$start_port
echo "Scenario:   "$scenario_param
echo "Simulation: "$simulation_param
port_param="-p ${start_port}"

top_header_line=$(printf "%0.s=" {1..77})
header_line=$(printf "%0.s-" {1..77})

# Loop through the models and execute the simulations
for file in $(ls -1 $scenario_param/[0-9]*.sh | sort);
do
    tran_file=$(echo $(basename $file) | tr "-" "\n")
    temp_array=($tran_file)

    let vtu=${temp_array[0]}   # set version to use equal to the model version

    echo
    echo ${top_header_line}
    echo "* Starting "$(basename ${file})" at "$(date +"%H:%M:%S")
    echo ${top_header_line}

    # Loop through the script array and execute the simulations
    for script in $(ls -1 $simulation_param/[0-9]*.sh | sort);
    do
        echo
        echo $header_line
        echo "** Starting "$(basename ${script})" on model "$(basename ${file})" at "$(date +"%H:%M:%S")
        echo $header_line
        echo
        if ! [ $eval_only ]; then
            $file -v v${vtu}"_00" $port_param
            $script -v v${vtu}"_00" $port_param
            $scenario_param/stop-scenario.sh -v v${vtu}"_00" $port_param
        else
            echo "Would do: "$file -v v${vtu}"_00" $port_param
            echo "Then    : "$script -v v${vtu}"_00" $port_param
            echo "Finally : "$scenario_param/stop-scenario.sh -v v${vtu}"_00" $port_param
        fi
        echo
        echo $header_line
        echo "** Completed "$(basename ${script})" on model "$(basename ${file})" at "$(date +"%H:%M:%S")
        echo $header_line
        echo
    done
    echo
    echo ${top_header_line}
    echo "* Completed "$(basename ${file})" at "$(date +"%H:%M:%S")
    echo ${top_header_line}
    echo
done

