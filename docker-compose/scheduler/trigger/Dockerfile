FROM hub.vipkid.com.cn/devops/centos6.8-jdk1.8.0:v1.7

MAINTAINER hezhengkui hezhengkui@vipkid.com.cn

#RUN apt-get update
#RUN yum install -y locales
#RUN locale-gen zh_CN
#RUN locale-gen zh_CN.utf8
#RUN update-locale LANG=zh_CN.UTF-8 LC_ALL=zh_CN.UTF-8 LANGUAGE=zh_CN.UTF-8

ENV LANG zh_CN.UTF-8
ENV LANGUAGE zh_CN.UTF-8
ENV LC_ALL zh_CN.UTF-8

ENV JAVA_HOME /usr/local/java
ENV PATH $PATH:$JAVA_HOME/bin

RUN mkdir -p /opt/vipkid/application

WORKDIR /opt/vipkid/application

COPY ./application.jar /opt/vipkid/application
COPY ./run.sh /opt/vipkid/application/run.sh

ENTRYPOINT ["java","-jar","/opt/vipkid/application/application.jar","--profile=dev"]
#ENTRYPOINT ["java","-jar","/opt/vipkid/application/application.jar"]
#ENTRYPOINT ["/opt/vipkid/application/application.jar","start"]
#CMD ["sh", "/opt/vipkid/application/run.sh"]

