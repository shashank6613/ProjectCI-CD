#!/bin/bash
echo "***************************************INSTALLING JAVA***************************************"
sudo apt update
sudo apt install openjdk-17-jre-headless -y

#echo "***************************************INSTALLING PYTHON3***************************************"
#sudo apt update
#sudo apt install python3 -y
#sudo apt-get update

echo "***************************************INSTALLING CURL***************************************"
sudo apt-get install ca-certificates curl -y

echo "***************************************INSTALLING DOCKER PACKAGE***************************************"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
	    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker

echo "***************************************INSTALLING PIP***************************************"
sudo apt install python3-pip -y

echo "***************************************INSTALLING UNZIP***************************************"
sudo apt install unzip -y

echo "***************************************INSTALLING AWS-CLI***************************************"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

echo "***************************************INSTALLING TAR***************************************"
sudo apt-get install tar -y

echo "***************************************INSTALLING EKSCTL***************************************"
 curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz"
 curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $(uname -s)_amd64 | sha256sum --check
 tar -xzf eksctl_$(uname -s)_amd64.tar.gz -C /tmp && rm eksctl_$(uname -s)_amd64.tar.gz
 sudo mv /tmp/eksctl /usr/local/bin

 echo "***************************************INSTALLING KUBECTL***************************************"
 snap install kubectl --classic
 kubectl version --client
 echo "THIS PACKAGE INSTALLED JAVA , PYTHON3, CURL, DOCKER, PIP, UNZIP, AWSCLI, EKSTCL, AND 
 KUBECTL GIVEN AS -"

 echo "JAVA VERSION $(java --version | awk 'NR==2 {print $NF}')"
 echo "PYTHON VERSION $(python3 --version | awk 'NR==1 {print $NF}')"
 echo "CURL $(curl --version | awk 'NR==1 {print $NF}')"
 echo "DOCKER $(docker --version | awk 'NR==1 {print $NF}')"
 echo "PIP $(pip --version | awk 'NR==1 {print $NF}')"
 echo "AWS-CLI $(aws --version | awk 'NR==1 {print $NF}')"
 echo "KUBECTL $(kubectl version --client | awk 'NR==1 {print $NF}')"
 echo "EKSCTL $(eksctl version | awk 'NR==1 {print $NF}')"
 echo "TAR $(tar --version | awk 'NR==1 {print $NF}')"
