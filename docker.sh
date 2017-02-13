#!/usr/bin/env bash

function docker-build() {
    if [ -n "$1" ]; then
        echo "build $1"
        version=$1
    else
        echo "build latest"
        version="latest"
    fi
    docker build -t hub.c.163.com/bingohuang/12factor-app:$version .
}

function docker-push() {
    if [ -n "$1" ]; then
        echo "push $1"
        version=$1
    else
        echo "push latest"
        version="latest"
    fi
    docker push hub.c.163.com/bingohuang/12factor-app:$version
}

function docker-mongo() {
    docker run -d \
    --publish=27017:27017 \
    --name=mongo \
    hub.c.163.com/library/mongo:3.2
}

function docker-run() {
    if [ -n "$1" ]; then
        echo "run $1"
        version=$1
    else
        echo "run latest"
        version="latest"
    fi
    docker run -d \
    --publish=1377:1377 \
    -e MONGO_URL=mongodb://mongo/12factor-app \
    --link=mongo \
    --name=12factor-app \
    hub.c.163.com/bingohuang/12factor-app:$version
}

function help() {
    echo "$0 build|push|run|mongo"
}

if [ "$1" == "" ]; then
    help
elif [ "$1" == "build" ];then
    docker-build $2
elif [ "$1" == "push" ];then
    docker-push $2
elif [ "$1" == "run" ];then
    docker-run $2
elif [ "$1" == "mongo" ];then
    docker-mongo $2
else
    help
fi
