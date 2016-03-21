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

STAGE_PATH="v3_00"
STAGE=$STAGE_PATH"_"
INCLUDE_PATH=$simpath/$STAGE_PATH/includes

source $INCLUDE_PATH/includes.sh

# TODO
# Think about how to change this to support multiple instances and
# still have a default option?
#
LEN_LINE=$#
COMMAND_LINE="$@"
stage="v3_00_"
#if [ "$LEN_LINE" == "0" ]; then
#    COMMAND_LINE="--logger "$serverIPName":"$loggerPort"/v1_00/log"
#fi

NAME="LV"$(date +%d%m%Y%H%M%S%N)
echo -n "Running logger in container: "
docker run -it \
    --name $NAME \
    --net isolated_nw \
    $package""$stage""log_viewer $COMMAND_LINE
docker rm -f $NAME

