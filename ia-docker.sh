#!/bin/bash

USAGE="Usage: ia-docker.sh [-p | -r | -t | -l | -h] tag"

COMMAND=""
while getopts ptrlh OPTCHAR
do
        case $OPTCHAR in
        h) echo $USAGE >&2;
           echo "operations on all IA images" >&2
           echo "Otions:" >&2
           echo "-p : pull" >&2
           echo "-t : tag as latest" >&2
           echo "-r : remove" >&2
           echo "-l : list" >&2
           echo "-h : print usage and exit" >&2
           echo "example: ia-docker.sh -p V7.15.3.0.1b2" >&2
           exit 1;;
        p) COMMAND="pull";;
        r) COMMAND="remove";;
        t) COMMAND="tag-latest";;
        l) COMMAND="list";;
        ?) echo $USAGE >&2;
           exit 1;;
        esac
done
shift $(($OPTIND - 1))

if [ $# -ne 1 -o -z "$COMMAND" ]; then
    echo $USAGE >&2
    exit 1
fi
BTAG=$1; shift

DREG=iris-analytics.tk

IMAGES_LIST="";
IMAGES_LIST+=" centos-base"
IMAGES_LIST+=" anaconda"
IMAGES_LIST+=" ansible"
IMAGES_LIST+=" collection"
IMAGES_LIST+=" cubrid"
IMAGES_LIST+=" dbm-bulk-loader"
IMAGES_LIST+=" dbm-ilm"
IMAGES_LIST+=" dbm-jdbc-service"
IMAGES_LIST+=" diamond-collector"
IMAGES_LIST+=" haproxy"
IMAGES_LIST+=" yum-repo"
IMAGES_LIST+=" influxdb"
IMAGES_LIST+=" iris-properties-webservice"
IMAGES_LIST+=" model-manager"
IMAGES_LIST+=" oam"
IMAGES_LIST+=" postgres"
IMAGES_LIST+=" provisioning"
IMAGES_LIST+=" pypi-repo"
IMAGES_LIST+=" sensu-api"
IMAGES_LIST+=" sensu-client"
IMAGES_LIST+=" sensu-server"
IMAGES_LIST+=" sensu-uchiwa"
IMAGES_LIST+=" ui-dbm-query"
IMAGES_LIST+=" ui-discovery"

for IMAGE in $IMAGES_LIST; do
    case "$COMMAND" in
    tag-latest)
	( set -x; docker pull $DREG/${IMAGE}:$BTAG )
	( set -x; docker tag -f $DREG/${IMAGE}:$BTAG $DREG/$IMAGE:latest )
	( set -x; docker push $DREG/$IMAGE:latest )
        ;;
    pull)
	( set -x; docker pull $DREG/${IMAGE}:$BTAG )
        ;;
    remove)
	( set -x; docker rmi -f $DREG/${IMAGE}:$BTAG )
        ;;
    list)
	echo $DREG/${IMAGE}:$BTAG
        ;;
    *)  echo error COMMAND=$COMMAND >&2;;
    esac
#	curl http://$DREG/v2/$IMAGE/tags/list
done
