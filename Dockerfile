#!/bin/bash

FROM openjdk:8-jdk-slim
ENV CATALINA_HOME /opt/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME
RUN apt-get update
RUN apt-get install vim wget zip gettext -y
ENV TOMCAT_VERSION 10.1.9
COPY tomcat.tar.gz .
RUN tar -xf tomcat.tar.gz
#RUN mv tomcat/apache-tomcat-9.0.74/* /opt/tomcat/apache-tomcat-9.0.74/
RUN rm -rf tomcat.tar.gz tomcat/apache-tomcat-9.0.74

#creating default directories
COPY poc-0.0.1-SNAPSHOT.war /opt/tomcat/webapps/

#RUN echo "root:root" | chpasswd
#RUN useradd -ms /bin/bash SUNDEEP -G root -p SUNDEEP@123
#RUN chown -R SUNDEEP:SUNDEEP /opt/
#RUN chmod -R 755 /opt/
#USER SUNDEEP

EXPOSE 8083
CMD ["catalina.sh","run"]
