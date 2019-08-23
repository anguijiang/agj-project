#!/usr/bin/bash

ref=reference

mkdir -vp config

for old in `ls $ref`; do
    cp -rvn $ref/$old config
done

cp -rvn $ref/docker-compose.yml ./

docker-compose up -d