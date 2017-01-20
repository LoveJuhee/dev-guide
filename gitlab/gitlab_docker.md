### DOCKER GitLab-CE 설치

-----

상세 정보
http://docs.gitlab.com/omnibus/docker/

-----

#### Step 0 - docker 규칙 정의
- GitLab-CE 버전: 8.9.6
- HOSTNAME: 192.168.5.220 `도메인 명이 있을 경우 사용 가능`
- 포트 설정
  - WEB: 50021 `/etc/gitlab/gitlab.rb 에서 설정한다.`
  - SSH: 22
  - HTTPS: 443
- 외부 포트 설정
  - WEB: 50021
  - SSH: 50022
  - HTTPS: 50023
- 이미지 이름: `gitlab-ce:8.9.6-ce.0`
- 컨테이너 이름: `gitlab-ce`
- Volume
  - /data/docker/tools/gitlab-ce/volume/etc/gitlab:/etc/gitlab
  - /data/docker/tools/gitlab-ce/volume/var/log/gitlab:/var/log/gitlab
  - /data/docker/tools/gitlab-ce/volume/var/opt/gitlab:/var/opt/gitlab
  - /data/docker/tools/gitlab-ce/volume/var_opt_gitlab_backups:/var/opt/gitlab/backups `gitlab 백업 위치`
  - /data/docker/tools/gitlab-ce/volume/data:/data `예비`

-----

#### Step 1 - 컨테이너 생성 스크립트

create-container.sh
```bash
docker run -it -d
  --name gitlab-ce
  --hostname 192.168.5.220
   -p        50021:50021
   -p        50022:22
   -p        50023:443
   -v        /data/docker/tools/gitlab-ce/volume/etc/gitlab:/etc/gitlab
   -v        /data/docker/tools/gitlab-ce/volume/var/log/gitlab:/var/log/gitlab
   -v        /data/docker/tools/gitlab-ce/volume/var/opt/gitlab:/var/opt/gitlab
   -v        /data/docker/tools/gitlab-ce/volume/var_opt_gitlab_backups:/var/opt/gitlab/backups
   -v        /data/docker/tools/gitlab-ce/volume/data:/data
  gitlab/gitlab-ce:8.9.6-ce.0
```

#### Step 2 - 컨테이너 생성 실행 후 종료

`Step 3 작업을 위하여 최초 실행 후 종료한다.`

./create-container.sh
docker stop gitlab-ce

#### Step 3 - gitlab.rb 수정

`주석처리된 부분을 수정한다.`
/data/docker/tools/gitlab-ce/volume/etc/gitlab/gitlab.rb
```ruby
# https 일 경우 https://... 
external_url 'http://192.168.5.220:50021' # HOSTNAME + WEB-PORT
gitlab_rails['gitlab_shell_ssh_port'] = 50022 
```

#### Step 4 - 컨테이너 실행

docker start gitlab-ce

#### Step 5 - 관리자 계정 접속

최초 관리자 계정은 `root` : `5iveL!fe` 이다.

#### Step 6 - email 발송 설정

- https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/doc/settings/smtp.md

-----

#### 참고자료
- https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/raketasks/backup_restore.md
- https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/raketasks/import.md
- http://docs.gitlab.com/omnibus/build/README.html#Build-Docker-image
- https://hub.docker.com/r/gitlab/gitlab-ce/
- https://hub.docker.com/r/gitlab/gitlab-ce/tags/
- https://hub.docker.com/r/gitlab/gitlab-ce/~/dockerfile/
- http://bigmatch.i-um.net/tag/gitlab-update/
