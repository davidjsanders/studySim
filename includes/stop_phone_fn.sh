function stop_phone {
#    echo -n "Stopping phone "${1}": "
#    docker stop "stage2_phone_screen_"${1}
    echo -n "Removing phone screen: "
    docker rm -f "stage2_phone_screen_"${1}
    echo
}


