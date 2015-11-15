#!/bin/bash

if [ -z $ELASTIC_CLUSTER ]; then
  export ELASTIC_CLUSTER=localhost
fi

sed -i "s/<ELASTIC-CLIENT>/$ELASTIC_CLUSTER/g" /opt/kibana/config/kibana.yml

/opt/kibana/bin/kibana

