FROM ubuntu:14.04

RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes software-properties-common python-software-properties
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get -y update
RUN /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java8-installer oracle-java8-set-default git
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN cd /tmp && \
    git clone https://github.com/apache/spark.git && \
    cd spark && \
    git checkout v1.6.0

WORKDIR "/tmp/spark"

RUN ./build/mvn --version

RUN ./dev/change-scala-version.sh 2.11

#RUN ./build/mvn -Dscala-2.11 -DskipTests clean package
RUN ./make-distribution.sh --name custom-spark --tgz -Dscala-2.11


RUN tar -xzf spark-1.6.0-bin-custom-spark.tgz -C /usr/local/

RUN cd /usr/local && ln -s spark-1.6.0-bin-custom-spark spark

#RUN ./make-distribution.sh --name custom-spark-1.6.0-2.11 --tgz -Phadoop-2.6 -Pyarn -Dscala-2.11 -Phive -Phive-thriftserver
