function config_logging {
    # $1 - Port number
    # $2 - Container image name
    export loggerURL=$serverIPName":"$loggerPort"/"$version"/log"
    export payload='{"key":"1234-5678-9012-3456","logger":"'$loggerURL'"}'
    echo "Configure $2 (port $1 on $serverName)"
    echo "Logging to central logger ($loggerURL)"
    echo -n "Result: "
    curl -X POST \
        -d $payload $serverName:$1/$version/config/logger
    sleep .5
    echo ""
    echo ""
}


