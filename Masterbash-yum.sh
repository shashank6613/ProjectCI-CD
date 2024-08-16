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

echo "**********INSTALLING ANSIBLE**********"
sudo yum install -y epel-release
sudo yum install -y ansible
sudo wget -O /etc/yum.repos.d/jenkins.repo \
	    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade

echo "**********INSTALLING JAVA**********"
sudo dnf install java-17-amazon-corretto -y

echo "**********INSTALLING JENKINS**********"
sudo yum install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "**********INSTALLING PIP**********"
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
export PATH=LOCAL_PATH:$PATH
pip --version

echo "**********INSTALLING TAR**********"
sudo yum install tar -y

echo "THIS SCRIPT INSTALLED UNZIP, CURL, GIT, DOCKER, ANSIBLE, JENKINS, PYTHON3, PIP,  AND JAVA GIVEN AS -"

echo "JAVA VERSION $(java --version | awk 'NR==2 {print $NF}')"
echo "PYTHON VERSION $(python3 --version | awk 'NR==1 {print $NF}')"
echo "CURL $(curl --version | awk 'NR==1 {print $NF}')"
echo "ANSIBLE VERSION $(ansible --version | awk 'NR==1 {print $NF}')"
echo "JENKINS VERSION $(jenkins --version | awk 'NR==1 {print $NF}')"
echo "DOCKER $(docker --version | awk 'NR==1 {print $NF}')"
echo "PIP $(pip --version | awk 'NR==1 {print $NF}')"
echo "AWS-CLI $(aws --version | awk 'NR==1 {print $NF}')"
echo "KUBECTL $(kubectl version --client | awk 'NR==1 {print $NF}')"
echo "EKSCTL $(eksctl version | awk 'NR==1 {print $NF}')"
echo "TAR $(tar --version | awk 'NR==1 {print $NF}')"
