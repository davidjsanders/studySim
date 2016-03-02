function run_docker_phone {
    echo -n "Starting phone (port $phonePort on $serverName): "
    docker run -p 16379:6379 -p $phonePort:$phonePort \
        --net=isolated_nw \
        --name $1phone$phonePort \
        -e portToUse=$phonePort \
        -e serverName="$serverName" \
        -e TZ=`date +%Z` \
        -d dsanderscan/mscit_$1phone
    sleep 1
}

function run_docker_phone_persist {
    echo -n "Starting phone (port $phonePort on $serverName): "
    docker run -p 16379:6379 -p $phonePort:$phonePort \
        --net=isolated_nw \
        --name $1phone$phonePort \
        -e portToUse=$phonePort \
        -e serverName="$serverName" \
        -e TZ=`date +%Z` \
        -v $PWD/datavolume:/Phone/datavolume \
        -d dsanderscan/mscit_$1phone
    sleep 1
}


