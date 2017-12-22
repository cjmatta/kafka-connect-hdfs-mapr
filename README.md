#### Kafka Connect HDFS on MapR

### test environment
Downloaded the MapR Sandbox v5.2.1 and ran it on Virtualbox, made sure to add a second network interface running in Host-only network mode. I needed to create a host-only network.

Log into vbox host (root/mapr) to get IP of VirtualBox and set `mapr` as an alias to `localhost` in `/etc/hosts`

Set JAVA_HOME:
```
$ export JAVA_HOME=$(/usr/libexec/java_home)
```

Install MapR Client from http://package.mapr.com/releases/

Configure MapR Client:
```
$ sudo /opt/mapr/server/configure.sh -N my.cluster.com -c -C mapr:7222 -HS mapr
```

Test that you have Hadoop connectivity:
```
$ /opt/mapr/bin/hadoop fs -ls /
17/12/21 17:05:51 WARN util.NativeCodeLoader: Unable to load native-hadoop library for your platform... using builtin-java classes where applicable
Found 9 items
drwxr-xr-x   - 2000 2000           2 2017-05-08 17:32 /apps
drwxr-xr-x   - root wheel          0 2017-09-01 14:54 /chris
drwxr-xr-x   - 2000 2000           0 2017-05-08 17:17 /hbase
drwxrwxrwx   - 2000 2000           2 2017-05-08 17:32 /oozie
drwxr-xr-x   - 2000 2000           0 2017-05-08 17:19 /opt
drwxr-xr-x   - root wheel          0 2017-05-08 17:27 /tables
drwxrwxrwx   - 2000 2000           0 2017-05-08 17:16 /tmp
drwxr-xr-x   - 2000 2000           7 2017-05-08 17:32 /user
drwxr-xr-x   - 2000 2000           1 2017-05-08 17:17 /var
```

Produce data - this is set to use the internal sales cluster, you may need to edit this:
```
$ SCHEMA_REGISTRY=<set sr url> bash publish-records.sh
```

Consume data to see that it's there:
```
$ SCHEMA_REGISTRY=<set sr url> bash consume-records.sh
{"f1":"value3"}
{"f1":"value1"}
{"f1":"value2"}
{"f1":"value3"}
{"f1":"value1"}
{"f1":"value2"}
^CProcessed a total of 6 messages
```

Set MAPR_HOME before starting `connect-distributed`:
```
MAPR_HOME=/opt/mapr connect-distributed -daemon ~/Documents/local-connect/connect-distributed.properties
```
