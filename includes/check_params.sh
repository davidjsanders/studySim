#
# References:
# 1. http://stackoverflow.com/questions/16483119/example-of-how-to-use-getopts-in-bash
# 2. http://stackoverflow.com/questions/806906/how-do-i-test-if-a-variable-is-a-number-in-bash
#
not_allowed=''
number_expression='^[0-9]+$'
save_param=''
let error_occurred=0

usage() { echo "Usage: $0 [-v v9_99] [-p >1023] [-s] [-h]" 1>&2; exit 1; }

while getopts ":shp:v:" param; do
    case "$param" in
        s) save_param="PERSIST"
           ;;
        p) port=$OPTARG
           if ! [[ $port =~ $number_expression ]]; then
               not_allowed="invalid option: port must be a number!"
               let error_occurred=1
               break
           fi
           let ports_param=${port}
           if (("${ports_param}" < "1024")); then
               not_allowed="invalid option: start port must be higher than 1023"
               let error_occurred=1
               break
           fi
           ;;
        v) echo "Version set to "$OPTARG
           version=$OPTARG
           ;;
        h) usage
           ;;
        *) not_allowed="invalid option: -"$OPTARG
           let error_occurred=1
           break
           ;;
    esac
done
if [ "$error_occurred" -eq "1" ]; then
    echo "${0}: ${not_allowed}"
    echo
    usage
fi
if ! [ -z "${ports_param}" ]; then
    start_port=$ports_param
else
    start_port=43124
fi

