!/bin/sh
# chkconfig: 345 25 75
# description: To run YOURSERVICENAME service
### BEGIN INIT INFO
### END INIT INFO

#nohup java -jar -Xmx256m -Xms128m -Dspring.profiles.active=dev -Dserver.port=SERVICEPORT /PATHTOJAR/JARFILE.jar > /dev/null &

###################
# CUSTOMIZE START #
###################
service_name="YOURSERVICENAME"
service_pid=${service_name}-pid
current_dir="PATHTOJAR"
service_port="-Dserver.port=SERVICEPORT"
service_spring_profile="-Dspring.profiles.active=dev"
latest_jar="JARFILE.jar"
###################
# CUSTOMIZE END   #
###################
jar_vars="-Xmx256m -Xms128m"
standard_jar_cmd_end="> /dev/null &"

echo "##############################################"
echo "Script Name: $0 | $# arguments"

if [ "$#" -ne "1" ]; then
        echo "----------------------------------------------"
        echo "usage: $0 (status|start|logs|stop|restart)"
        echo "##############################################"
        exit 2
else

        case $1 in
                status)
                if [ -f ${current_dir}/${service_pid} ]; then
                    PID=$(cat ${current_dir}/${service_pid});
                    if ps aux | grep $PID | grep ${service_name} >/dev/null; then
                        echo "$service_name service started (PID: $PID )"
                    else
                        echo "$service_name service not started"
                    fi
                else
                    echo "$service_name service not started"
                fi
                ;;
            start)
                echo "Starting $service_name service..."
                if [ ! -f ${current_dir}/${service_pid} ]; then
                    nohup java -jar ${jar_vars} ${service_spring_profile} ${service_port} ${current_dir}/${latest_jar} > /dev/null &
                    echo $! > ${current_dir}/${service_pid}
                    echo "$service_name service started"
                else
                    echo "$service_name service already running"
                fi
            ;;
            logs)
                if [ -f ${current_dir}/${service_pid} ]; then
                    PID=$(cat ${current_dir}/${service_pid});
                    if ps aux | grep $PID | grep ${service_name} >/dev/null; then
                        tail -200f ${current_dir}/logs/${service_name}-service.log
                    else
                        echo "$service_name service not started"
                    fi
                else
                    echo "$service_name service not started"
                fi
            ;;
            stop)
                if [ -f ${current_dir}/${service_pid} ]; then
                    PID=$(cat ${current_dir}/${service_pid});
                    echo "Stopping $service_name service..."
                    kill $PID;
                    echo "$service_pid service stopped"
                    rm ${current_dir}/${service_pid}
                else
                    echo "$service_name service is not running"
                fi
            ;;
            restart)
                if [ -f ${current_dir}/${service_pid} ]; then
                    PID=$(cat ${current_dir}/${service_pid});
                    echo "Stopping $service_name service...";
                    kill $PID;
                    echo "$service_name service stopped";
                    rm ${current_dir}/${service_pid}

                    echo "Starting $service_name service..."
                    nohup java -jar ${jar_vars} ${service_spring_profile} ${service_port} ${current_dir}/${latest_jar} > /dev/null &
                    echo $! > ${current_dir}/${service_pid}
                    echo "$service_name service started"
                else
                    echo "$service_name service is not running"
                fi
            ;;
        esac
exit 0
fi
