function stop_service {
    # $1 - service port
    # $2 - service name

    container_name=""$presentAs"_"$2"_"$1

    echo -n "Stopping service ${container_name} - $2 (port $1 on $serverName): "
    check_docker "${container_name}"   # sets $DOCKER_CHECK

    if [ "X" == "${DOCKER_CHECK}" ]; then
        echo "already stopped."
    else
#        docker stop ${container_name}
        docker kill ${container_name}
        echo -n "Removing reserved name: "
        docker rm -f ${container_name}
        sleep 1
    fi
    echo ""
}


