# opensesame-docker
Opensesame Docker images

Docker Images
-------------

* **opensesame:v3.2.8-runtime-py27-ubuntu18.04**  

# 1. Installing Docker

## Installing Docker on Ubuntu 18.04
```
sudo apt-get update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce
```

## Configuring users
```
sudo usermod -aG docker ${USER}
su - ${USER}
id -nG
```

# 2. Running Opensesame using Docker
```
git clone https://github.com/s4hri/opensesame-docker
cd opensesame-docker
git checkout build
cd scripts
./build
./run
```
