# Get the phone's screen
let test_id=test_id+1
screen_filename=$output_folder"screen.txt"
pre_test $test_id "Downloading phone main screen saving to ${screen_filename}"
wget $serverIPName:$phonePort/$presentAs/config/screen -O "${screen_filename}" || true
echo

if [ ${phone2InUse} ]; then
    let test_id=test_id+1
    screen_filename=$output_folder"screen-"${phone2Port}".txt"
    pre_test $test_id "Downloading phone screen screen-${phone2Port} saving to ${screen_filename}"
    wget $serverIPName:$phonePort/$presentAs/config/screen -O "${screen_filename}" || true
    echo
fi

if [ ${phone3InUse} ]; then
    let test_id=test_id+1
    screen_filename=$output_folder"screen-"${phone3Port}".txt"
    pre_test $test_id "Downloading phone screen screen-${phone3Port} saving to ${screen_filename}"
    wget $serverIPName:$phonePort/$presentAs/config/screen -O "${screen_filename}" || true
    echo
fi

# Get the Bluetooth audio default file
let test_id=test_id+1
audio_filename=$output_folder"audio.txt"
server_IP=${serverIP//\./\_} # Convert dots to underscores
pre_test $test_id "Downloading central Bluetooth audio file to ${audio_filename}"
pre_test $test_id $serverIPName:$bluePort/$presentAs/config/audio/$server_IP"_"$phonePort"_"$presentAs
wget $serverIPName:$bluePort/$presentAs/config/audio/$server_IP"_"$phonePort"_"$presentAs -O "${audio_filename}" || true
echo

# Get the central log file
let test_id=test_id+1
export_filename=$output_folder"export.csv"
pre_test $test_id "Downloading central log file (csv) to ${export_filename}"
wget $serverIPName:$loggerPort/$presentAs/logfile -O "${export_filename}" || true
echo

# Get the central log file as human readable
let test_id=test_id+1
log_filename=$output_folder"log.txt"
pre_test $test_id "Downloading central log file (human readable) to ${log_filename}"
source $simpath/show_log.sh -v $presentAs > $log_filename || true
echo "Downloaded ${log_filename}"
echo


