FROM hub.vipkid.com.cn/devops/centos6.8-jdk1.8.0:v1.7

MAINTAINER hezhengkui hezhengkui@vipkid.com.cn

RUN mkdir -p /opt/vipkid/application

WORKDIR /opt/vipkid/application

COPY ./main /opt/vipkid/application
CMD ["/opt/vipkid/application/main"]
#CMD ["/opt/vipkid/application/main","--project=project-1", "--profile=test"]
#ENTRYPOINT ["/opt/vipkid/application/scheduler-agent"]


#CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build main.go
