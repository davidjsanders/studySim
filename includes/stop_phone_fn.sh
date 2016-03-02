function stop_phone {
#    echo -n "Stopping phone "${1}": "
#    docker stop "stage2_phone_screen_"${1}
    #$1 - stage
    #$2 - port
    echo -n "Removing phone screen: "
    docker rm -f $1"phone_screen_"${2}
    echo
}


