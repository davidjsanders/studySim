#!/bin/bash
let stage_count=0
STAGE_PATH="stage2"
STAGE=$STAGE_PATH"_"
SIM_HEADING="Downloading Docker Images"

source $simpath/$STAGE_PATH/includes/includes.sh

pause "Pull down of latest Docker containers, "

set +e
clear
start_message "${SIM_HEADING}"

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 2 base"
docker pull $package""stage2_base

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 2 bluetooth"
docker pull $package""stage2_bluetooth

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 2 logger"
docker pull $package""stage2_logger

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 2 log viewer"
docker pull $package""stage2_log_viewer

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 2 monitor app"
docker pull $package""stage2_monitor_app

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 2 location service"
docker pull $package""stage2_location_service

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 2 notification service"
docker pull $package""stage2_notification

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 2 phone"
docker pull $package""stage2_phone

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 2 phone screen"
docker pull $package""stage2_phone_screen

# Stage 3 images

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 3 log viewer"
docker pull $package""stage3_log_viewer

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 3 monitor app"
docker pull $package""stage3_monitor_app

let stage_count=stage_count+1
pre_test $stage_count "Pull down stage 3 phone"
docker pull $package""stage3_phone

stop_message "${SIM_HEADING}"

