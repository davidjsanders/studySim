function run_docker_phone {
    echo -n "Starting phone (port $phonePort on $serverName): "
    check_docker "$1phone$phonePort"   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run -p 16379:6379 -p $phonePort:$phonePort \
            --net=isolated_nw \
            --name $1phone$phonePort \
            -e portToUse=$phonePort \
            -e serverName="$serverName" \
            -e TZ=`date +%Z` \
            -d dsanderscan/mscit_$1phone
        sleep 1
    else
        echo "Phone already running."
    fi
}

function run_docker_phone_persist {
    echo "Starting phone (port $phonePort on $serverName)."
    echo -n "Data is being persisted at $(pwd)/Phone/datavolume: "
    check_docker "$1phone$phonePort"   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run -p 16379:6379 -p $phonePort:$phonePort \
            --net=isolated_nw \
            --name $1phone$phonePort \
            -e portToUse=$phonePort \
            -e serverName="$serverName" \
            -e TZ=`date +%Z` \
            -v $PWD/Phone/datavolume:/Phone/datavolume \
            -d dsanderscan/mscit_$1phone
        sleep 1
    else
        echo "Phone already running."
    fi
}


