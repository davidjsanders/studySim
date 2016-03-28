function start_phone {
    # $1 - Phone Screen viewer, e.g. Bob, Jing, or David, etc.
    echo -n "Add "${1}" as a phone screen viewer. Output will be in ${1}.txt: "
    check_docker ${version}"_phone_screen_"${1}"_"$redis_port   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run \
          --name $version"_phone_screen_"${1}"_"$redis_port \
          --net=isolated_nw \
          -t $package$version"_phone_screen" \
          /Phone_Screen/Phone_Screen.py --server "$serverIP" --port $redis_port > "${1}.txt" &
        sleep 2
        echo "started."
    else
        echo "Phone screen already running."
    fi
}


