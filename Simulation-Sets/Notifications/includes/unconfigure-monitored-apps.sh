# Configure Grindr as a monitored application
let test_id=test_id+1
data='{'$genKey', "description":"Grindr is an app for men seeking men"}'
do_delete "${data}" \
        $monitorPort \
        "/"$presentAs"/app/grindr" \
        "Jing stops Grindr as a monitored application" \
        $test_id

# Validate Grindr is no longer being monitored - returns 404
let test_id=test_id+1
data='{'$genKey'}'
do_get "${data}" \
       $monitorPort \
       "/"$presentAs"/app/grindr" \
       "SIMENGINE: Validate Grindr is no longer being monitored - 404 returned" \
        $test_id

# Configure ManHunt as a monitored application
let test_id=test_id+1
data='{'$genKey', "description":"ManHunt is a location based app for men seeking men"}'
do_delete "${data}" \
        $monitorPort \
        "/"$presentAs"/app/manhunt" \
        "Jing stops ManHunt as a monitored application" \
        $test_id

# Validate ManHunt is being monitored
let test_id=test_id+1
data='{'$genKey'}'
do_get "${data}" \
       $monitorPort \
       "/"$presentAs"/app/manhunt" \
       "SIMENGINE: Validate ManHunt is no longer being monitored - 404 returned" \
        $test_id

# Disconnect to Monitor App
let test_id=test_id+1
data='{'$genKey'}'
do_delete "${data}" \
        $phonePort \
        "/"$presentAs"/config/monitor" \
        "Jing shutsdown the Besoain, et al, (2015) Monitor App" \
        $test_id

echo "Done."
echo
