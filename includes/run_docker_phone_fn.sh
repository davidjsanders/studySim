function run_docker_phone {
    echo -n "Starting phone (port $phonePort on $serverName): "
    docker run -p 16379:6379 -p $phonePort:$phonePort \
        --net=isolated_nw \
        --name stage2_phone$phonePort \
        -e portToUse=$phonePort \
        -e serverName="$serverName" \
        -e TZ=`date +%Z` \
        -v $PWD/datavolume:/Phone/datavolume \
        -d dsanderscan/mscit_stage2_phone /bin/bash -c /Phone/startup.sh \
    sleep 1
}


