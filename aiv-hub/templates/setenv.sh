#!/bin/sh

#export CATALINA_OPTS="$CATALINA_OPTS -Xms1g -Xmx4g"
export JAVA_OPTS="$JAVA_OPTS -Xms1g -Xmx1g -Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom"