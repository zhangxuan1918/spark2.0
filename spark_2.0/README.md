# Spark2.0 Dockerfile

1. In OpenBlas, we configure spark properly with OpenBlas installed
2. In MKL, we configure spark properly with MKL installed
3. In Atlas, we configure spark properly with atlas installed 

# Version

```bash
cython==0.24.1
numpy==1.11.1
scipy==0.18.0
java==8u92-b14
hadoop==2.7.2
spark==2.0.0
``` 

# Pycharm Configuration

To use Pycharm with docker, properly setup the remote interpreter. In your pyspark script, edit the configuration and
add following ENV vars

```
PYSPARK_PYTHON	/usr/bin/python
PYSPARK_DRIVER_PYTHON	/usr/bin/python
PYTHONPATH	/usr/spark/python:/usr/spark/python/lib/py4j-0.10.1-src.zip:$PYTHONPATH
SPARK_HOME	/usr/spark
```
