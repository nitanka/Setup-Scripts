#!/bin/bash

HADOOP_DATA=


echo "############# Updating the system ################"
apt-get update 


# Checking the kernel version
KERNEL=`uname -r | cut -d "-" -f 1`

# if 0, Donot reboot the server else restart
REBOOT=0 



echo "############# Installing Java ################"

apt-add-repository ppa:webupd8team/java -y
apt-get update -y

####automatically agreeing on oracle license agreement that normally pops up while installing java8
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections

####installing java
apt-get install -y oracle-java8-installer


echo "############ Download HADOOP ###############"

mkdir -p /opt/packagesTar
mkdir -p /opt/hadoop

cd /opt/packagesTar/ && curl -O http://redrockdigimark.com/apachemirror/hadoop/common/hadoop-2.7.3/hadoop-2.7.3.tar.gz 

tar -xzf hadoop-2.7.3.tar.gz -C /opt/hadoop --strip-components=1 

echo '#!/bin/bash 
      export JAVA_HOME=/usr/lib/jvm/java-8-oracle
      export PATH=$PATH:$JAVA_HOME/bin
      export HADOOP_HOME=/opt/hadoop
      export PATH=$PATH:$HADOOP_HOME/bin
      export PATH=$PATH:$HADOOP_HOME/sbin
      export HADOOP_MAPRED_HOME=$HADOOP_HOME
      export HADOOP_COMMON_HOME=$HADOOP_HOME
      export HADOOP_HDFS_HOME=$HADOOP_HOME
      export YARN_HOME=$HADOOP_HOME
      export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
      export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/native"
      export CLASSPATH=$CLASSPATH:/opt/hadoop/lib
      export HADOOP_OPTS="$HADOOP_OPTS -Djava.security.egd=file:/opt/hadoop/temp/tmp"' >> /etc/profile.d/hadoop.sh


mkdir -p $HADOOP_DATA
mkdir -p $HADOOP_DATA/tmp
