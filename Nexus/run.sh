#!/bin/bash

docker run \
--name nexus \
--rm \
-p 8081:8081 \
--volume /Users/fbondia/Source/cicd/Docker/Nexus/data/:/nexus-data/ \
my-nexus
