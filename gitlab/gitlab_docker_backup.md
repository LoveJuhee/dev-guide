### GitLab-CE 백업 및 복원

-----

상세 정보
https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/raketasks/backup_restore.md

-----

#### gitlab 백업 및 복원 기초

##### 백업
- 백업 데이터는 backups 디렉토리에 생성이 된다.
- 백업 데이터는 timestamp 기반으로 데이터가 생성된다.
  - ex: 1469080610_gitlab_backup.tar
- SKIP 옵션으로 제외할 내용을 입력할 수 있다.
  - db, uploads(attachments), repositories, builds(CI build output logs), artifacts(CI build artifacts), lfs(LFS objects).
  - ex: `sudo gitlab-rake gitlab:backup:create SKIP=db,uploads`

##### 복원
- 복원 시 파일 명 선택은 timestamp 만 입력한다.

-----

#### Type 1 - gitlab 백업 및 복원

- 백업 하기

```bash
sudo gitlab-rake gitlab:backup:create
```
- 복원 하기
  - 생성 시간이 `1393513186` 인 경우

```bash
sudo gitlab:backup:restore BACKUP=1393513186
```

-----

#### Type 2 - docker 기반 백업 및 복원
컨테이너 이름이 `gitlab-ce` 인 경우

- 백업 하기

```bash
docker exec -it gitlab-ce gitlab-rake gitlab:backup:create
```
- 복원 하기
  - 생성 시간이 `1393513186` 인 경우

```bash
docker exec -it gitlab-ce gitlab:backup:restore BACKUP=1393513186
```
