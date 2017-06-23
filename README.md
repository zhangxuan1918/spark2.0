# Spark Dockerfile

1. In OpenBlas, we configure spark properly with OpenBlas installed
2. In MKL, we configure spark properly with MKL installed
3. In Atlas, we configure spark properly with atlas installed 

# Performance 

We did performance comparsion on a random matrix of size 1000 x 1000 with following configuration

## Configuration

|            | INFO                                    |
| ----------:|:----------------------------------------|
| cpu model name| Intel(R) Core(TM) i5-4288U CPU @ 2.60GHz|
| cpu MHz		| 2600.000|
| num cpu   | 1       |
| memory    | 2050400 KB |

### mkl 

|OPERATION              |  TIME                 |
|---------------------:|:---------------------| 
|matrix multiplication  | 24.07747793197632 sec |
|cholesky               | 0.0527433872223 sec   |
|svd                    | 1.51327500343 sec     |

### atlas 

|OPERATION              |  TIME                 |
|---------------------:|:---------------------| 
|matrix multiplication  | 87.5759379863739 sec  |
|cholesky               | 0.206461620331 sec    |
|svd                    | 17.2115719795 sec     |

### openblas

|OPERATION              |  TIME                 |
|---------------------:|:---------------------| 
|matrix multiplication  | 24.00079584121704 sec |
|cholesky               | 0.119298410416 sec    |
|svd                    | 3.18814339638 sec     |

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
