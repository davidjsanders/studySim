function stop_phone {
    # $1 - phone name
    echo -n "Stopping phone screen ${1}: "
    check_docker $version"_phone_screen_"${1}"_"$redis_port   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        echo "already stopped."
        docker rm -f $version"_phone_screen_"${1}"_"$redis_port
        sleep 1
    else
        docker stop $version"_phone_screen_"${1}"_"$redis_port
        echo -n "Removing phone screen ${1}: "
        docker rm -f $version"_phone_screen_"${1}"_"$redis_port
        sleep 1
    fi
    echo
}


