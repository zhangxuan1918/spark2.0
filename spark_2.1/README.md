# Spark2.1 Dockerfile

1. In OpenBlas, we configure spark properly with OpenBlas installed
2. In MKL, we configure spark properly with MKL installed
3. In Atlas, we configure spark properly with atlas installed 

# Version

```bash
cython==0.25.2
numpy==1.13.0
scipy==0.19.0
java==8u131-b11
hadoop==2.8.0
spark==2.1.1
``` 

# Performance 

We did performance comparsion on a random matrix of size 1000 x 1000 with following configuration

## Configuration

|            | INFO                                    |
| ----------:|:----------------------------------------|
| cpu model name| Intel(R) Core(TM) i5-4288U CPU @ 2.60GHz|
| cpu MHz		| 2600.000|
| num cpu   | 1       |
| memory    | 2050400 KB |

### mkl (built without intel icc)

|OPERATION              |  TIME                 |
|---------------------:|:---------------------| 
|Multiplication 4096x4096 matrices | 8.41 s |
|Dotted two vectors of length 524288 | 0.60 ms |
|Cholesky decomposition 2048x2048 matrix| 0.40 s   |
|SVD 2048x1024 matrix   | 2.53 s     |
|Eigendecomposition 2048x2048 matrix | 15.30 s|

### atlas 

|OPERATION              |  TIME                 |
|---------------------:|:---------------------| 
|Multiplication 4096x4096 matrices | 16.51 s |
|Dotted two vectors of length 524288 | 0.72 ms |
|Cholesky decomposition 2048x2048 matrix| 0.65 s   |
|SVD 2048x1024 matrix   | 143.19 s     |
|Eigendecomposition 2048x2048 matrix | 317.68 s|

### openblas

|OPERATION              |  TIME                 |
|---------------------:|:---------------------| 
|Multiplication 4096x4096 matrices | 9.33 s |
|Dotted two vectors of length 524288 | 0.83 ms |
|Cholesky decomposition 2048x2048 matrix| 0.39 s   |
|SVD 2048x1024 matrix   | 2.78 s     |
|Eigendecomposition 2048x2048 matrix | 18.94 s|

# Pycharm Configuration

To use Pycharm with docker, properly setup the remote interpreter. In your pyspark script, edit the configuration and
add following ENV vars

```
PYSPARK_PYTHON	/usr/bin/python
PYSPARK_DRIVER_PYTHON	/usr/bin/python
PYTHONPATH	/usr/spark/python:/usr/spark/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
SPARK_HOME	/usr/spark
```
