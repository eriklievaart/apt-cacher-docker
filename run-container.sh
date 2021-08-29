#!/bin/dash
set -e

docker build -f dockerfile -t apt-cacher .
echo
docker network list

if [ -z "$(docker network list | awk '/shared/{print $2}')" ]; then
	docker network create shared
fi

args='--rm -d'
if [ "$1" != '' ]; then
	args="$1"
fi

echo
docker ps
echo

if docker ps | grep -q apt-cache; then
    echo "docker: apt-cacher already running"
else
    echo "docker: starting apt-cacher"
    docker run $args --name 'apt-cache' --network=shared -v ~/.cache/apt-cacher:/var/cache/apt-cacher apt-cacher
fi


