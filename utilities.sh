#!/bin/sh
# chkconfig: 345 25 75
# description: Utilities to update jar
### BEGIN INIT INFO
### END INIT INFO


###################
# CUSTOMIZE START #
###################
service_name="YOURSERVICENAME"
current_dir="PATHTOJAR"
service_script=${service_name}_service.sh

echo "##############################################"
echo "Script Name: $0 | $# arguments"

if [ "$#" -ne "2" ]; then
        echo "----------------------------------------------"
        echo "usage: $0 update-jar <artifacts-name.jar>"
        echo "##############################################"
        exit 2
else

case $1 in
       update-jar)
        NEW_JAR=$2
        if [ -f ${current_dir}/${service_script} ]; then
                echo "updating $service_script ... latest_jar=$NEW_JAR"
                echo "latest_jar => $NEW_JAR"
                cmd=`sed -i "0,/latest_jar/s/.*latest_jar.*/latest_jar=\"${NEW_JAR}\"/" $service_script`
                echo $cmd
                $cmd
        else
            echo "$service_name script not found - $service_script"
        fi
        ;;
esac

fi
