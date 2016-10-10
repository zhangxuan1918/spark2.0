FROM centos:7

# Modified from https://github.com/gettyimages/docker-spark/blob/master/Dockerfile
#USER root

# Install packages
RUN yum -y install epel-release wget git vim
RUN yum -y install blas-devel lapack-devel atlas-devel
RUN yum -y install gcc-gfortran libmpc-devel gcc gcc-c++
RUN yum -y install cmake make
RUN yum -y install python-devel python-setuptools python-pip

# Install Cython
RUN pip install Cython==0.24.1

# Install MKL
RUN mkdir -p /opt/src/
ENV mkl=l_mkl_2017.0.098
ADD ./$mkl.tgz /opt/src/
RUN cd /opt/src/ \
 && cd $mkl \
 && ./install.sh --silent=silent.cfg

# Update the library system:
RUN echo /opt/intel/compilers_and_libraries/linux/mkl/lib/intel64 >> /etc/ld.so.conf.d/intel.conf
RUN echo /opt/intel/compilers_and_libraries/linux/lib/intel64_lin >> /etc/ld.so.conf.d/intel.conf
RUN ldconfig
ENV LD_LIBRARY_PATH=/opt/intel/compilers_and_libraries/linux/mkl/lib/intel64/:/opt/intel/compilers_and_libraries/linux/lib/intel64:$LD_LIBRARY_PATH

RUN ln -sf /opt/intel/compilers_and_libraries/linux/mkl/lib/intel64/libmkl_rt.so /lib64/libblas.so.3 \
 && ln -sf /opt/intel/compilers_and_libraries/linux/mkl/lib/intel64/libmkl_rt.so /lib64/libblas.so \
 && ln -sf /opt/intel/compilers_and_libraries/linux/mkl/lib/intel64/libmkl_rt.so /lib64/liblapack.so.3 \
 && ln -sf /opt/intel/compilers_and_libraries/linux/mkl/lib/intel64/libmkl_rt.so /lib64/liblapack.so

# Install numpy
RUN cd /opt/src \
 && git clone  -b v1.11.1 https://github.com/numpy/numpy.git \
 && cd /opt/src/numpy \
 && touch site.cfg

RUN echo [mkl]  >>                                                                      /opt/src/numpy/site.cfg \
 && echo library_dirs = /opt/intel/compilers_and_libraries/linux/mkl/lib/intel64 >>    /opt/src/numpy/site.cfg \
 && echo include_dirs = /opt/intel/compilers_and_libraries/linux/mkl/include >>        /opt/src/numpy/site.cfg \
 && echo mkl_libs = mkl_rt >>                                                          /opt/src/numpy/site.cfg \
 && echo lapack_libs = >>                                                              /opt/src/numpy/site.cfg

RUN cd /opt/src/numpy \
 && python setup.py build --fcompiler=gnu95 \
 && python setup.py install

# Install Scipy
ENV LDFLAGS="${LDFLAGS} -shared"
RUN cd /opt/src \
 && git clone -b v0.18.0 https://github.com/scipy/scipy.git \
 && cd /opt/src/scipy \
 && python setup.py build --fcompiler=gnu95 \
 && python setup.py install


RUN rm -rf /opt/src/
# Install requirements
#ADD ./requirements.txt /
#RUN pip install -r requirements.txt

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
ENV HADOOP_OPTS=-Djava.library.path=$HADOOP_HOME/lib/native
ENV LD_LIBRARY_PATH=$HADOOP_HOME/lib/native/::$LD_LIBRARY_PATH
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
 && ln -s $SPARK_HOME_VERSION $SPARK_HOME \
 && cd $SPARK_HOME

WORKDIR $SPARK_HOME
CMD ["bin/spark-class", "org.apache.spark.deploy.master.Master"]
