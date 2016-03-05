function run_docker {
    # $1 - stage precursor (optional, used for stage2_, stage3_, etc.)
    # $2 - Port number
    # $3 - Container image name
    # $4 - Directory path
    echo -n "Starting service $3 (port $2 on $serverName): "
    check_docker "$1$3$2"   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run -p $2:$2 --name $1$3$2 \
            --net=isolated_nw -e portToUse=$2 -e serverName="$serverName" \
            -e TZ=`date +%Z` \
            -d $package$1$3
        sleep 1
    else
        echo "Instance already running."
    fi
}

function run_docker_persist {
    # $1 - stage precursor (optional, used for stage2_, stage3_, etc.)
    # $2 - Port number
    # $3 - Container image name
    # $4 - Directory path
    echo "Starting service $3 (port $2 on $serverName)"
    echo -n "Data is being persisted at $(pwd)/$4/datavolume: "
    check_docker "$1$3$2"   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run -p $2:$2 --name $1$3$2 \
            --net=isolated_nw -e portToUse=$2 -e serverName="$serverName" \
            -e TZ=`date +%Z` -v $(pwd)/$4/datavolume:/$4/datavolume \
            -d $package$1$3
        sleep 1
    else
        echo "Instance already running."
    fi
}


