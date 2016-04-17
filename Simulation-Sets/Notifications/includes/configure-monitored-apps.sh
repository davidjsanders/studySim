# Connect to Monitor App
let test_id=test_id+1
monitor_app='"monitor-app":"'$serverIPName':'$monitorPort'/'$presentAs'"'
service='"notification-service":"'$serverIPName':'$notesvcPort'/'$presentAs'/notification"'
recipient='"recipient":"'$serverIPName':'$phonePort'/'$presentAs'/notification"'
location='"location-service":"'$serverIPName':'$locPort'/'$presentAs'/check"'
provider='"location-provider":"'$serverIPName':'$phonePort'/'$presentAs'/location"'
data='{'$genKey', '$monitor_app', '$service', '$recipient', '$location', '$provider'}'
do_post "${data}" \
        $phonePort \
        "/"$presentAs"/config/monitor" \
        "Jing uses the Besoain, et al, (2015) Monitor App and his phone enables it automatically. " \
        $test_id

# Configure Grindr as a monitored application
let test_id=test_id+1
data='{'$genKey', "description":"Grindr is an app for men seeking men"}'
do_post "${data}" \
        $monitorPort \
        "/"$presentAs"/app/grindr" \
        "Jing sets Grindr as a monitored application" \
        $test_id

# Validate Grindr is being monitored
let test_id=test_id+1
data='{'$genKey'}'
do_get "${data}" \
       $monitorPort \
       "/"$presentAs"/app/grindr" \
       "SIMENGINE: Validate Grindr is being monitored" \
        $test_id

# Configure ManHunt as a monitored application
let test_id=test_id+1
data='{'$genKey', "description":"ManHunt is a location based app for men seeking men"}'
do_post "${data}" \
        $monitorPort \
        "/"$presentAs"/app/manhunt" \
        "Jing sets ManHunt as a monitored application" \
        $test_id

# Validate ManHunt is being monitored
let test_id=test_id+1
data='{'$genKey'}'
do_get "${data}" \
       $monitorPort \
       "/"$presentAs"/app/manhunt" \
       "SIMENGINE: Validate ManHunt is being monitored" \
        $test_id

echo "Done."
echo
