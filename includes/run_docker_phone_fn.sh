function run_docker_phone {
    # $1 - Run Version - Note $version is the presented as version
    # $2 - Persist - either PERSIST or anything else to not persist
    # $3 - phonePort
    # $4 - redisPort
    if ! [[ -z "$3" ]]; then
        phone_port=$3
    else
        phone_port=$phonePort
    fi
    if ! [[ -z "$4" ]]; then
        redis_p=$4
    else
        redis_p=$phoneRedisPort
    fi
    echo -n "Starting phone (port $phone_port, redis port $redis_p on $serverName): "
    check_docker "$version"_phone_"$phone_port"   # sets $DOCKER_CHECK
    persist_command=""
    if [ "PERSIST" == "${2}" ]; then
        persist_command="-v $(pwd)/phone/datavolume:/Phone/datavolume"
    fi
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run -p $redis_p:6379 -p $phone_port:$phone_port \
            --net=isolated_nw \
            --name $version"_phone_"$phone_port \
            -e version=$version \
            -e hostIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`" \
            -e portToUse=$phone_port \
            -e serverName="$serverName" \
            -e TZ=`date +%Z` \
            ${persist_command} \
            -d $package$1"_"phone
        sleep 1
    else
        echo "Phone already running."
    fi
}

