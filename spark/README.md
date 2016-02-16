Spark 1.6  with Scala 2.11

Build:

    docker build -t spark .


Start master:

    docker run -dtP --name spark_master spark /start-master.sh


Start worker:

    docker run -d -t -P -e SPARK_MASTER_HOST=172.17.0.2 spark /start-worker.sh
