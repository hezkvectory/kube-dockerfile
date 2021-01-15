#!/bin/bash

source /etc/bashrc

JAR_PATH=/opt/vipkid/application/application.jar


# 根据不同机器内存决定JVM内存参数
TOTAL_MEM=$(free -g | grep Mem | awk '{print $2}')
case ${TOTAL_MEM} in
[1-2])
    JVM_MEM_OPTION="-Xms1g -Xmx1g"
    ;;
[3-5])
    JVM_MEM_OPTION="-Xms2g -Xmx2g"
    ;;
[6-9])
    JVM_MEM_OPTION="-Xms4g -Xmx4g"
    ;;
1[2-6])
    JVM_MEM_OPTION="-Xms8g -Xmx8g"
    ;;
3[0-9])
    JVM_MEM_OPTION="-Xms24g -Xmx24g"
    ;;
[5-6][0-9])
    JVM_MEM_OPTION="-Xms48g -Xmx48g"
    ;;
*)
    JVM_MEM_OPTION="-Xms4g -Xmx4g"
    ;;
esac


# 服务启动命令
PORT=8080 JMX_PORT=9999 JAVA_OPTS="${JVM_MEM_OPTION} -DVIPKID_APP_CODE=None"  ${JAR_PATH} start


echo "********** 服务后台启动中, 开始循环进行健康检查, $(date '+%Y-%m-%d %H:%M:%S') **********"
for COUNT in {1..80}; do
    CODE=$(curl -s -o /dev/null -w %{http_code} http://127.0.0.1:8080/actuator/health)
    if [ $CODE -eq 200 ]; then
        echo "********** 服务启动成功, 健康检查接口状态:$CODE, $(date '+%Y-%m-%d %H:%M:%S') **********"
        tail -200 std.out
        exit 0
    elif [ $COUNT -eq 80 ]; then
        echo "********** 服务4分钟没有启动成功, $(date '+%Y-%m-%d %H:%M:%S') **********"
        tail -200 std.out
        exit 1
    else
        echo "********** 第${COUNT}次健康检查失败(状态码非200) $(date '+%Y-%m-%d %H:%M:%S') **********"
        sleep 3
    fi
done
