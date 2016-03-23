#!/bin/bash
let stage_count=0
stage_path="v3_00"
current_directory=$(pwd)

source $simpath/includes/_do_first.sh

sim_heading="Downloading Docker Images"

pause "Pull down of latest Docker containers, "

set +e
clear
start_message "${sim_heading} - v3_00"

let stage_count=stage_count+1
pre_test $stage_count "Ensure studysim is up to date"
cd $simpath
git pull
cd $current_directory

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_00 base"
docker pull $package""$version"_base"

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_00 bluetooth"
docker pull $package""$version"_bluetooth"

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_00 logger"
docker pull $package""$version"_logger"

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_00 log viewer"
docker pull $package""$version"_log_viewer"

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_00 monitor app"
docker pull $package""$version"_monitor_app"

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_00 location service"
docker pull $package""$version"_location_service"

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_00 notification service"
docker pull $package""$version"_notification"

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_00 phone"
docker pull $package""$version"_phone"

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_00 phone screen"
docker pull $package""$version"_phone_screen"

#
# v3_00
#
start_message "${sim_heading} - v3_01"

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_01 Monitor App"
docker pull $package"v3_01_monitor_app"

let stage_count=stage_count+1
pre_test $stage_count "Pull down v3_01 Phone"
docker pull $package"v3_01_phone"

stop_message "${sim_heading}"

