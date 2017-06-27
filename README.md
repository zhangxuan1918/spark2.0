# Spark Dockerfile

1. In OpenBlas, we configure spark properly with OpenBlas installed
2. In MKL, we configure spark properly with MKL installed
3. In Atlas, we configure spark properly with atlas installed 

# Pycharm Configuration For Spark2.1

To use Pycharm with docker, properly setup the remote interpreter. In your pyspark script, edit the configuration and
add following ENV vars

```
PYSPARK_PYTHON	/usr/bin/python
PYSPARK_DRIVER_PYTHON	/usr/bin/python
PYTHONPATH	/usr/spark/python:/usr/spark/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
SPARK_HOME	/usr/spark
```

# Pycharm Configuration For Spark2.0

To use Pycharm with docker, properly setup the remote interpreter. In your pyspark script, edit the configuration and
add following ENV vars

```
PYSPARK_PYTHON	/usr/bin/python
PYSPARK_DRIVER_PYTHON	/usr/bin/python
PYTHONPATH	/usr/spark/python:/usr/spark/python/lib/py4j-0.10.1-src.zip:$PYTHONPATH
SPARK_HOME	/usr/spark
```
