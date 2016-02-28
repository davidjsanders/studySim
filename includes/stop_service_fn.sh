function stop_service {
    # $1 - service port
    # $2 - service name
    echo -n "Stopping $2: "
    docker kill stage2_$2$1
    echo -n "Removing reserved name: "
    docker rm -f stage2_$2$1
    sleep 1
    echo ""
}


