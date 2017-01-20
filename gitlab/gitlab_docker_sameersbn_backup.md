## docker sameersbn/gitlab 관리

-----

상세 정보
https://github.com/sameersbn/docker-gitlab

-----

### 개요

#### 백업
- 백업 처리 컨테이너를 생성하여 백업을 하도록 처리한다.

#### 업그레이드
- 백업을 처리한 후 새로 컨테이너를 생성하면 백업데이터를 읽고 마이그레이션을 처리하여 업그레이드 한다.

#### 주의사항
- 8.x 버전에서는 DB_ETENSION=pg_trgm 설정을 해야하며 db에 설정을 추가해야 한다.
- 업그레이드 시 DB_ETENSION=pg_trgm 오류가 발생할 경우, psql 접속하여 db에 해당 권한을 줘야 한다.

#### sameersbn/gitlab docker 문제점
- PostgreSQL, Redis docker 를 별도로 구축하여 관리의 불편함이 있다.
- 업그레이드 시 원활히 되지 않는 문제가 있다.
- gitlab/gitlab-ce docker 이미지와 버전이 다른 경우 처리 로직이 복잡하다
  1. `7.14.3` 에서 `8.9.6` 버전 업그레이드 시
  1. sameersbn/gitlab 동일 버전 백업 (sameersbn/gitlab:7.14.3)
  2. sameersbn/gitlab 업그레이드 버전 적용 (sameersbn/gitlab:8.9.6)
  3. sameersbn/gitlab 업그레이드 버전 백업
  4. gitlab/gitlab-ce 업그레이드 버전 적용 (gitlab/gitlab-ce:8.9.6-ce.0)

-----

### 백업
 - `sameersbn/gitlab:7.14.3` 기반 설명
  - `--rm` : 컨테이너 종료 시 컨테이너 삭제

```bash
docker run --name gitlab-7.14.3-backup --rm \
           -p 50091:80 -p 50092:22 -p 50093:20 -p 50094:21 \
\
           --env 'GITLAB_HOST='${HOST_IP} --env 'GITLAB_PORT=50091' --env 'GITLAB_SSH_PORT=50092' \
           --env 'GITLAB_ROOT_PASSWORD='${ROOT_PASSWORD} \
\
           --env 'DB_TYPE=postgres' --env 'DB_HOST='${DB_IP} --env 'DB_PORT='${DB_PORT} \
           --env 'DB_NAME=gitlabhq_production' --env 'DB_USER='${DB_USER} --env 'DB_PASS='${DB_PASSWORD} \
\
           --env 'REDIS_HOST='${REDIS_IP} --env 'REDIS_PORT='${REDIS_PORT} \
\
           --env 'SMTP_USER='${SMTP_EMAIL} --env 'SMTP_PASS='${SMTP_EMAIL_PASSWORD} \
\
           --volume /data/docker/tools/gitlab-sameersbn/volume/data:/home/git/data \
           --volume /data/docker/tools/gitlab-sameersbn/volume/dump:/dump \
           sameersbn/gitlab:7.14.3 app:rake gitlab:backup:create
```

-----

### 업그레이드
- `sameersbn/gitlab:latest` 기반 설명
- 백업이 된 자료가 있다는 전제하에 진행한다.
  - `-it` : ctrl + p, q 입력 시 컨테이너 빠져 나오기

```bash
docker run --name gitlab-8.9.6 -it \
           -p 50091:80 -p 50092:22 -p 50093:20 -p 50094:21 \
\
           --env 'GITLAB_HOST='${HOST_IP} --env 'GITLAB_PORT=50091' --env 'GITLAB_SSH_PORT=50092' \
           --env 'GITLAB_ROOT_PASSWORD='${ROOT_PASSWORD} \
\
           --env 'DB_TYPE=postgres' --env 'DB_HOST='${DB_IP} --env 'DB_PORT='${DB_PORT} \
           --env 'DB_NAME=gitlabhq_production' --env 'DB_USER='${DB_USER} --env 'DB_PASS='${DB_PASSWORD} \
\
           --env 'REDIS_HOST='${REDIS_IP} --env 'REDIS_PORT='${REDIS_PORT} \
\
           --env 'SMTP_USER='${SMTP_EMAIL} --env 'SMTP_PASS='${SMTP_EMAIL_PASSWORD} \
\
           --env 'DB_EXTENSION=pg_trgm' \
\
           --volume /data/docker/tools/gitlab-sameersbn/volume/data:/home/git/data \
           --volume /data/docker/tools/gitlab-sameersbn/volume/dump:/dump \
           sameersbn/gitlab:latest
```
