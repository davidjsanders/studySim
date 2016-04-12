version="v3_00"
presentAs="v3_00"
stage=$stage_path"_"
include_path=$simpath/$version/includes
#
source $include_path/pause_fn.sh
source $include_path/variables.sh
source $include_path/startup.sh
source $include_path/general_ports.sh
source $include_path/validate_docker_network.sh
#
source $include_path/bolded_message_fn.sh
source $include_path/check_docker_fn.sh
source $include_path/clear_fn.sh
source $include_path/config_logging_fn.sh
source $include_path/curl_fn.sh
source $include_path/end_test_message_fn.sh
source $include_path/finalize_fn.sh
source $include_path/post_test_fn.sh
source $include_path/pre_test_fn.sh
source $include_path/run_docker_fn.sh
source $include_path/run_docker_phone_fn.sh
source $include_path/screen_decorations.sh
source $include_path/start_phone_fn.sh
source $include_path/start_test_message_fn.sh
source $include_path/start_message_fn.sh
source $include_path/stop_message_fn.sh
source $include_path/stop_phone_fn.sh
source $include_path/stop_service_fn.sh

