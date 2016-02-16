#!/usr/bin/env bash

export SPARK_LOCAL_IP=`awk 'NR==1 {print $1}' /etc/hosts`

/usr/local/spark/bin/spark-class org.apache.spark.deploy.worker.Worker \
	spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT} \
	--properties-file /spark-defaults.conf \
	"$@"
