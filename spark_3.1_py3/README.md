# Spark3.1 Dockerfile

# Version

```bash
openjdk-8-jre
hadoop==3.0.0
spark==3.1.1
python==3.9
```

# Pycharm Configuration

To use Pycharm with docker, properly setup the remote interpreter. In your pyspark script, edit the configuration and
add following ENV vars

```
PYSPARK_PYTHON	/usr/bin/python
PYSPARK_DRIVER_PYTHON	/usr/bin/python
PYTHONPATH	/usr/spark/python:/usr/spark/python/lib/py4j-0.10.9-src.zip:$PYTHONPATH
SPARK_HOME	/usr/spark
```
