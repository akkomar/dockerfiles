#!/usr/bin/env bash

export SPARK_MASTER_IP=`/sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`
export SPARK_LOCAL_IP=`/sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`
echo "SPARK_LOCAL_IP=$SPARK_LOCAL_IP"

/usr/local/spark/bin/spark-class org.apache.spark.deploy.master.Master \
  --properties-file /spark-defaults.conf \
  --ip $SPARK_MASTER_IP \
  --port $SPARK_MASTER_PORT \
  --webui-port $SPARK_MASTER_WEBUI_PORT \
	"$@"
