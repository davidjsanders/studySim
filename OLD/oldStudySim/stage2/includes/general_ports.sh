let start_port=43124
if [ $# -ne 0 ]; then
    echo "Changing ports to $1"
    let start_port=$1
fi

export loggerPort=$start_port

let start_port=start_port+1
export notesvcPort=$start_port

let start_port=start_port+1
export bluePort=$start_port

let start_port=start_port+1
export monitorPort=$start_port

let start_port=start_port+1
export locPort=$start_port

let start_port=start_port+1
let redis_port=start_port+100
export phonePort=$start_port
export phoneRedisPort=$redis_port

export serverName=`hostname`
export serverIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`"
export serverIPName="http://"$serverIP
export phoneKey='"key":"NS1234-5678-9012-3456"'
export genKey='"key":"1234-5678-9012-3456"'
export package='dsanderscan/mscit_'


