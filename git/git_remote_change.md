### git 리모트 저장소 수정

-----

#### Step 1 - git 저장소 url을 확인한다.

- gitlab 접속 & 프로젝트 url 복사
  - ex: ssh://git@xxx.xxx.xxx.xxx/ict/nima-kitv-server.git

-----

#### Step 2 - git config 수정

- 옵션: `--replace-all`
- 대상: `remote.origin.url`
- 값: `git 저장소 url`
  - ex: ssh://git@xxx.xxx.xxx.xxx/ict/nima-kitv-server.git

```bash
git config --replace-all remote.origin.url ${GIT_REMOTE_URI}
```
