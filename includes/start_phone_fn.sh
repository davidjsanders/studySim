function start_phone {
    # $1 - stage
    # $2 - Phone Screen viewer, e.g. Bob, Jing, or David, etc.
    echo "Add "${2}" as a phone screen viewer. NOTE; output will not be available UNTIL end of test."
    docker run --name $1"phone_screen_"${2} \
        --net=isolated_nw \
        -t dsanderscan/mscit_$1phone_screen \
        /Phone_Screen/Phone_Screen.py --server "$serverIP" --port 16379 > "${2}.txt" &
}


