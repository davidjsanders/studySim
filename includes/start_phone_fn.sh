function start_phone {
    # $1 - Phone Screen viewer, e.g. Bob, Jing, or David, etc.
    # $2 - override version
    # $3 - Redis port
    if ! [[ -z "$3" ]]; then
        redis_to_use=$3
    else
        redis_to_use=$phoneRedisPort
    fi
    if ! [[ -z "$2" ]]; then
        version_to_use=$2
    else
        version_to_use=$version
    fi
    echo -n "Add "${1}" as a phone screen viewer. Output will be in ${1}.txt: "
    check_docker ${presentAs}"_phone_screen_"${1}"_"$redis_to_use   # sets $DOCKER_CHECK
    if [ "X" == "${DOCKER_CHECK}" ]; then
        docker run \
          --name $presentAs"_phone_screen_"${1}"_"$redis_to_use \
          --net=isolated_nw \
          -t $package$version_to_use"_phone_screen" \
          /Phone_Screen/Phone_Screen.py --server "$serverIP" --port $redis_to_use > "$output_folder${1}.txt" &
        sleep 2
        echo "started."
    else
        echo "Phone screen already running."
    fi
}


