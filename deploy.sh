#!/bin/bash
source .env
BRANCH=$1

if [ "$BRANCH" == "dev" ]; then
  TAG="dev"
  REPO="$DOCKER_USERNAME/dev" 
elif [ "$BRANCH" == "master" ]; then
  TAG="prod"
  REPO="$DOCKER_USERNAME/prod" 
else
  echo "wrong  branch: $BRANCH"
  exit 1
fi

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker pull $REPO:$TAG
docker rm -f guvi-container || true
docker run -d --name guvi-container -p 80:3000 $REPO:$TAG
