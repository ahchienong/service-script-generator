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

if [[ ("$#" -ne "1") && ("$#" -ne "2") ]]; then
        echo "----------------------------------------------"
        echo "usage: $0 update-latest-jar"
        echo "usage: $0 update-jar <artifacts-name.jar>"
        echo "##############################################"
        exit 2
else

case $1 in
       update-jar)
        if [ "$#" -eq "1" ]; then
                echo "----------------------------------------------"
                echo "insufficient info for this option"
                echo "usage: $0 update-jar <artifacts-name.jar>"
                echo "##############################################"
                exit 2
        fi
        NEW_JAR=$2
        if [ -f ${current_dir}/${service_script} ]; then
                echo "updating $service_script ..."
                echo "latest_jar => $NEW_JAR"
                cmd=`sed -i "0,/latest_jar/s/.*latest_jar.*/latest_jar=\"${NEW_JAR}\"/" $service_script`
                echo $cmd
                $cmd
        else
            echo "----------------------------------------------"
            echo "$service_name script not found - $service_script"
            echo "check in path $current_dir for $service_script"
            echo "##############################################"
            exit 2
        fi
        ;;
       update-latest-jar)
        if [ -f ${current_dir}/${service_script} ] && [ -f ${current_dir}/latest_jar.list ]; then
                echo "obtained latest_jar from file latest_jar.list"
                NEW_JAR=$(cat latest_jar.list)
                echo "updating $service_script ..."
                echo "latest_jar => $NEW_JAR"
                cmd=`sed -i "0,/latest_jar/s/.*latest_jar.*/latest_jar=\"${NEW_JAR}\"/" $service_script`
                echo $cmd
                $cmd
        else                
                echo "----------------------------------------------"
                echo "$service_name $service_script or latest_jar.list not found"
                echo "try execute ./download-packages.sh to obtain latest_jar first"
                echo "##############################################"
                exit 2
        fi
        ;;
esac

fi
