echo ""
echo "Pulling down latest container images in 5 seconds."
echo "Press ^c to cancel"
echo ""
sleep 5
docker pull dsanderscan/pythonbase
docker pull dsanderscan/mscit_stage2_bluetooth
docker pull dsanderscan/mscit_stage2_logger
docker pull dsanderscan/mscit_stage2_log_viewer
docker pull dsanderscan/mscit_stage2_monitor_app
docker pull dsanderscan/mscit_stage2_phone
docker pull dsanderscan/mscit_stage2_location_service
docker pull dsanderscan/mscit_stage2_notification
docker pull dsanderscan/mscit_stage2_phone_screen
