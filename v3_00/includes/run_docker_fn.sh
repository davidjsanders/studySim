function run_docker {
    # $1 - Run Version - Note $version is the presented as version
    # $2 - Port number
    # $3 - Container image name
    # $4 - Directory path
    echo -n "Starting service $3 (port $2 on $serverName): "
    check_docker "$version"_"$3"_"$2"   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run -p $2:$2 \
            --name $version"_"$3"_"$2 \
            --net=isolated_nw \
            -e version=$version \
            -e portToUse=$2 \
            -e serverName="$serverName" \
            -e hostIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`" \
            -e TZ=`date +%Z` \
            -d $package$1"_"$3
        sleep 1
    else
        echo "Instance already running."
    fi
}

function run_docker_persist {
    # $1 - Port number
    # $2 - Container image name
    # $3 - Directory path
    echo "Starting service $2 (port $1 on $serverName)"
    echo -n "Data is being persisted at $(pwd)/$3/datavolume: "
    check_docker "$version"_"$2"_"$1"   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run -p $2:$2 \
            --name $version"_"$3"_"$2 \
            --net=isolated_nw \
            -e version=$version \
            -e portToUse=$2 \
            -e serverName="$serverName" \
            -e hostIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`" \
            -e TZ=`date +%Z` \
            -v $(pwd)/$4/datavolume:/$4/datavolume \
            -d $package$1"_"$3
        sleep 1
    else
        echo "Instance already running."
    fi
}


