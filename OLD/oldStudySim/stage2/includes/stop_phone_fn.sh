function stop_phone {
    #$1 - stage
    #$2 - port
    echo -n "Stopping phone screen ${2}: "
    check_docker $1"phone_screen_"${2}$redis_port   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        echo "already stopped."
    else
        docker stop $1"phone_screen_"${2}$redis_port
        echo -n "Removing phone screen ${2}: "
        docker rm -f $1"phone_screen_"${2}$redis_port
        sleep 1
    fi
    echo
}


