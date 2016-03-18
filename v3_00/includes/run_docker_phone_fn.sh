function run_docker_phone {
    # $1 - Run Version - Note $version is the presented as version
    echo -n "Starting phone (port $phonePort on $serverName): "
    check_docker "$version"_phone_"$phonePort"   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run -p $redis_port:6379 -p $phonePort:$phonePort \
            --net=isolated_nw \
            --name $version"_phone_"$phonePort \
            -e version=$version \
            -e hostIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`" \
            -e portToUse=$phonePort \
            -e serverName="$serverName" \
            -e TZ=`date +%Z` \
            -d $package$1"_"phone
        sleep 1
    else
        echo "Phone already running."
    fi
}

function run_docker_phone_persist {
    echo "Starting phone (port $phonePort on $serverName)."
    echo -n "Data is being persisted at $(pwd)/Phone/datavolume: "
    check_docker "$version"_phone_"$phonePort"   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run -p $redis_port:6379 -p $phonePort:$phonePort \
            --net=isolated_nw \
            --name $version"_phone_"$phonePort \
            -e version=$presentAs \
            -e hostIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`" \
            -e portToUse=$phonePort \
            -e serverName="$serverName" \
            -e TZ=`date +%Z` \
            -v $PWD/Phone/datavolume:/Phone/datavolume \
            -d $package${version}"_"phone
        sleep 1
    else
        echo "Phone already running."
    fi
}


