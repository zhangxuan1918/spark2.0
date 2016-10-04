# Dockerfile For Spark 2.0 With MKL

The Dockerfile creates a docker image with Spark2.0, Hadoop 2.7.2, Python2.7 and numpy 1.11.1 

To improve Spark performance, we properly [MKL](https://software.intel.com/en-us/intel-mkl/?cid=sem43700010399172316&intel_term=intel+mkl&gclid=CIuO5qzFwc8CFQpahgodJLcIbA&gclsrc=aw.ds).

1. download MKL tgz file to current folder
2. run docker build

