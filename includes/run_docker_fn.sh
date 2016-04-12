function run_docker {
    if ! [[ -z "$1" ]]; then
        redis_port="-R "$1
    else
        redis_port=""
    fi

    echo -n "Starting "$cModule". "$cv" presenting as ${presentAs} on port ${cPort}: "
    container_image="dsanderscan/mscit_"$cv"_"$cModule
    container_name=""$presentAs"_"$cModule"_"$cPort 
    check_docker "${container_name}"
    if [ "X" == "${DOCKER_CHECK}" ]; then
        $simpath/run-docker.sh \
            -c $container_image \
            -n $container_name \
            -p $cPort \
            -v $presentAs \
            -d -q \
            $redis_port \
            -z $serverName
    else
        echo "already started."
    fi
}

function old_run_docker {
    # $1 - Run Version - Note $version is the presented as version
    # $2 - Port number
    # $3 - Container image name
    # $4 - Directory path
    # $5 - Persist - either PERSIST or anything else to not persist

    container_name="X"$presentAs"_"$3"_"$2

    echo -n "Starting service $3 (port $2 on $serverName): "

    check_docker "${container_name}"   # sets $DOCKER_CHECK
    persist_command=""
    if [ "PERSIST" == "${5}" ]; then
        #TODO Check - should this be $(pwd)/$4/ and not just $4/ ???
#        persist_command="-v $(pwd)/$4/datavolume:/$4/datavolume"
        persist_command="-s $(pwd)/$4"
    fi
    if [ "X" == "${DOCKER_CHECK}" ]; then
        $simpath/run-docker.sh \
            -c $package""$1"_"$3 \
            -n "${container_name}" \
            -p $2 \
            -v $presentAs \
            -d -q \
            -z $serverName \
            "${persist_command}"
#        docker run -p $2:$2 \
#            --name $version"_"$3"_"$2 \
#            --net=isolated_nw \
#            -e version=$presentAs \
#            -e portToUse=$2 \
#            -e serverName="$serverName" \
#            -e hostIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`" \
#            -e TZ=`date +%Z` \
#            ${persist_command} \
#            -d $package$1"_"$3
        sleep 1
    else
        echo "Instance already running."
    fi
}


