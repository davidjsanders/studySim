# Disconnect Phone from Bluetooth
let test_id=test_id+1
data='{'$genKey'}'
do_delete "${data}" \
        $phonePort \
        "/"$presentAs"/config/pair" \
        "The phone is no longer paired to the Bluetooth controller" \
        $test_id

echo "Done."
echo
