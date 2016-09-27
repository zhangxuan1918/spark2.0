# Dockerfile For Spark 2.0, Python2.7

The Dockerfile creates a docker image with Spark2.0 (Hadoop 2.7.2) and Python2.7. To boost the machine learning
algorithms in ML spark, [OpenBlas](#https://github.com/xianyi/OpenBLAS) is installed and Spark is built from source
using netlib (with `-Pnetlib-lgpl`). 

# Pycharm Configuration

To use Pycharm with docker, properly setup the remote interpreter. In your pyspark script, edit the configuration and
add following ENV vars

```
PYSPARK_PYTHON	/usr/bin/python
PYSPARK_DRIVER_PYTHON	/usr/bin/python
PYTHONPATH	/usr/spark/python:/usr/spark/python/lib/py4j-0.10.1-src.zip:$PYTHONPATH
SPARK_HOME	/usr/spark
```