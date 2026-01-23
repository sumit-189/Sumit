port 9000
quality Anlysis 

vulnerability (security risk) 
code smell : syntex --code undustandeble 
dupliocation : code %duplication 
bugs : some feature not work proparly
(error:- if error come s ur hole code not working)

Java based application
port 9000
-------------------------------------------
Launch instance (linux) 
  size - 2/4
  Networking - port :9000
  storage : 15gib
on console ----
  sudo -i
  yum update 
 
  --------installing Database --------------
  rpm -ivh http://repo.mysql.com/mysql57-community-release-el7.rpm
  rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
  yum install mysql-server -y
  systemctl start mysqld
  systemctl enable mysqld
  grep 'temporary password' /var/log/mysqld.log          -------copy the password and save for future use 
  mysql_secure_installation    -------neter your old password and generate the new password 
  
  ----------install java ----------------
  yum install wget epel-release -y
  yum install java -y
  wget https://download.bell-sw.com/java/11.0.4/bellsoft-jdk11.0.4-linux-amd64.rpm
  rpm -ivh bellsoft-jdk11.0.4-linux-amd64.rpm
  #alternatives --config java
  systemctl restart mysqld

 ----------------configure Database for sonarqube ----------------
 mysql -u root -h localhost -pCloud@123   -------(Cloud@123) is new generated password -------
  create database sonarqube;
  create user 'sonarqube'@'localhost' identified by 'Redhat@123';
  grant all privileges on sonarqube.* to 'sonarqube'@'localhost';
  flush privileges;
  exit

-----------------install sonarqube----------------------
yum install unzip -y
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.9.1.zip
cd /opt
unzip ~/sonarqube-7.9.1.zip
mv sonarqube-7.9.1 sonar

-----------------configure sonarqube-------------------
sed -i -e '/^sonar.jdbc.username/ d' -e '/^sonar.jdbc.password/ d' -e '/^sonar.jdbc.url/ d' -e '/^sonar.web.host/ d' -e '/^sonar.web.port/ d' /opt/sonar/conf/sonar.properties
sed -i -e '/#sonar.jdbc.username/ a sonar.jdbc.username=sonarqube' -e '/#sonar.jdbc.password/ a sonar.jdbc.password=Redhat@123' -e '/InnoDB/ a sonar.jdbc.url=jdbc.mysql://localhost:3306/sonarqube?useUnicode=true&characterEncoding=utf&rewriteBatchedStatements=true&useConfigs=maxPerformance' -e '/#sonar.web.host/ a sonar.web.host=0.0.0.0' /opt/sonar/conf/sonar.properties
useradd sonar
vim /etc/passwd        ----------see either the display or not RUN_AS_USER=sonar--------------------
chown sonar:sonar /opt/sonar/ -R
cd /sonar/linux../
vim sonar.sh           -----displayed RUN_AS_USER=sonar-------------
sed -i -e '/^#RUN_AS_USER/ c RUN_AS_USER=sonar' sonar.sh
ls
./sonar.sh start
./sonar.sh status
alternatives --config java 
    :2
./sonar.sh start
./sonar.sh status
---copy public ip and paste on browser with port no :8080
login the sonarqube 

------creating project on sonarqube------------
projects - new project -name -setup - generate token - (my-token-name)- save - continue - language -java -maven - copy project (save) 

-----------Slave project--------
sudo -i
apt update 
update-alternatives --config java
      :11
paste the copied project 
ls

--------------go to he sonarqube project ---------
see  

quality gates - create new -name -save - add condition -duplicated block - error:1 - add condition - set as default 

--------------slave project ------------
paste the copied project 
see on sonarqube projects (failed) 
