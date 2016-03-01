function start_phone {
    # $1 - Phone Screen viewer, e.g. Bob, Jing, or David, etc.
    echo "Add "${1}" as a phone screen viewer. NOTE; output will not be available UNTIL end of test."
    docker run --name "stage2_phone_screen_"${1} \
        --net=isolated_nw \
        -t dsanderscan/mscit_stage2_phone_screen \
        "/Phone_Screen/Phone_Screen.py --server "$serverIP" --port 16379" > "${1}.txt" &
}


