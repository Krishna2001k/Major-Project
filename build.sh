#!/bin/bash
source .env

if [ -z "$1" ]; then
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
else
  BRANCH=$1
fi

IMAGE_NAME="major"
if [ "$BRANCH" == "dev" ]; then
  TAG="dev"
  REPO="$DOCKER_USERNAME/dev" 
elif [ "$BRANCH" == "master" ]; then
  TAG="prod"
  REPO="$DOCKER_USERNAME/prod" 
else
  echo " Unknown branch: $BRANCH"
  exit 1
fi

echo " Building Docker image: $REPO:$TAG"
docker build -t $REPO:$TAG .

echo " Logging into Docker Hub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

echo " Pushing image to Docker Hub: $REPO:$TAG"
docker push $REPO:$TAG
