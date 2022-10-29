#!/bin/bash
rm /tmp/community/** -rf
rm /community/apache-tomcat-10.0.23/logs/** -rf

if [ $1 = "skip" ] ; then
    mvn clean package -D maven.test.skip=true -f /community/community
else
    mvn clean package -f /community/community
fi

rm /community/apache-tomcat-10.0.23/webapps/* -rf
mv /community/community/target/ROOT.war /community/apache-tomcat-10.0.23/webapps/

shutdown.sh
catalina.sh run
# startup.sh