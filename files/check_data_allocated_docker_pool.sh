#!/bin/bash

WARNING_VALUE=70
CRITICAL_VALUE=80

while getopts 'd:w:c:' OPTION
do
  case $OPTION in
  w)    WARNING_VALUE="$OPTARG"
        ;;
  c)    CRITICAL_VALUE="$OPTARG"
        ;;
  d)    vflag=1
        LVDISK="$OPTARG"
        ;;
  ?)    echo Argument invalid
        exit 3
        ;;
  esac
done

if [ -z "${LVDISK}" ];
then
  echo "which docker pool do you want to check today?"
  exit 3
fi

POOLDATA=$(lvdisplay ${LVDISK} | grep "Allocated pool data" | awk '{ print $NF }' | cut -f 1 -d% | cut -f1 -d.)
POOLDATARAW=$(lvdisplay ${LVDISK} | grep "Allocated pool data" | awk '{ print $NF }')

STATUS="Allocated pool data ${POOLDATARAW} | percent=${POOLDATA};"

if [ -z "$POOLDATA" ];
then
	echo "UNKNOWN"
	exit 3;
elif [ "$POOLDATA" -ge "$CRITICAL_VALUE" ];
then
	echo CRITICAL - $STATUS
	exit 2
elif [ "$POOLDATA" -ge "$WARNING_VALUE" ];
then
	echo WARNING - $STATUS
	exit 1
else
	echo OK - $STATUS
	exit 0
fi
