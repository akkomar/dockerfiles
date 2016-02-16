Spark 1.6  with Scala 2.11

## Build:

    docker build -t spark .


## Start master:

    docker run -dtP --name spark_master spark /start-master.sh


## Start worker:

    docker run -d -t -P --name spark_worker -e SPARK_MASTER_HOST=172.17.0.2 spark /start-worker.sh


## Start master & worker:

    docker-compose up

Master web ui: http://localhost:8080/

## Start spark-shell

    docker run -ti --net spark_default spark /usr/local/spark/bin/spark-shell --master spark://172.19.0.2:7077 --executor-memory 500m

    sc.parallelize(1 to 1000).map(_*1000000).map(_/1237.123).collect()

Todo:
* mount data dirs
* In addition, detailed log output for each job is also written to the work directory of each slave node (SPARK_HOME/work by default). You will see two files for each job, stdout and stderr, with all output it wrote to its console.
