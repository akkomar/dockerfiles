#!/usr/bin/env bash
cd /usr/local/spark
export SPARK_LOCAL_IP=`awk 'NR==1 {print $1}' /etc/hosts`
./bin/spark-class org.apache.spark.deploy.worker.Worker \
	spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT} \
	--properties-file /spark-defaults.conf \
	-i $SPARK_LOCAL_IP \
	"$@"
