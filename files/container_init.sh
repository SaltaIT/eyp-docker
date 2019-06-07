#!/bin/bash

if [ ! -e "/usr/bin/which" ];
then
  echo "which not found, please install it"
  exit 3
fi

DOCKERBIN="$(which docker)"
if [ -z "${DOCKERBIN}" ];
then
  echo "docker not found"
  exit 3
fi

CONTAINER_ID=$(echo "$0" | cut -f2 -d_)

if [ -z "${CONTAINER_ID}" ];
then
  echo "usage: this check must be called: dockercontainer_<CONTAINERID>"
  exit 3
fi

docker inspect $CONTAINER_ID >/dev/null 2>&1

if [ "$?" -ne 0 ];
then
  echo "container ${CONTAINER_ID} does not exists"
  exit 2
fi

docker ps | grep "${CONTAINER_ID}" >/dev/null 2>&1

if [ "$?" -eq 0 ];
then
  echo "container ${CONTAINER_ID} is running"
  exit 0
else
  echo "container ${CONTAINER_ID} is NOT running"
  exit 2
fi
