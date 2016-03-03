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
            -d dsanderscan/mscit_$1$3
        sleep 1
    else
        echo "Instance already running."
    fi
}

function run_docker_persist {
    # $1 - Port number
    # $2 - Container image name
    # $3 - Directory path
    echo -n "Starting service $2 (port $1 on $serverName): "
    docker run -p $2:$2 --name stage2_$2$1 \
        --net=isolated_nw -e portToUse=$1 -e serverName="$serverName" \
        -e TZ=`date +%Z` -v $PWD/$3/datavolume:/$3/datavolume \
        -d dsanderscan/mscit_stage2_$2
    sleep 1
}


