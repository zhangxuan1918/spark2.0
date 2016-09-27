FROM ubuntu:16.04
# Modified from https://github.com/gettyimages/docker-spark/blob/master/Dockerfile and https://github.com/ogrisel/docker-openblas/blob/master/Dockerfile

ADD openblas.conf /etc/ld.so.conf.d/openblas.conf
ADD build_openblas.sh build_openblas.sh
RUN bash build_openblas.sh

RUN apt-get update \
 && apt-get install -y locales \
 && dpkg-reconfigure -f noninteractive locales \
 && locale-gen en_US.UTF-8 \
 && /usr/sbin/update-locale LANG=en_US.UTF-8 \
 && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && locale-gen \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Users with other locales should set this in their derivative image
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

RUN apt-get update \
 && apt-get install -y curl unzip \
    python2.7 python2.7-setuptools \
    build-essential python-dev \
 && ln -sf /usr/bin/python2.7 /usr/bin/python \
 && easy_install pip py4j \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Install requirements
ADD requirements.txt /
RUN pip install -r requirements.txt

ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# JAVA
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=92
ARG JAVA_BUILD_NUMBER=14
ENV JAVA_HOME /usr/jdk1.${JAVA_MAJOR_VERSION}.0_${JAVA_UPDATE_VERSION}

ENV PATH $PATH:$JAVA_HOME/bin
RUN curl -sL --retry 3 --insecure \
  --header "Cookie: oraclelicense=accept-securebackup-cookie;" \
  "http://download.oracle.com/otn-pub/java/jdk/${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-b${JAVA_BUILD_NUMBER}/server-jre-${JAVA_MAJOR_VERSION}u${JAVA_UPDATE_VERSION}-linux-x64.tar.gz" \
  | gunzip \
  | tar x -C /usr/ \
  && ln -s $JAVA_HOME /usr/java \
  && rm -rf $JAVA_HOME/man

# HADOOP
ENV HADOOP_VERSION 2.7.2
ENV HADOOP_MAJOR_VERSION 2.7
ENV HADOOP_HOME_VERSION /usr/hadoop-$HADOOP_VERSION
ENV HADOOP_HOME /usr/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
RUN curl -sL --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
  | gunzip \
  | tar -x -C /usr/ \
 && chown -R root:root $HADOOP_HOME_VERSION \
 && ln -s $HADOOP_HOME_VERSION $HADOOP_HOME

# SPARK
ENV SPARK_VERSION v2.0.0
ENV SPARK_HOME_VERSION /usr/spark-${SPARK_VERSION}
ENV SPARK_HOME /usr/spark
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
RUN git clone https://github.com/apache/spark.git -b $SPARK_VERSION $SPARK_HOME_VERSION \
 && cd $SPARK_HOME_VERSION \
 && ./build/mvn -Pyarn -Pnetlib-lgpl -Phadoop-$HADOOP_MAJOR_VERSION -Dhadoop.version=$HADOOP_VERSION -DskipTests clean package \
 && chown -R root:root $SPARK_HOME_VERSION \
 && ln -s $SPARK_HOME_VERSION $SPARK_HOME

WORKDIR $SPARK_HOME
CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]