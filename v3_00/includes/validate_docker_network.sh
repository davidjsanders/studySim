set +e
DOCKER_NETWORK="X"$(docker network inspect isolated_nw 2>/dev/null | grep "isolated_nw")
if [ "X" == "${DOCKER_NETWORK}" ]; then
    echo -n "Creating Docker network isolated_nw: "
    docker network create --driver bridge isolated_nw
    sleep 1
else
    echo "Using Docker network isolated_nw."
fi
# Set errors to cause an exit
set -e
echo

