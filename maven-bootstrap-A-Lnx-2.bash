
#!/bin/bash

# Switch to root user (EC2 instance typically runs as root by default when using user data)
sudo su
hostnamectl set-hostname maven-node
exit
sudo su
yum install git -y 
# Install Java 17 Amazon Corretto (prerequisite for Jenkins)
yum install -y java-17-amazon-corretto.x86_64

# Create JAVA_HOME environment variable and add it to the PATH
echo "export JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto.x86_64" >> /etc/profile.d/java.sh
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> /etc/profile.d/java.sh

# Source the new environment variables
source /etc/profile.d/java.sh

# Verify Java installation
java -version

# Move to /opt directory (commonly used for custom installations)
cd /opt

# Download Apache Maven binary tarball
wget https://dlcdn.apache.org/maven/maven-3/3.9.8/binaries/apache-maven-3.9.8-bin.tar.gz

# Unzip the Maven tarball
tar -xvzf apache-maven-3.9.8-bin.tar.gz

# List unzipped Maven directory for verification
ls -l apache-maven-3.9.8

# Navigate into the Maven directory
cd apache-maven-3.9.8

# Create M2_HOME and M2 environment variables and add Maven's bin directory to PATH
echo "export M2_HOME=/opt/apache-maven-3.9.8" >> /etc/profile.d/maven.sh
echo "export M2=/opt/apache-maven-3.9.8/bin" >> /etc/profile.d/maven.sh
echo "export PATH=\$PATH:\$M2_HOME/bin:\$M2" >> /etc/profile.d/maven.sh

# Source the Maven environment variables to apply them immediately
source /etc/profile.d/maven.sh

# Verify the Maven installation
mvn -version

source ~/.bash_profile

# Verify the final PATH (this will show JAVA_HOME and M2 variables)
echo $PATH
