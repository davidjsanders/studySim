#!/bin/bash
NAME="LV"$(date +%d%m%Y%H%M%S%N)
docker run -it \
    --name $NAME \
    --net isolated_nw \
    dsanderscan/mscit_stage2_log_viewer $@
docker rm -f $NAME

