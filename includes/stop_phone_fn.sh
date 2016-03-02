function stop_phone {
    #$1 - stage
    #$2 - port
    echo -n "Stopping phone screen ${2}: "
    docker stop $1"phone_screen_"${2}
    echo -n "Removing phone screen ${2}: "
    docker rm -f $1"phone_screen_"${2}
    echo
}


