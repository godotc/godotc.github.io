#!/bin/bash
arg=$1
arg2=$2
echo $arg $arg2
if [ -z $arg ] ; then
    echo "command {startup|test|stop}"
else 
    if [ $arg = "startup" ] ; then
        echo "Initializing services..."
        mysqld --user=root 1>/tmp/mysqllog 2>&1 &
        redis-server
        /community/kafka_2.13-3.2.1/bin/zookeeper-server-start.sh -daemon /community/kafka_2.13-3.2.1/config/zookeeper.properties
        nohup /community/kafka_2.13-3.2.1/bin/kafka-server-start.sh  /community/kafka_2.13-3.2.1/config/server.properties 1>/dev/null 2>&1 &
        su rookie
            /community/startElasticSearch.sh
        source /etc/profile
        nginx
        startup.sh
    elif [ $arg = "stop" ]; then
        echo "stop frames..."
        /community/kafka_2.13-3.2.1/bin/kafka-server-stop.sh
        /community/kafka_2.13-3.2.1/bin/zookeeper-server-stop.sh 
    elif [ $arg = "test" ]; then
        echo "testing..."
        if [ -z $arg2 ]; then
            echo "command test {framename}"
        elif [ $arg2 = "kafka" ]; then
            /community/kafka_2.13-3.2.1/bin/kafka-topics.sh --list --bootstrap-server localhost:9002
        elif [ $arg2 = "elasticsearch" ] ; then
           curl -X GET localhost:9200/_cat/health?v
        fi
    fi
fi