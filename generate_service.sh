#!/bin/bash

echo "##############################################"
echo "Script Name: $0 | $# arguments"

if [ "$#" -eq "4" ]; then
        YOURSERVICENAME=$1
        SERVICEPORT=$2
        PATHTOJAR=$3
        JARFILE=$4

        echo "##############################################"
        echo "#1 - YOURSERVICENAME    : $YOURSERVICENAME"
        echo "#2 - SERVICEPORT        : $SERVICEPORT"
        echo "#3 - PATHTOJAR          : $PATHTOJAR"
        echo "#4 - JARFILE            : $JARFILE"
        echo "##############################################"

        read -p "OK to proceed? (y,n) [y]" agree
        agree=${agree:-y}
        echo "Selected: $agree"

        if [ "$agree" =  "y" ]; then
                echo "##############################################"
                echo "(1/5) Proceed with create service script file."
                cp -v ./template.sh $PATHTOJAR/$YOURSERVICENAME.sh
                echo "(2/5) Proceed with replacing YOURSERVICENAME with $YOURSERVICENAME"
                sed -i -e 's/YOURSERVICENAME/'$YOURSERVICENAME'/g' $PATHTOJAR/$YOURSERVICENAME.sh
                echo "(3/5) Proceed with replacing SERVICEPORT with $SERVICEPORT"
                sed -i -e 's/SERVICEPORT/'$SERVICEPORT'/g' $PATHTOJAR/$YOURSERVICENAME.sh
                echo "(4/5) Proceed with replacing PATHTOJAR with $PATHTOJAR"
                sed -i -e 's/PATHTOJAR/'$PATHTOJAR'/g' $PATHTOJAR/$YOURSERVICENAME.sh
                echo "(5/5) Proceed with replacing JARFILE with $JARFILE"
                sed -i -e 's/JARFILE/'$JARFILE'/g' $PATHTOJAR/$YOURSERVICENAME.sh

								echo "[Done] configuration file : ./$YOURSERVICENAME.sh"
								echo "Generated file located in $PATHTOJAR/$YOURSERVICENAME.sh"
        else
                echo "[Abort] Not Proceed with creating service script file : $PATHTOJAR/$YOURSERVICENAME.sh"
        fi

else
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        echo "Incorrect number of arguments. (4) "
        echo "Expecting 4 : YOURSERVICENAME SERVICEPORT PATHTOJAR JARFILE"
        echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        exit 2
fi
