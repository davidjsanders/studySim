function finalize {
    let test_id=test_id+1
    FILENAME="RUN-"$(date +%d%m%Y%H%M%S)".log"
    pre_test $test_id "Saving log data to $FILENAME"
    $simpath/show_log.sh > $FILENAME
}
