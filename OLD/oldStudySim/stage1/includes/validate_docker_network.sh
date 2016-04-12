echo ""
echo "Validating Docker network exists (attempting to create it)"
echo
# Ensure error does not cause an exit
set +e
docker network create --driver bridge isolated_nw
# Set errors to cause an exit
set -e
echo

