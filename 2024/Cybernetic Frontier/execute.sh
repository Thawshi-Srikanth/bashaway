# Start Install Google Chrome (You may comment out these lines during local testing if you already have Chrome installed. Though the chromedriver installed here might not work with your Chrome version)

sudo apt update

wget https://mirror.cs.uchicago.edu/google-chrome/pool/main/g/google-chrome-stable/google-chrome-stable_126.0.6478.114-1_amd64.deb
sudo dpkg -i google-chrome-stable_126.0.6478.114-1_amd64

sudo apt-get install -y -f

rm google-chrome-stable_126.0.6478.114-1_amd64

# End Install Google Chrome

# Write your code here
curl -L -O https://download.oracle.com/java/25/latest/jdk-25_linux-x64_bin.tar.gz
tar -xvzf jdk-25_linux-x64_bin.tar.gz
sudo mv jdk-25.0.1 /opt/

rm jdk-25_linux-x64_bin.tar.gz


export JAVA_HOME=/opt/jdk-25.0.1 

export PATH=$JAVA_HOME/bin:$PATH

curl -L -O https://dlcdn.apache.org/tomcat/tomcat-11/v11.0.14/bin/apache-tomcat-11.0.14.tar.gz
tar -xvzf apache-tomcat-11.0.14.tar.gz
mv apache-tomcat-11.0.14 tomcat_server
rm apache-tomcat-11.0.14.tar.gz

sed -i 's/Connector port="8080"/Connector port="5000"/g' tomcat_server/conf/server.xml

#replace ROOT with src
mv src tomcat_server/webapps/ROOT/


# start jsp server
tomcat_server/bin/startup.sh
tomcat_server/bin/startup.sh

