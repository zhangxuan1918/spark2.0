# Spark2.2 Dockerfile

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
spark==2.2.0
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
|Multiplication 4096x4096 matrices | 7.69 s |
|Dotted two vectors of length 524288 | 0.64 ms |
|Cholesky decomposition 2048x2048 matrix| 0.41 s   |
|SVD 2048x1024 matrix   | 2.56 s     |
|Eigendecomposition 2048x2048 matrix | 14.96 s|

### atlas 

|OPERATION              |  TIME                 |
|---------------------:|:---------------------| 
|Multiplication 4096x4096 matrices | 13.86 s |
|Dotted two vectors of length 524288 | 0.58 ms |
|Cholesky decomposition 2048x2048 matrix| 0.53 s   |
|SVD 2048x1024 matrix   | 137.06 s     |
|Eigendecomposition 2048x2048 matrix | 288.53 s|

### openblas

|OPERATION              |  TIME                 |
|---------------------:|:---------------------| 
|Multiplication 4096x4096 matrices | 5.77 s |
|Dotted two vectors of length 524288 | 1.03 ms |
|Cholesky decomposition 2048x2048 matrix| 0.30 s   |
|SVD 2048x1024 matrix   | 2.17 s     |
|Eigendecomposition 2048x2048 matrix | 13.27 s|

# Pycharm Configuration

To use Pycharm with docker, properly setup the remote interpreter. In your pyspark script, edit the configuration and
add following ENV vars

```
PYSPARK_PYTHON	/usr/bin/python
PYSPARK_DRIVER_PYTHON	/usr/bin/python
PYTHONPATH	/usr/spark/python:/usr/spark/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
SPARK_HOME	/usr/spark
```
