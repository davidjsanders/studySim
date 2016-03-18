function finalize {
    let test_id=test_id+1
    filename="RUN-"$(date +%d%m%Y%H%M%S)".log"
    pre_test $test_id "Saving log data to $filename"
    $simpath/$version/show_log.sh --logger $serverIPName:$loggerPort/$version/log > $filename
    echo
}
