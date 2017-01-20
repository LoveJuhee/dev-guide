# DOCKER IMAGE & CONTAINER 관리하기 


### docker image manage

##### save
- DOCKER_IMAGE : 이미지 이미
- DOCKER_BACKUP_NAME : 백업한 이미지 파일 이름

```bash
docker save ${DOCKER_IMAGE} > ${DOCKER_BACKUP_NAME}.tar
```

#####  load
- DOCKER_BACKUP_NAME : 백업한 이미지 파일 이름

```bash
docker load < ${DOCKER_BACKUP_NAME}.tar
```

-----

### container manage

##### 이미지로 저장
- 이미지로 생성하는 이유는 하위 버전을 만들거나 재활용을 위해서 사용한다.
- 내용정보
  - DOCKER_CONTAINER_NAME : 컨테이너 ID 또는 이름
  - DOCKER_IMAGE_NAME : 생성할 이미지 명
  - DOCKER_IMAGE_TAG : 이미지 태그 

```bash
docker commit ${DOCKER_CONTAINER_NAME} ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
```

##### 컨테이너 백업
- 백업 방법
  - 이미지가 필요한 경우: 이미지로 저장하고 이미지를 백업한다. (위의 내용을 조합)
  - 이미지가 필요없는 경우: export 활용
- 내용정보
  - DOCKER_CONTAINER_NAME : 컨테이너 ID 또는 이름
  - DOCKER_CONTAINER_BACKUP_NAME : 백업한 컨테이너 파일 이름

1. 압축 방식
```bash
docker export ${DOCKER_CONTAINER_NAME} | gzip > ${DOCKER_CONTAINER_BACKUP_NAME}.tar.gz
```

2. 비 압축 방식
```bash
docker export ${DOCKER_CONTAINER_NAME} > ${DOCKER_CONTAINER_BACKUP_NAME}.tar
```

##### 백업한 컨테이너 이미지로 복원
- 컨테이너 복원은 이미지로 복원이 된다.
  - 복원된 이미지를 이용하여 컨테이너를 생성하면 된다.
- 내용정보
  - DOCKER_CONTAINER_BACKUP_NAME : 백업한 컨테이너 파일 이름
  - DOCKER_IMAGE_NAME : 복원할 이미지 명
  - DOCKER_IMAGE_TAG : 이미지 태그 

1. 압축 방식
```bash
zcat ${DOCKER_CONTAINER_BACKUP_NAME}.tar.gz | docker import - ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
```

2. 비 압축 방식
```bash
cat ${DOCKER_CONTAINER_BACKUP_NAME}.tar | docker import - ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
```

##### 컨테이너 용량 줄이기
- 컨테이너 용량을 이미지로 저장하여 컨테이너의 크기를 줄이는 방법
  - 컨테이너의 용량이 이미지의 용량으로 변환이 된다.
  - 이미지로 생성하고 해당 이미지의 컨테이너를 만들면 된다. 
- 내용정보
  - DOCKER_CONTAINER_NAME : 컨테이너 ID 또는 이름
  - DOCKER_IMAGE_NAME : 복원할 이미지 명
  - DOCKER_IMAGE_TAG : 이미지 태그 

```bash
docker export ${DOCKER_CONTAINER_NAME} | docker import - ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
```

-----

- 참고사이트
  - http://pyrasis.com/book/DockerForTheReallyImpatient/Chapter20/16
  - https://www.npteam.net/965
  - http://digndig.kr/docker/709/
