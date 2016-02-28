#!/bin/bash
function close_out {
    echo -n "Closing: "
    docker rm -f $NAME
    echo "Done."
}

function run_docker {
    echo -n "Running Log Viewer in container: "
    COMMAND_STRING=" "
    if [ "X${2}" != "X" ]; then
        COMMAND_STRING="--server ${2} --port ${3}"
    fi
    docker run -it \
        --name $NAME \
        --net isolated_nw \
        dsanderscan/mscit_stage2_log_viewer \
            /Log_Viewer/show_server_log.py \
               --logger $1 ${COMMAND_STRING}
}

NAME="LV"$(date +%d%m%Y%H%M%S%N)

if [ "X"$testpath == "X" ]; then
    echo "ERROR: testpath is not defined!"
    echo ""
    echo "Before running this script, ensure that testpath is defined:"
    echo ""
    echo "  export testpath=/path/to/studyTest"
    echo
    exit 1
fi

if [ "X${1}" == "X" ]; then
    echo "A logger server full URL must be provided!"
    echo
    echo "  show_log.sh http://server:port/v/log"
    echo
    exit 1
fi

if [ "X${2}" == "X" ]; then
    echo "Running logger on "$1
    echo ""
    run_docker $1
    close_out
    exit 0
fi

if [ "X${3}" == "X" ]; then
    echo "If a server is provided, then a port must be provided also."
    echo ""
    echo "  show_log.sh http://server:port/v/log dockerMachineName Port"
    echo
    exit 1
fi

echo "Running logger on "$1
echo ""
run_docker $1 $2 $3
close_out
exit 0

