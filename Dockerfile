FROM ubuntu:14.04

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes software-properties-common python-software-properties && \
    apt-add-repository -y ppa:webupd8team/java && \
    apt-get -y update && \
    /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java8-installer oracle-java8-set-default git
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN cd /tmp && \
    git clone https://github.com/apache/spark.git && \
    cd spark && \
    git checkout v1.6.0

RUN cd /tmp/spark && \
    ./dev/change-scala-version.sh 2.11 && \
    ./make-distribution.sh --name custom-spark --tgz -Dscala-2.11 && \
    tar -xzf spark-1.6.0-bin-custom-spark.tgz -C /usr/local/ && \
    cd /usr/local && ln -s spark-1.6.0-bin-custom-spark spark

ENV SPARK_HOME /usr/local/spark

ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"
ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"



ADD scripts/spark-defaults.conf /spark-defaults.conf
ADD scripts/start-master.sh /start-master.sh
ADD scripts/start-worker.sh /start-worker.sh








ENV SPARK_MASTER_PORT=7077 \
    SPARK_MASTER_WEBUI_PORT=8080 \
    SPARK_WORKER_PORT=8888 \
    SPARK_WORKER_WEBUI_PORT=8081

EXPOSE 8080 7077 8888 8081 4040 7001 7002 7003 7004 7005 7006
