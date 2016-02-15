Spark 1.6  with Scala 2.11

Build:

    docker build -t spark .


Start master:

    docker run -dtP --name spark_master spark /start-master.sh "$@"

    docker run -dtP --name spark_master spark /usr/local/spark/sbin/start-master.sh


Start worker:

    docker run -d -t -P --link spark_master:spark_master spark /start-worker.sh "$@"



TODO: czy potrzebujemy start-master i spark-defaults?
