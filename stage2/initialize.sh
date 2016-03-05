
STAGE_PATH="stage2"
STAGE=$STAGE_PATH"_"
SIM_HEADING="Simulation set 1"

source $simpath/$STAGE_PATH/includes/includes.sh

pause "Pull down of latest Docker containers, "

set +e
clear
start_message "${SIM_HEADING}"

pre_test 1 "Pull down stage 2 images."
docker pull dsanderscan/mscit_stage2_base
docker pull dsanderscan/mscit_stage2_bluetooth
docker pull dsanderscan/mscit_stage2_logger
docker pull dsanderscan/mscit_stage2_log_viewer
docker pull dsanderscan/mscit_stage2_monitor_app
docker pull dsanderscan/mscit_stage2_location_service
docker pull dsanderscan/mscit_stage2_notification
docker pull dsanderscan/mscit_stage2_phone
docker pull dsanderscan/mscit_stage2_phone_screen

pre_test 2 "Pull down stage 3 images."
docker pull dsanderscan/mscit_stage3_log_viewer
docker pull dsanderscan/mscit_stage3_monitor_app
docker pull dsanderscan/mscit_stage3_phone

stop_message "${SIM_HEADING}"

