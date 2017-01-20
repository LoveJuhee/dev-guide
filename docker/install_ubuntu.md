## UBUNTU 16.04 DOCKER 설치하기 

### 최신 버전 설치하는 방법
https://docs.docker.com/engine/installation/linux/ubuntulinux/

------
### 아래의 버전은 과거에 진행했던 내용임.
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04

#### Step 1 : Installing Docker

```bash
sudo apt-get update
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
apt-cache policy docker-engine
sudo apt-get install -y docker-engine
sudo systemctl status docker
```

#### Step 2 : Executing the Docker Command Without Sudo (Optional)

```bash
#계정에 docker 그룹권한 추가
sudo usermod -aG docker $(whoami)
```

* 그룹권한 추가 후 새로 로그인 하기 (현재의 터미널에는 권한이 반영이 되지 않았다.)
