Apache Spark is a unified analytics engine for large-scale data processing. It provides high-level APIs in Java, Scala, Python and R, and an optimized engine that supports general execution graphs. It also supports a rich set of higher-level tools including Spark SQL for SQL and structured data processing, MLlib for machine learning, GraphX for graph processing, and Structured Streaming for incremental computation and stream processing.

![Apache Spark Architecture](https://databricks.com/wp-content/uploads/2016/02/Spark-Stack-1024x474.png)

![](<a href="https://ibb.co/GWwdkxZ"><img src="https://i.ibb.co/dP9f6WN/IMG-1098.jpg" alt="IMG-1098" border="0"></a>)



## Apache Spark Advantages

* Spark is a general-purpose, in-memory, fault-tolerant, distributed processing engine that allows you to process data efficiently in a distributed fashion.
* Applications running on Spark are 100x faster than traditional systems.
* You will get great benefits using Spark for data ingestion pipelines.
* Using Spark we can process data from Hadoop HDFS, AWS S3, Databricks DBFS, Azure Blob Storage, and many file systems.
* Spark also is used to process real-time data using Streaming and Kafka.
* Using Spark Streaming you can also stream files from the file system and also stream from the socket.
* Spark natively has machine learning and graph libraries.

## Apache Spark Architecture

![Cluster Diagram](https://i2.wp.com/sparkbyexamples.com/wp-content/uploads/2020/02/spark-cluster-overview.png?w=596&ssl=1)

## Python and Apache Spark

The SparkSession object is the entry point to your Spark cluster. SparkSession is an entry point to PySpark and creating a SparkSession instance would be the first statement you would write to program with RDD, DataFrame, and Dataset. SparkSession will be created using SparkSession.builder builder patterns.

```sourcegraph
sparksession.builder lang:Python 
```

```sourcegraph
repo:^github\.com/spark-examples/pyspark-examples$ sparksession.builder lang:Python 
```

https://sourcegraph.com/github.com/spark-examples/pyspark-examples/-/blob/pyspark-sparksession.py?L5-15

* master() – If you are running it on the cluster you need to use your master name as an argument to master(). usually, it would be either yarn or mesos depends on your cluster setup.

* Use local[x] when running in Standalone mode. x should be an integer value and should be greater than 0; this represents how many partitions it should create when using RDD, DataFrame, and Dataset. Ideally, x value should be the number of CPU cores you have.

* appName() – Used to set your application name.

## Dataframe

A Spark DataFrame is an integrated data structure with an easy-to-use API for simplifying distributed big data processing. DataFrame is available for general-purpose programming languages such as Java, Python, and Scala.

It is an extension of the Spark RDD API optimized for writing code more efficiently while remaining powerful.

There are many ways we can create a dataframe:

* manually
* from an RDD
* from a data source

Lets explore the third option

```sourcegraph
spark.read.csv(...) lang:Python patterntype:structural 
```

```sourcegraph
spark.read.csv(...) lang:Python repo:^github\.com/spark-examples/pyspark-examples$ patterntype:structural 
```

https://sourcegraph.com/github.com/spark-examples/pyspark-examples/-/blob/pyspark-read-csv.py?L13-17
