#
# do_settings: Set data, apps, and settings for the phone and conencted devices.
#
# Disconnect frpm Monitor App
let test_id=test_id+1
data='{'$genKey'}'
do_delete "${data}" \
        $phonePort \
        "/"$presentAs"/config/monitor" \
        "Jing shutsdown the Besoain, et al, (2015) Monitor App" \
        $test_id

# Delete the hot spot downtown in the Monitor App
let test_id=test_id+1
data='{'$genKey'}'
do_delete "${data}" \
          $locPort \
          "/"$presentAs"/config/hotspot/downtown" \
          "Remove the downtown core as a hot spot." \
          $test_id

# Define a second hot spot in the Monitor App
let test_id=test_id+1
data='{'$genKey'}'
do_delete "${data}" \
          $locPort \
          "/"$presentAs"/config/hotspot/midtown" \
          "Remove midtown as a hot spot." \
          $test_id

# Define the phone's location
let test_id=test_id+1
loc_x='"x":0'
loc_y='"y":0'
data='{'$genKey', '$loc_x', '$loc_y'}'
do_put "${data}" \
       $phonePort \
       "/"$presentAs"/config/location" \
       "The phone's location is set to ($loc_x,$loc_y)" \
       $test_id

