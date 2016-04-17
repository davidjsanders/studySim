#!/bin/bash
################################################################################
#
# Script:       show_log.sh
# Version:      1.00
# Last Updated: 17 April 2016
# Updated By:   D Sanders, University of Liverpool
# Student ID:   H00035340
#
################################################################################
#
# Updates
# -------
# Who        | When         | Why
# -----------|--------------|--------------------------------------------------
# D Sanders  | 17 April 16  | Finalized version for submission.
#
################################################################################
#
# Purpose: The script takes a set of parameters and then runs a query against 
#          the centralized logger. The query is run in a Docker container
#          .
#
################################################################################
#
# Usage
# -----
# $simpath/show-log.sh [-v logger-version] [-V show_log-version] [-p >1023] \
#                      [-l http://server:port/ver/log] [-n service-name] [-h]
#
# Parameters
# ----------
#   Optional
#     -v           version being presented in the model/simulation
#     -V           the version of the logger to use - currently only v3_00 is 
#                  supported
#     -p [number]  The port number to use. Must be higher than 1023
#     -n [name]    Restrict the log to only show entries matching name
#     -h           Show the help message.
#
################################################################################
#
# Check that simpath is defined
#
if [ "X"$simpath == "X" ]; then
    echo "ERROR: simpath is not defined!"
    echo ""
    echo "Before running this script, ensure that simpath is defined:"
    echo ""
    echo "  export simpath=/path/to/studySim"
    echo
    exit 1
fi
#
# Set initial variables
#
stage_path="v3_00"
stage=$stage_path"_"
#
# Validate parameters, do the setup, and set the version
#
source $simpath/includes/check_show_params.sh
source $simpath/includes/setup.sh
source $simpath/includes/set_version.sh
#
# If the logger has been passes as a parameter, set it/
#
if [ -z "${logger_param}" ]; then
    logger_param=$serverIPName":"$loggerPort"/"$presentAs"/log"
fi
#
# If the log query is restricted to a name, set it.
#
if ! [ -z "${name_param}" ]; then
    opt_arg="--server ${name_param}"
else
    opt_arg=''
fi
#
# Run the log viewer in its own container. The container name is LV (log viewer)
# plus the date in the format ddmmyyyyHHMMSS
#
NAME="LV"$(date +%d%m%Y%H%M%S%N)
echo "Running logger in container."
echo "  Container is "$package""$version"_log_viewer"
echo "  Logger is ${logger_param}"
echo 
docker run -it \
    --name $NAME \
    --net isolated_nw \
    $package""$show_log_version"_"log_viewer --logger "${logger_param}" $opt_arg
#
# Once the log viewer has completed, remove the container name.
#
docker rm -f $NAME

