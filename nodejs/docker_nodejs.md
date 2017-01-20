### DOCKER NODE 실행환경

-----

package.json 기반으로 의존성을 정리하여 컨테이너로 생성해주는 도커 이미지이다.

Docker Node Version List
- https://hub.docker.com/_/node/

-----

#### Step 0 - docker 규칙 정의
- NODE 버전: 4.4
- 호스트 연결포트: 40001:80, 40002:8080, 40003:9999
  - 호스트 포트 목록: 40001, 40002, 40003
  - 이미지 포트 목록: 80, 8080, 9999
- 이미지 이름: `ict-aa`
- 실행 이미지 이름: `running-ict-aa`
- env 
  - `NODE_ENV=production`
  - `MONGOLAB_URI=mongodb://xxx.xx.xxx.xx/aa`
- 빌드 옵션
  - `-onbuild` 생성 시 빌드한다
- 실행 옵션
  - `--rm` 종료시 제거한다

-----

#### Step 1 - Dockerfile 생성
Dockerfile
```config
# node 4.4.7
FROM node:4-onbuild
# 사용하는 포트 목록 정의
EXPOSE 80
EXPOSE 8080
EXPOSE 9999
```

#### Step 2 - 빌드 스크립트 설정
docker-build.sh
```bash
#!/bin/bash

# 기존 이미지가 있을 경우 제거
echo "remove image"
docker rmi ict-aa

# 이미지 빌드
echo "build"
docker build -t ict-aa .
```

#### Step 3 - 실행 스크립트 설정
docker-run.sh
```bash
#!/bin/bash
docker run -it --rm --name running-ict-aa \
  -p 40001:80 -p 40002:8080 -p 40003:9999\
  --env 'NODE_ENV=production' \
  --env 'MONGOLAB_URI=mongodb://xxx.xx.xxx.xx/aa' \
  ict-aa
```

#### Step 4 - 설치 및 실행
```bash
$ ./docker-build.sh
$ ./docker-run.sh
```

#### Step 5 - 주의사항
- 방화벽은 기본적으로 풀어줘야 한다.