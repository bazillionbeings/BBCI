#!/bin/bash
set -e

FOLDER_NAME=$1
IMAGE_NAME=$2
ADDRESS=$3

if [ "$FOLDER_NAME" = "" ]; then
  echo "Please provide directory name as a first argument"
  exit 1
fi

if [ "$IMAGE_NAME" = "" ]; then
  echo "Please provide image name as a second argument"
  exit 1
fi

if [ "$ADDRESS" = "" ]; then
  echo "Please provide git address as a third argument"
  exit 1
fi
DOCKER_CODES_DIR="$HOME/docker-codes"

if [ ! -d "$DOCKER_CODES_DIR" ]; then
  echo -e "\ndocker-codes directory doesn't exist creating"
  mkdir $DOCKER_CODES_DIR
fi

cd $DOCKER_CODES_DIR

if [ -d "$FOLDER_NAME" ]; then
  cd $FOLDER_NAME
  git pull origin master
else
  echo -e "\nClonning git"
  git clone $ADDRESS
fi

echo -e "\nRemoving old docker image"
docker rmi $IMAGE_NAME || true
echo -e "\nBuilding new docker image"
docker build -t $IMAGE_NAME .
#docker images

CONTAINER_NAME="$FOLDER_NAME-container"
echo -e "\nRemoving old container"
docker rm -f $CONTAINER_NAME || true
echo -e "\nCreating new Container"
echo "docker run --name=$CONTAINER_NAME $IMAGE_NAME"
docker run --name=$CONTAINER_NAME $IMAGE_NAME