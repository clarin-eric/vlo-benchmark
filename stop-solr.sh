#!/bin/sh
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export CATALINA_HOME=${DIR}/tomcat

${CATALINA_HOME}/bin/shutdown.sh
