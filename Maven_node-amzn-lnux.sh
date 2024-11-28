

#!/bin/bash


sudo su 
yum update -y
yum upgrade -y
hostnamectl set-hostname 'maven-worker'
exit
sudo su
yum install -y git
yum install -y java-17-amazon-corretto.x86_64
ls -la


source ~/.bash_profile
echo $PATH

cd /opt
wget https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz
tar -xvzf apache-maven-3.9.8-bin.tar.gz
ls -l apache-maven-3.9.8
cd apache-maven-3.9.8
vi ~/.bash_profile
  JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64
  M2_HOME=/opt/apache-maven-3.9.8
  M2=/opt/apache-maven-3.9.8/bin
  PATH=$PATH:$HOME/bin:$JAVA_HOME:$M2_HOME:$M2

source ~/.bash_profile
echo $PATH


##### Create a new user on Maven build server ( Worker ) for Jenkins communication
# List all the existing users
cat /etc/passwd

useradd jenkins

# Set the password for jenkins user
passwd jenkins

# Add the jenkins user to the sudoers file
visudo

#Press "G" to go to the end of the file 

## Allow root to run any command anywhere
root    ALL=(ALL)     ALL
jenkins ALL=(ALL)     NOPASSWD: ALL

#### Enable password based authentication

vi /etc/ssh/sshd_config
# Search for PasswordAuthentication
# Uncomment the line
PasswordAuthentication yes

# Refresh sshd service
service sshd reload