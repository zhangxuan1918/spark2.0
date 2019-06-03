# Spark2.4 Dockerfile

1. In OpenBlas, we configure spark properly with OpenBlas installed
2. In MKL, we configure spark properly with MKL installed
3. In Atlas, we configure spark properly with atlas installed 

# Version

```bash
cython==0.29.9
numpy==1.16.4
scipy==1.2.1
java==8u131-b11
hadoop==2.8.5
spark==2.4.3
``` 

# Pycharm Configuration

To use Pycharm with docker, properly setup the remote interpreter. In your pyspark script, edit the configuration and
add following ENV vars

```
PYSPARK_PYTHON	/usr/bin/python
PYSPARK_DRIVER_PYTHON	/usr/bin/python
PYTHONPATH	/usr/spark/python:/usr/spark/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
SPARK_HOME	/usr/spark
```
