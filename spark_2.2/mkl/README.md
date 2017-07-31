# Dockerfile For Spark 2.2 With MKL

The Dockerfile creates a docker image with Spark2.2.0, Hadoop 2.8.0, Python2.7 and numpy 1.13.0 

To improve Spark performance, we properly configure [MKL 11.3](https://software.intel.com/en-us/articles/intel-mkl-113-release-notes).

1. download MKL tgz file to current folder
2. decompress the tgz file e.g. `tar -xvzf l_mkl_2017.3.196.tgz`
3. in `silent.cfg`, configure
   * `ACCEPT_EULA=accept`
4. make a tar ball with the modified `silent.cfg`, e.g. `tar -cvzf l_mkl_2017.0.098.tgz l_mkl_2017.0.098`
5. put the tar ball in the same folder with the dockerfile
6. set `ENV mkl` in Dockerfile, e.g. `ENV mkl=l_mkl_2017.3.196`

