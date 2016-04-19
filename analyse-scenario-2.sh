search_string="SIMENGINE Log Bob is listening"
search_string=$search_string"|SIMENGINE Log Sue is listening"
search_string=$search_string"|SIMENGINE Log Andrew is"
search_string=$search_string"|(Phone.*Notification     : Wacka)"
search_string=$search_string"|Notification     :"
search_string=$search_string"|(Notification     : You have entered)"
search_string=$search_string"|Bluetooth Broadcast: Wacka"
search_string=$search_string"|Bluetooth Broadcast:You have entered"
search_string=$search_string"|Bluetooth Broadcast: The application"
search_string=$search_string"|SIMENGINE Log Bob can no"
search_string=$search_string"|SIMENGINE Log Sue can no"
search_string=$search_string"|SIMENGINE Log Andrew can no"
search_string=$search_string"|SIMENGINE Log Bob"
search_string=$search_string"|Notification from: Monitor"

for i in *v1*; do   echo ; echo "Searching ${i}" ; find ${i} -name "log.txt" -exec grep -E "${search_string}" {} + | sort ; done 
for i in *v2*; do   echo ; echo "Searching ${i}" ; find ${i} -name "log.txt" -exec grep -E "${search_string}" {} + | sort ; done 
#for i in *v3*; do   echo ; echo "Searching ${i}" ; find ${i} -name "log.txt" -exec grep -E "${search_string}" {} + | sort ; done 
#for i in *v4*; do   echo ; echo "Searching ${i}" ; find ${i} -name "log.txt" -exec grep -E "${search_string}" {} + | sort ; done

exit


