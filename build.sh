#!/bin/bash

if [ "$1" = "master" ];then
	ln -s Dockerfile.stable Dockerfile
	docker buildx build -t nayr/direwolf:stable --platform=linux/arm,linux/arm64,linux/amd64 . --push
	rm Dockerfile
elif [ "$1" = "dev" ];then
	ln -s Dockerfile.dev Dockerfile
	docker buildx build -t nayr/direwolf:latest --platform=linux/arm,linux/arm64,linux/amd64 . --push
	rm Dockerfile
else
	echo "specify one: master/dev"
fi
