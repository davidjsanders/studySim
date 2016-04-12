function stop_service {
    # $1 - stage
    # $2 - service port
    # $3 - service name
    echo -n "Stopping service $3 (port $2 on $serverName): "
    check_docker "$1$3$2"   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        echo "already stopped."
    else
        docker kill $1$3$2
        echo -n "Removing reserved name: "
        docker rm -f $1$3$2
        sleep 1
    fi
    echo ""
}


