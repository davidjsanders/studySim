let COUNTER=4
echo
echo "Ensure you have run setup before running this simulation"
echo -n "Simulation begins in...5"
while [ $COUNTER -gt 0 ]; do
    sleep 1
    echo -n ", "$COUNTER
    let COUNTER=COUNTER-1
done
sleep 1
echo ". Starting."

