yum install -y java-1.7.0-openjdk java-1.7.0-openjdk-devel
export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk.x86_64

# Install Apache Maven
cd /tmp
wget http://mirrors.digipower.vn/apache/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.zip
unzip apache-maven-3.2.5-bin.zip
sudo mv apache-maven-3.2.5/ /opt/maven
ln -s /opt/maven/bin/mvn /usr/bin/mvn
sudo touch /etc/profile.d/maven.sh && sudo chmod a+w+x /etc/profile.d/maven.sh
echo "
#!/bin/bash
MAVEN_HOME=/opt/maven
PATH=$MAVEN_HOME/bin:$PATH
export PATH
export CLASSPATH=.
" > /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh


