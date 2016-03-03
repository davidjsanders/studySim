#!/bin/bash
if [ "X"$simpath == "X" ]; then
    echo "ERROR: simpath is not defined!"
    echo ""
    echo "Before running this script, ensure that simpath is defined:"
    echo ""
    echo "  export simpath=/path/to/studySim"
    echo
    exit 1
fi

STAGE_PATH="stage2"
STAGE=$STAGE_PATH"_"
INCLUDE_PATH=$simpath/$STAGE_PATH/includes

source $INCLUDE_PATH/includes.sh

LEN_LINE=$#
COMMAND_LINE="$@"
if [ "$LEN_LINE" == "0" ]; then
    COMMAND_LINE="--logger "$serverIPName":"$loggerPort"/v1_00/log"
fi

NAME="LV"$(date +%d%m%Y%H%M%S%N)
echo -n "Running logger in container: "
docker run -it \
    --name $NAME \
    --net isolated_nw \
    dsanderscan/mscit_stage2_log_viewer $COMMAND_LINE
docker rm -f $NAME

