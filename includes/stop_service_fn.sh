function stop_service {
    # $1 - stage
    # $2 - service port
    # $3 - service name
    echo -n "Stopping $3: "
    docker kill $1$3$2
    echo -n "Removing reserved name: "
    docker rm -f $1$3$2
    sleep 1
    echo ""
}


