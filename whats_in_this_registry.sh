#!/bin/bash
DOCKER_REG_PUBLISH_PORT=5000
check_docker_registry() {
  echo "Contents of the local Docker registry:"
  IMAGE_LIST="collection cubrid dbm-bulk-loader dbm-ilm dbm-jdbc-service diamond-collector"
  IMAGE_LIST="$IMAGE_LIST elk influxdb iris-properties-webservice model-manager provisioning"
  IMAGE_LIST="$IMAGE_LIST docker-logstash-shipper rabbitmq redis sensu-api sensu-client sensu-server sensu-uchiwa"
  IMAGE_LIST="$IMAGE_LIST ui-dbm-query ui-discovery grafana"
  # This prints the contents of the Registy
  curl http://localhost:$DOCKER_REG_PUBLISH_PORT/v2/_catalog
  echo "###########################################"
  for IMAGE in $IMAGE_LIST
  do
    curl http://localhost:$DOCKER_REG_PUBLISH_PORT/v2/$IMAGE/tags/list
  done
}
check_docker_registry