#!/bin/bash
persist_dir=''
container_name=''
redis_port=''
save_param=''
server_name='-e serverName=localhost'
port='5000'
port_param='-e portNumber='$port''
version='v1_00'
version_param='-e version='$version
run_param='NONE'
name_param='NONE'
daemon_param='-it '
old_run_param='-it dsanderscan/mscit_'$version'_phone'
quiet_mode='V'
#
# Usage instructions
#
usage()
{
    echo "Usage: $0 -c name -n Name [-r] [-q] [-p >1023] [-s /absolute/path] [-n service-name] [-h]" 1>&2
    echo
    echo "Required"
    echo "  -c name      The container name, e.g. context"
    echo "  -n name      The short name of the container, e.g. Phone"
    echo
    echo "Optional"
    echo "  -d           Run the container as a daemon - default is interactive"
    echo "  -q           Quiet mode - no output"
    echo "  -r           Randomize container name"
    echo "  -R           Redis port to redirect"
    echo "  -p [number]  The port number to use. Must be higher than 1023"
    echo "  -s [path]    The path to persist the data volume to."
    echo "  -z [string]  The server name the service should use for its url"
    echo "  -v [version] The version of the service to identify as, e.g. v3_00 or v4_00"
    echo "  -h           Show this help message."
    echo
    exit 1; 
}

while getopts "qrs:hp:n:v:c:dz:R:" param; do
    case "$param" in
        c) run_param=$OPTARG
           ;;
        r) container_name="_"$(date +%d%m%Y%H%M%S)""
           ;;
        R) redis_port="-p "$OPTARG":6379"
           ;;
        n) name_param=$OPTARG
           ;;
        d) daemon_param="-d "
           ;;
        s) if [ "$name_param" == "NONE" ]; then
               echo "Name parameter (-n) must be placed BEFORE save parameter (-s)"
               echo
               let error_occurred=1
               break
           fi
           save_param="-v "$OPTARG"/datavolume:/"$name_param"/datavolume"
           ;;
        p) port=$OPTARG
           if ! [[ $port =~ $number_expression ]]; then
               not_allowed="invalid option: port must be a number!"
               let error_occurred=1
               break
           fi
           let port_number=${port}
           if (("${port_number}" < "1024")); then
               not_allowed="invalid option: start port must be higher than 1023"
               let error_occurred=1
               break
           fi
           port_param='-e portToUse='$port_number''
           ;;
        v) version=$OPTARG
           version_param='-e version='$OPTARG
           ;;
        z) server_name='-e serverName='$OPTARG
           ;;
        h) usage
           ;;
        q) quiet_mode='Q'
           ;;
        *) not_allowed="invalid option: -"$OPTARG
           let error_occurred=1
           break
           ;;
    esac
done
if [ "$error_occurred" == "1" ]; then
    echo "${0}: ${not_allowed}"
    echo
    usage
fi
if [[ "$run_param" == "NONE" ]]; then
    echo "The container image must be specified with -c"
    echo
    usage
fi
if [[ "$name_param" == "NONE" ]]; then
    echo "The container name must be specified with -n"
    echo
    usage
fi
if ! [[ -z '${save_param}' ]]; then
    if [[ "$quiet_param" == "V" ]]; then
        echo "Persisting with option: "$save_param
    fi
fi

docker run \
    --name $name_param""$container_name \
    -p $port:$port $redis_port \
    -e hostIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`" \
    -e TZ=`date +%Z` \
    --net=isolated_nw \
    ${port_param} \
    ${save_param} \
    ${server_name} \
    ${version_param} \
    ${daemon_param} ${run_param}
if [ "$daemon_param" == "-it " ]; then
    if [[ "$quiet_mode" == "V" ]]; then
        echo -n "Stopping contianer: "
    fi
    docker stop $name_param""$container_name
    if [[ "$quiet_mode" == "V" ]]; then
        echo -n "Removing contianer: "
    fi
    docker rm $name_param""$container_name
else
    if [[ "$quiet_mode" == "V" ]]; then
        echo "Stop the contianer when done by issuing: docker stop "$lName"_"$container_name
        echo "Then remove the contianer: docker rm "$lName"_"$container_name
    fi
fi

