function run_docker_phone {
    # $1 - Run Version - Note $version is the presented as version
    # $2 - Persist - either PERSIST or anything else to not persist
    echo -n "Starting phone (port $phonePort on $serverName): "
    check_docker "$version"_phone_"$phonePort"   # sets $DOCKER_CHECK
    persist_command=""
    if [ "PERSIST" == "${2}" ]; then
        persist_command="-v $(pwd)/phone/datavolume:/Phone/datavolume"
    fi
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run -p $redis_port:6379 -p $phonePort:$phonePort \
            --net=isolated_nw \
            --name $version"_phone_"$phonePort \
            -e version=$version \
            -e hostIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`" \
            -e portToUse=$phonePort \
            -e serverName="$serverName" \
            -e TZ=`date +%Z` \
            ${persist_command} \
            -d $package$1"_"phone
        sleep 1
    else
        echo "Phone already running."
    fi
}

