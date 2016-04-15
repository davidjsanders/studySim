echo ""
echo "Configure phone for Bluetooth"
echo "============================="
echo
over_view="Configuring the phone to use Bluetooth. Notifications received "
over_view=$over_view"on the phone will be displayed and broadcast using the "
over_view=$over_view"Bluetooth service. The default audio will be used AND "
over_view=$over_view"message timestamps compared to when someone arrives and "
over_view=$over_view"departs to see the privacy impact."
printf "${over_view}"
echo

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
