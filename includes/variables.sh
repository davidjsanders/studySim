export serverName=`hostname`
export serverIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`"
export serverIPName="http://"$serverIP
export phoneKey='"key":"NS1234-5678-9012-3456"'
export genKey='"key":"1234-5678-9012-3456"'
export package='dsanderscan/mscit_'
export test_pause="0.5"

