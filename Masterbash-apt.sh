#!/bin/bash
echo "**********INSTALLING JAVA**********"
sudo apt update
sudo apt install openjdk-17-jre-headless -y
sudo apt update

echo "**********INSTALLING PYTHON3**********"
#sudo apt install python3 -y
#sudo apt update

echo "**********INSTALLING ANSIBLE**********"
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
java --version
ansible --version
python3 --version
sudo apt-get update

echo "**********INSTALLING CURL**********"
sudo apt-get install ca-certificates curl -y

echo "**********INSTALLING DOCKER PACKAGE**********"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
docker --version

echo "**********INSTALLING JENKINS**********"
sudo apt update
sudo apt install openjdk-17-jre -y
sudo apt update
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins -y

echo "**********INSTALLING PIP**********"
sudo apt install python3-pip -y

echo "**********INSTALLING UNZIP**********"
sudo apt install unzip -y

echo "**********INSTALLING GIT**********"
sudo apt install git -y

echo "THIS SCRIPT INSTALLED UNZIP, CURL, GIT, DOCKER, ANSIBLE, JENKINS, PYTHON3, PIP,  AND JAVA GIVEN AS -"

echo "JAVA $(java --version)
echo "PYTHON3 $(python3 --version)"
echo "CURL $(curl --version)"
echo "DOCKER $(docker --version)"
echo "PIP $(pip --version)"
echo "GIT VERSION $(git --version)"
echo "ANSIBLE VERSION $(ansible --version)"
echo "JENKINS VERSION $(jenkins --version)"

