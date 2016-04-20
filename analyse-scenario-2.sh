search_string="SIMENGINE Log Bob is listening"
search_string=$search_string"|SIMENGINE Log Bob is listening"
search_string=$search_string"|SIMENGINE Log Sue is listening"
search_string=$search_string"|SIMENGINE Log Andrew is listening"
search_string=$search_string"|SIMENGINE Log Sue can no longer"
search_string=$search_string"|SIMENGINE Log Andrew can no longer"
search_string=$search_string"|SIMENGINE Setting Sue"
search_string=$search_string"|SIMENGINE Setting Andrew"
search_string=$search_string"|Notification     :"
search_string=$search_string"|Notification from:"

# Only use the for loop to sort by simulation
#for subdir in $(ls -1 -d *v*/);
#do
#    echo 
#    echo "Searching "$(basename $subdir)
#    find ${subdir} -name "log.txt" -exec grep -E "${search_string}" {} + | sort
#done 

for i in *v1*; do   echo ; echo "Searching ${i}" ; find ${i} -name "log.txt" -exec grep -E "${search_string}" {} + | sort ; done 
for i in *v2*; do   echo ; echo "Searching ${i}" ; find ${i} -name "log.txt" -exec grep -E "${search_string}" {} + | sort ; done 

exit


