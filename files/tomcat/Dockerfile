FROM ubuntu:22.04

ARG web_app

RUN apt update
RUN apt install -y default-jdk vim htop wget curl

#RUN apt install -y openjdk-11-jdk
#RUN apt-cache search tomcat
#RUN apt install -y tomcat9 tomcat9-admin
#RUN apt install -y tomcat10 tomcat10-admin
#RUN ufw allow from any to any port 8080 proto tcp
#RUN ss -ltn
#RUN systemctl restart tomcat9

#ADD ${web_app} /usr/local/tomcat/webapps/webapp
#
#CMD ["catalina.sh", "run"]

#RUN find ${APACHE_ETC_DIR} -name tomcat-users.xml -exec sed -i -e 's/;opcache.enable_cli=0/opcache.enable_cli=1/g' {} \;

RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-10/v10.0.23/bin/apache-tomcat-10.0.23.tar.gz
RUN mkdir /opt/tomcat
RUN tar xvzf apache-tomcat-10.0.23.tar.gz -C /opt/tomcat --strip-components=1
COPY tomcat-users.xml /opt/tomcat/conf/
RUN chgrp -R tomcat /opt/tomcat
#RUN chown -R tomcat webapps/ word/ temp/ logs

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]

#MANAGER
#http://localhost:8080/manager/html