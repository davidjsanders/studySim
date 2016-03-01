function run_docker {
    # $1 - Port number
    # $2 - Container image name
    # $3 - Directory path
    echo -n "Starting service $2 (port $1 on $serverName): "
    docker run -p $1:$1 --name stage2_$2$1 \
        --net=isolated_nw -e portToUse=$1 -e serverName="$serverName" \
        -e TZ=`date +%Z` -v $PWD/$3/datavolume:/$3/datavolume \
        -d dsanderscan/mscit_stage2_$2
    sleep 1
}


