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

stage_path="v3_00"
stage=$stage_path"_"

source $simpath/includes/check_show_params.sh

source $simpath/includes/_do_first.sh

if [ -z "${logger_param}" ]; then
    logger_param=$serverIPName":"$loggerPort"/"$presentAs"/log"
fi

if ! [ -z "${name_param}" ]; then
    opt_arg="--server ${name_param}"
else
    opt_arg=''
fi

NAME="LV"$(date +%d%m%Y%H%M%S%N)
echo "Running logger in container."
echo "  Container is "$package""$stage"log_viewer"
echo "  Logger is ${logger_param}"
echo 
docker run -it \
    --name $NAME \
    --net isolated_nw \
    $package""$version"_"log_viewer --logger "${logger_param}" $opt_arg
docker rm -f $NAME

