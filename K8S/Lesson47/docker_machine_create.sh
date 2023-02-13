#! /bin/bash

docker-machine create \
	--driver amazonec2 \
	--amazonec2-region eu-west-2 \
	--amazonec2-ami ami-0f9124f7452cdb2a6  \
	--amazonec2-instance-type t2.medium \
	--amazonec2-open-port 80 \
	--amazonec2-open-port 8080 \
	--amazonec2-open-port 6443 \
tms-docker-machine
