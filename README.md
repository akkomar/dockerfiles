Spark 1.6  with Scala 2.11

Build:

    docker build -t spark .

    
Run master:

    docker run --rm -it --name spark_master -P spark bash
