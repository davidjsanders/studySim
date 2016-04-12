# Configure message for app launch
let test_id=test_id+1
data='{'$genKey', "text":"Wacka! Wacka! Wacka!"}'
do_put "${data}" \
       $monitorPort \
       "/"$presentAs"/config/app_message" \
       "Jing configures an obfuscated message for app launch detection." \
       $test_id

# Configure message for hot spot location detection
let test_id=test_id+1
data='{'$genKey', "text":"Wacka! Wacka! Wacka!"}'
do_put "${data}" \
       $monitorPort \
       "/"$presentAs"/config/location_message" \
       "Jing configures an obfuscated message for location detection." \
       $test_id


