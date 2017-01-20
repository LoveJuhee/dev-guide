#!/bin/bash

DATE=`date +%Y%m%d_%H%M%S`
GITLAB_CONTAINER_PATH="/data/docker/tools/gitlab-ce"
LOG_FILE="${GITLAB_CONTAINER_PATH}/logs/backup_${DATE}"

DOCKER_CONTAINER='gitlab-ce'
DOCKER_IMAGE='gitlab/gitlab-ce:latest'

# BACKUP PATH
GIT_BACKUP_PATH="${GITLAB_CONTAINER_PATH}/volume/var_opt_gitlab_backups"
DATA_BACKUP_PATH="/data/gitlab-backup"

echo "########################################"
echo "#                                      #"
echo "# GITLAB BACKUP START (FOR CRONTAB)    #"
echo "#                                      #"
echo "########################################"

echo ""
echo "----------------------------------------"
echo "- PARAMETER                            -"
echo "----------------------------------------"
echo " : BASE_PATH  = ${GITLAB_CONTAINER_PATH}"
echo " : PARAM_PATH = ${PARAM_PATH}"
echo " : GIT_PATH   = ${GIT_BACKUP_PATH}"
echo " : DATA_PATH  = ${DATA_BACKUP_PATH}"
echo " : CONTAINER  = ${DOCKER_CONTAINER}"
echo ""

sleep 1

echo ""
echo "----------------------------------------"
echo "- GIT BACKUP                           -"
echo "----------------------------------------"
echo ""

echo "docker exec -i ${DOCKER_CONTAINER} gitlab-rake gitlab:backup:create"
docker exec -i ${DOCKER_CONTAINER} gitlab-rake gitlab:backup:create
date

echo ""
echo "----------------------------------------"
echo "- MV BACKUP FILE                       -"
echo "----------------------------------------"
echo ""

echo "find ${GIT_BACKUP_PATH} -name '*gitlab_backup.tar' -mtime -1 -print -exec mv {} ${DATA_BACKUP_PATH} \;"
find ${GIT_BACKUP_PATH} -name "*gitlab_backup.tar" -mtime -1 -print -exec mv {} ${DATA_BACKUP_PATH} \;
date

echo ""
echo "########################################"
echo "#                                      #"
echo "# GITLAB BACKUP DONE                   #"
echo "#                                      #"
echo "########################################"
echo ""
echo ""
echo ""
