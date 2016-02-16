#!/usr/bin/env bash

export SPARK_LOCAL_IP=`/sbin/ifconfig eth0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`
echo "SPARK_LOCAL_IP=$SPARK_LOCAL_IP"

/usr/local/spark/bin/spark-class org.apache.spark.deploy.worker.Worker \
	spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT} \
	--properties-file /spark-defaults.conf \
	"$@"
