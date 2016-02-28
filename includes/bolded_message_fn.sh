function bolded_message {
    OUTPUT_TEXT=$1
    if [ "X${1}" == "X"  ]; then
        let OUTPUT_TEXT = "Test Execution begins at $(date)"
    fi
    COUNTER=80
    OUTPUT_TEXT_LENGTH=${#OUTPUT_TEXT}
    echo -n "${bold}"
    echo -n $OUTPUT_TEXT
    let COUNTER=$(($COUNTER-$OUTPUT_TEXT_LENGTH))
    while [ $COUNTER -gt 0 ]; do
        echo -n " "
        let COUNTER=COUNTER-1
    done
    echo -n "${normal}"
    echo ""
}
