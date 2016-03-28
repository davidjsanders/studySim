function stop_service {
    # $1 - service port
    # $2 - service name
    echo -n "Stopping service $2 (port $1 on $serverName): "
    check_docker ${version}"_"$2"_"$1   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        echo "already stopped."
    else
        docker kill ${version}"_"$2"_"$1
        echo -n "Removing reserved name: "
        docker rm -f ${version}"_"$2"_"$1
        sleep 1
    fi
    echo ""
}


