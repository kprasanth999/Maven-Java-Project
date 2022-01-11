FROM centos

LABEL Maintainer=RNS Email=rns@rnstech.com

RUN yum update -y
RUN yum -y install java
RUN java -version

#RUN mkdir /opt/tomcat/

WORKDIR /opt
RUN curl -O https://dlcdn.apache.org/tomcat/tomcat-8/v8.5.73/bin/apache-tomcat-8.5.73-windows-x64.zip
RUN tar xzvf apache-tomcat-8.5.58.tar.gz -C /opt/
RUN cp -R /opt/apache-tomcat-8.5.58/ /opt/tomcat

WORKDIR /opt/tomcat/webapps
COPY target/*.war /opt/tomcat/webapps/webapp.war

EXPOSE 8080

ENTRYPOINT ["/opt/tomcat/bin/catalina.sh", "run"]
