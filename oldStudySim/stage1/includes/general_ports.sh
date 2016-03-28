export loggerPort=43124
export notesvcPort=43125
export bluePort=43126
export monitorPort=43127
export locPort=43128
export phonePort=43129
export serverName=`hostname`
#export serverIP="`ifconfig eth0 2>/dev/null|awk '/inet addr:/ {print $2}'|sed 's/addr://'`"
export serverIP="`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`"
export serverIPName="http://"$serverIP
export phoneKey='"key":"NS1234-5678-9012-3456"'
export genKey='"key":"1234-5678-9012-3456"'


