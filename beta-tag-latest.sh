#!/bin/bash
set -x

if [ $# -lt 1 ]; then
    echo "Usage: beta-tag-latest.sh 1.0.0-beta.12" >&2
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
echo IMAGES_LIST $IMAGES_LIST

for IMAGE in $IMAGES_LIST; do
	echo docker tag $DREG/${IMAGE}:$BTAG $DREG/$IMAGE:latest
	curl http://$DREG/v2/$IMAGE/tags/list
done
