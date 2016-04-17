#
# do_settings: Set data, apps, and settings for the phone and conencted devices.
#
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

