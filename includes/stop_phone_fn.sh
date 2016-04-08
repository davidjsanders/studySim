function stop_phone {
    # $1 - phone name
    # $2 - Redis port
    # $3 - override version
    if ! [[ -z "$3" ]]; then
        redis_to_use=$3
    else
        redis_to_use=$phoneRedisPort
    fi
    if ! [[ -z "$2" ]]; then
        version_to_use=$2
    else
        version_to_use=$version
    fi
    echo -n "Stopping phone screen ${1}: "
    
    check_docker $presentAs"_phone_screen_"${1}"_"$redis_to_use   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        echo "already stopped."
        echo "Removing phone screen reserved name: already removed."
    else
        set +e
        docker stop $presentAs"_phone_screen_"${1}"_"$redis_to_use
        echo -n "Removing phone screen reserved name: "
        docker rm -f $presentAs"_phone_screen_"${1}"_"$redis_to_use 2> >(grep -v "No such container")
        set -e
    fi
#    sleep 1
    echo
    echo
}


