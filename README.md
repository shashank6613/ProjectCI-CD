# ProjectCI-CD
A Funny disclaimer..This Project is a continous integration continuous pipeline one which is created and deployed locally for 
learning and not for commercial purpose (No one is going to anyway).

**********Prerequisites**********
 - Amazon AWS account (Root user preferabley, if not, then have permission to access serveices used in this project) 
 - Dockerhub account
 - Gitub account
 - Basic linux and cloud knowledge

**********Definatations**********

1) CI-CD Pipeline - It is Virtual flow of process and usage of tools combinely, that works together works for integrating and
                    deploymnet of applications and services.

2) AWS account - It is a amazon web services cloud services account through which we use various cloud services for creating
                 maintaining various application services.
     AWS - AWS is a public cloud provider, which provides compute memory data app infrasturcture services online.

3) Dockerhub Account - Dockerhub is a registry account to store application images at a central place. Anyone can pull from
                       the dockerhub for required image to make containers for application and services packaging from a 
                       public repository.

4) Github account - Github is central repository for applications code files and other package files. It contains seperate
                    repositories for code and records history of modifications and provides UI for access.

**********Tools**********

- Softwere tools used in this project is as follows - 

  - Jenkins: It is a automation server tool. It is the key softwere installed in this project.
  - Ansible: It is a configurtion management tool used to create/modified/update the configuration in it's host servers.
  - Docker: It is containerisation tool used to package application in containers, which is lightweight and portable.
  - Git: It is version control tool for Project's code files, used to pull/fetch code files from Github to local system.
  - EKS: It is a manage service for deployment of Kubernetes cluster from Amazon.

**********Git repository contents**********

Jenkinsfile-Create-EKS-Cluster:- used for Jenkins pipeline - 1 script.
Jenkinsfile-Deploy-OnEKS-Cluster:-used for Jenkins pipeline - 2 script.

Masterbash-yum.bash:- Script file for installing necessary tools in Master server[Amazon-Linux].
Agentbash-yum.bash:- Script file for installing necessary tools in Agent server[Amazon-Linux].
Masterbash-apt.bash:- Script file for installing necessary tools in Master server[ubuntu].
Agentbash-apt.bash:- Script file for installing necessary tools in Agent server[ubuntu].

install_awscli.yaml:- Ansible playbook for installing awscli in Agent server.
install_eksctl.yaml:- Ansible playbook for installing eksctl in Agent server.
install_kubectl.yaml:- Ansible playbook for installing kubectl in Agent server.

deployment.yaml:- Deployment file for Kubernetes cluster created by AWS EKS.
service.yaml:- Service file for Kubernetes cluster created by AWS EKS.
 
inventory.ini:- Inventory file for listing ansible hosts.

Dockerfile:- Dockerfile for creating image and make container from it.

index.html:- HTML file for web page display on NGINX web server.
jonatan-pie-*%$#*&@.jpg:- Homepage background image for web server.

README.md:-  Metadata inofrmation about this project.

**********Detailed Walkthorough of Project**********

*This project deployed on using Amazon EC2s and Amazon EKS CLUSTER. Change commands acording to distros used for the purpose.
*The files present in this repo has their standerd values when deployed, change the names of hosts, image, repo, service etc in
 accordance with yours.
*As i have used AWS, so my cloud vocablury is in line with AWS. Read it with yours if you used other.

So let's start.

1) login to your AWS account, Deploy 2 EC2 instances with at least T2.medium cofiguration. Choose keypair, security group
   (for learning all traffic), you can increase the memory if you want otherwise go with default, no issues. Launch it.

2) Log-in the instances using putty/mobaxterm whatever you prefer. Change hostname for "ease to understand". 

3) Go to /etc/hosts file and enter as follows-
   #vi /etc/hosts
    <pvt. ip> Master
    <pvt. ip> Agent

4) Create a IAM Role to attach with Master EC2 instance so that it have access on EKS Cluster we deployed via jenkins.
   This IAM role should have policies added-
   AmazonEKSClusterPolicy
   AmazonECRFullAccess - if you are using ECR in place of Dockerhub
   AmazonEKSWorkerNodePolicy
   Create it, Name it, and attach with Master EC2.

5) First and very important step is to do Passwordless ssh, before installing any softwere. Giving you a short scope overview as-
   at Master-
	#ssh-keygen  for public-private key generation.
	#ssh-copy-id root@Agent  for copying Master server's public keys into authorized_keys file in Agent server.
	#ssh root@Agent  for login into Agent server(*one time it ask password)

	*create password in Agent using #passwd command.
	*if problem occers make changes into sshd_config file.		
	*if not succedded try again using ssh-keygen

   *If ssh-copy-id didn't work, manually copy the keys from "/root/.ssh/id_rsa.pub" and paste in "/root/.ssh/authorized_keys" file

6) Install Bash scripts at Master and Agent servers. That installs required softweres at both.

7) Run jenkins server via Master server ip:8080 in browser.Copy paste given addres in master server termonal and paste the 
   password to get started. Install recommanded plugin, can make user or continue as admin user. Finish.

8) In jenkins>manage jenkins>plugins install plugins as - 
   aws credentials, aws pipeline steps, docker pipeline, kubernetes. Restart jenkins

9) Go to manage jenkins> credentials> global> add credentials. Add credentials of Docker, Git, AWS.
   Use credential ID names as used in pipeline script.

10) Go to Dashboard, add Node, give it a name, add as a permanent agent, Ok. fill the field as required
    Description,remote root directory, launch method(via ssh), host(pvt. ip), credential(jenkins), username(root), 
    pvt key(copy paste)-private key can be found in Master server's "/root/.ssh/id_rsa" file. cat this and copy paste it.
    host key varification(non varyfying). SAVE. This should add a Agent node to jenkins.

11) Go to dashboard > new item > pipeline. Name it, "select pipeline from scm", give URL, Credential, branch, inscript path
    give "jenkins-Create-EKS-Cluster file".

12) Do above process again and then select "jenkinsfile-Deploy-ToEKS-Cluster" file at script path, To create second pipeline
    job. First file contain Post action that automatically trigger second pipeline if it succeeded.

13) When both pipeline succeeded. you can check at Agent server's terminal kubectl get node,deploy or svc, so availiblity of these
    can be ensured. Be informed that deployment of EKS cluster takes almost 15 to 20 minutes generally so be patient.

14) Lastly you can check your Nginx(with custom homepage) can be seen at the browser via loadbalancer's dns. 
       

**********Issues faced**********

I faced these issues while making the project-

1) Username(ssh): I just change the username using hostname command and not edit the local DNS file that is /etc/hosts, so in 
   passwordless ssh, system didn't recognise it.

2) Tools inatallation: Check the requirment of tools for other tools, such as for adding the node in jenkins, it is required
   to install java in Agent node also. Kubectl is required for interaction with eksctl cluster.

3) Distro package managers: While using installation script, some commands have package manager that are used for another distros
   such as- yum for redhat/amazonlinux and apt for ubuntu/debian based.

4) SCM Branch to build: While running pipeline script, used "*/master" as it is a default branch filled in the page, check repo 
   before continuing. I changed it to "*/main".

5) Parameters: In jenkins script when using parameters, be sure to define it before using it, otherwise console throws an error.
 
6) Plugins: Jenkins plugins are power of it, install all that required. As in this project i didn't install 'aws step' plugin, which
   throw error,"could not understand withAWS step" error.

7) Credentials: Save all tools/service credentials beforehand in jenkins, and use the exact same ID which was give at the time 
   of saving it, in jenkins pipeline script, otherwise you see "access denied" error.

8) Service Role: Create a service role for Master ec2 to access eks cluster ecs and other ec2 services, and attach it to master ec2.

9) Inventory file[ansible]: If you're using ansible for installing softwere in agent and added step in jenkins script, make
   sure that ansible pings Agent server locally and passwordless ssh is successful between them. add ip-hostname in inventory file
   and ansible.cfg file. otherwise it throws error as "host unreachable" and skips the steps.

10) File structure/values: Cross check the ansible yamls file for values and syntax errors, try them locally if you can before 
    then use it. 

11) Naming of files: Use clear and exact name and enter in the jenkins pipeline creation step("filepath"), check for upper/lowercase,
    hyphens so jenkins is directed to correct and availible file, and won't throw error.
