#    Scenario: Additional 2 - Configure hot spots
#    ------------------------------------------------------------------------
#    Author:      David J. Sanders
#    Student No:  H00035340
#    Date:        12 Apr 2016
#    ------------------------------------------------------------------------
#    Overivew:    A2-configure-hot-spots.sh defines hot spots that the location
#                 service will report as known hot spots for drug and STI rates.
#                 The monitor app will get the location from the phone, pass it
#                 to the location service and that will decide if it is a hot
#                 spot or not.
#
#                 NOTE: No model changes are made here.
#                 DEPENDENCY: A previous scenario MUST have been setup first.
#
#    Models:
#    None.
#
#
#    Revision History
#    --------------------------------------------------------------------------
#    Date         | By             | Reason
#    --------------------------------------------------------------------------
#    12 Apr 2016  | D Sanders      | Revised structure for simulations.
#
#
#================= Scenario Init - Validate $simpath exists ====================
#
# Validate $simpath is defined and set
#
if [[ -z "$simpath" ]]; then
    echo "ERROR: simpath is not defined!"
    echo ""
    echo "Before running this script, ensure that simpath is defined:"
    echo ""
    echo "  export simpath=/path/to/studySim"
    echo
    exit 1
fi
#
#=================== Scenario Setup - Funciton Definition ======================
#
#
# do_initialize: Setup any variables and headings required
#
do_initialize() {
    sim_heading="NOTIFICATIONS: Configure Bluetooth - Pair phone"
    scenario_includes=$simpath/Scenario-Setup/Notifications/includes
}
#
# do_settings: Set data, apps, and settings for the phone and conencted devices.
#
do_settings() {
    # Define a hot spot in the Monitor App
    let test_id=test_id+1
    loc_lx='"lower-x":200'
    loc_ly='"lower-y":200'
    loc_ux='"upper-x":400'
    loc_uy='"upper-y":400'
    description='"description":"The downtown core; known for high STI rates and drug use"'
    data='{'$genKey', '$loc_lx', '$loc_ly', '$loc_ux', '$loc_uy', '$description'}'
    do_post "${data}" \
            $locPort \
            "/"$presentAs"/config/hotspot/downtown" \
            "The downtown core is configured as a hot spot ($loc_lx,$loc_ly) - ($loc_ux, $loc_uy)" \
            $test_id

    # Define a second hot spot in the Monitor App
    let test_id=test_id+1
    loc_lx='"lower-x":500'
    loc_ly='"lower-y":500'
    loc_ux='"upper-x":600'
    loc_uy='"upper-y":600'
    description='"description":"The midtown core; known for high STI rates and drug use"'
    data='{'$genKey', '$loc_lx', '$loc_ly', '$loc_ux', '$loc_uy', '$description'}'
    do_post "${data}" \
            $locPort \
            "/"$presentAs"/config/hotspot/midtown" \
            "The midtown core is configured as a hot spot ($loc_lx,$loc_ly) - ($loc_ux, $loc_uy)" \
            $test_id

    # Define the phone's starting location
    let test_id=test_id+1
    loc_x='"x":120'
    loc_y='"y":300'
    data='{'$genKey', '$loc_x', '$loc_y'}'
    do_put "${data}" \
           $phonePort \
           "/"$presentAs"/config/location" \
           "The phone's location is set to ($loc_x,$loc_y)" \
           $test_id
}
#
# do_summary: Show the summary of ports for each service used.
#
do_summary() {
    echo
    echo
    echo "Summary of services"
    echo "==================="
    echo "The Phone ${serverName}_${phonePort} location has been set."
    echo "Two hotspots have been defined."
}
#
#========================== Scenario Setup - Main Logic ========================
#
do_initialize

source $simpath/includes/check_params.sh
source $simpath/includes/setup.sh
source $scenario_includes/additional_ports.sh
source $simpath/includes/set_version.sh

clear
set +e
start_message "${sim_heading}"
set -e

do_settings
do_summary

set +e
stop_message "${sim_heading}"
#
#============================= Scenario Setup End ==============================
#

