function check_docker {
    set +e
    RETURN_VALUE=0
    DOCKER_CHECK="X"$(docker ps -a | grep ""$1)
#    echo $DOCKER_CHECK
    set -e
}
