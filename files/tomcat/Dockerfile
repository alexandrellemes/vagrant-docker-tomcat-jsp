FROM tomcat:9.0.1-jre8-alpine

ARG web_app

ADD ${web_app} /usr/local/tomcat/webapps/webapp

CMD ["catalina.sh", "run"]