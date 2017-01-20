#!/bin/bash

DOCKER_CONTAINER='gitlab-ce'
DOCKER_IMAGE='gitlab/gitlab-ce:latest'

# 80 => 50021 (system setting)
PORT_1='50021:50021'
PORT_2='50022:22'
PORT_3='50023:443'

HOST_NAME='xxx.xxx.xxx.xxx' <--- system ip

HOST_VOLUME='/data/docker/tools/gitlab-ce/volume'
mkdir -p ${HOST_VOLUME}'/etc/gitlab'
mkdir -p ${HOST_VOLUME}'/var/log/gitlab'
mkdir -p ${HOST_VOLUME}'/var/opt/gitlab'
mkdir -p ${HOST_VOLUME}'/var_opt_gitlab_backups'

VOLUME_1=${HOST_VOLUME}'/etc/gitlab:/etc/gitlab'
VOLUME_2=${HOST_VOLUME}'/var/log/gitlab:/var/log/gitlab'
VOLUME_3=${HOST_VOLUME}'/var/opt/gitlab:/var/opt/gitlab'
VOLUME_4=${HOST_VOLUME}'/var_opt_gitlab_backups:/var/opt/gitlab/backups'
VOLUME_5=${HOST_VOLUME}'/data:/data'

echo "docker run -it -d  \\"
echo "  --name ${DOCKER_CONTAINER} \\"
echo "  --hostname ${HOST_NAME} \\"
echo "   -p        ${PORT_1} \\"
echo "   -p        ${PORT_2} \\"
echo "   -p        ${PORT_3} \\"
echo "   -v        ${VOLUME_1} \\"
echo "   -v        ${VOLUME_2} \\"
echo "   -v        ${VOLUME_3} \\"
echo "   -v        ${VOLUME_4} \\"
echo "   -v        ${VOLUME_5} \\"
echo "  ${DOCKER_IMAGE}"

sleep 1

docker run -it -d  \
  --name ${DOCKER_CONTAINER} \
  --hostname ${HOST_NAME} \
   -p        ${PORT_1} \
   -p        ${PORT_2} \
   -p        ${PORT_3} \
   -v        ${VOLUME_1} \
   -v        ${VOLUME_2} \
   -v        ${VOLUME_3} \
   -v        ${VOLUME_4} \
   -v        ${VOLUME_5} \
  ${DOCKER_IMAGE}
