# Connect Phone to Bluetooth
let test_id=test_id+1
bluetooth_device='"bluetooth":"'$serverIPName':'$bluePort'/'$presentAs'"'
data='{'$genKey', '$bluetooth_device'}'
do_post "${data}" \
        $phonePort \
        "/"$presentAs"/config/pair" \
        "The phone is paired to the Bluetooth controller" \
        $test_id

echo "Done."
echo
