#!/usr/bin/env bash

export SPARK_MASTER_IP=`awk 'NR==1 {print $1}' /etc/hosts`

/usr/local/spark/bin/spark-class org.apache.spark.deploy.master.Master \
  --properties-file /spark-defaults.conf \
  --ip $SPARK_MASTER_IP \
  --port $SPARK_MASTER_PORT \
  --webui-port $SPARK_MASTER_WEBUI_PORT \
	"$@"
