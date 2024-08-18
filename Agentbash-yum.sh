#!/bin/bash

echo "**********INSTALLING UNZIP**********"
sudo dnf install zip unzip -y

echo "**********INSTALLING CURL**********"
yum install curl -y
sudo yum update

echo "**********INSTALLING GIT**********"
sudo yum install git -y

echo "**********INSTALLING DOCKER PACKAGE**********"
sudo yum install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo yum update

echo "**********INSTALLING JAVA**********"
sudo dnf install java-17-amazon-corretto -y

echo "**********INSTALLING PIP**********"
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
export PATH=LOCAL_PATH:$PATH
pip --version

echo "**********INSTALLING TAR**********"
sudo yum install tar -y

echo "THIS SCRIPT INSTALLED UNZIP, CURL, GIT, DOCKER, PYTHON3, PIP AND JAVA GIVEN AS -"

echo "JAVA VERSION $(java --version | awk 'NR==2 {print $NF}')"
echo "PYTHON VERSION $(python3 --version | awk 'NR==1 {print $NF}')"
echo "CURL $(curl --version | awk 'NR==1 {print $NF}')"
echo "DOCKER $(docker --version | awk 'NR==1 {print $NF}')"
echo "PIP $(pip --version | awk 'NR==1 {print $NF}')"
echo "TAR $(tar --version | awk 'NR==1 {print $NF}')"
