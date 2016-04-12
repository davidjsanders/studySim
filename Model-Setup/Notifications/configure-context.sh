# Add a user Jing to the presence engine, with status available
let test_id=test_id+1
userstatus='"status":"available"'
data='{'$userstatus'}'
do_post "${data}" \
        $presencePort \
        "/"$presentAs"/user/Jing" \
        "Add a user Jing to the presence engine, with status available" \
        $test_id

# Connect the phone to the context engine
let test_id=test_id+1
context='"context-engine":"'$serverIPName':'$contextPort'/'$presentAs'/subscribe"'
data='{'$genKey', '$context'}'
do_put "${data}" \
       $phonePort \
       "/"$presentAs"/config/context" \
       "Set the phone to connect to the context engine at "$serverIPName":"$contextPort \
       $test_id

# Turn autosense on
let test_id=test_id+1
data='{'$genKey'}'
do_post "${data}" \
          $phonePort \
          "/"$presentAs"/config/auto-sense" \
          "Set the phone auto sense feature to on to check profanity, etc." \
          $test_id

