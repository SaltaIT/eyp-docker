#!/bin/bash

if [ -z "$1" ];
then
  SELECTED_CONTAINER=$(basename $0)
else
  SELECTED_CONTAINER=$1
fi

exec docker exec -it ${SELECTED_CONTAINER} bash
