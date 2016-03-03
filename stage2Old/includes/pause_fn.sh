function pause {
    let COUNTER=5
    echo
    #echo "Ensure you have run setup before running this simulation"
    echo -n "${1}begins in...5"
    while [ $COUNTER -gt 1 ]; do
        let COUNTER=COUNTER-1
        echo -n ", "$COUNTER
        sleep 1
    done
    sleep 1
    echo ". Starting."
}
