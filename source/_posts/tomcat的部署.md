---
title: tomcat的部署
date: 2016-11-15 13:10:06
tags: tomcat
comments: true
---

安装tomcat需要预先安装JDK, JDK安装方法参考如下文档：
<!-- more-->
http://help.aliyun.com/knowledge_detail/6507861.html?spm=5176.7114037.1996646101.1.FD0keL&pos=1

本文将tomcat安装到了/usr/local/jdk1.8.0_60目录下，如果安装到了其他目录，请替换掉本文的JDK目录。

##### 1. 下载tomcat：
```
#wget http://apache.fayea.com/tomcat/tomcat-7/v7.0.64/bin/apache-tomcat-7.0.64.tar.gz
```
如果下载404，重新找路径
apache.fayea.com/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz
##### 2. 将tomcat放置到 /usr/local/ 目录下
```
#mv apache-tomcat-7.0.64.tar.gz /usr/local/
```
##### 3. 解压缩：
```
tar -xvzf /usr/local/apache-tomcat-7.0.64.tar.gz
```
##### 4. 设置tomcat开机自启动
编辑/usr/local/apache-tomcat-7.0.64.tar.gz/bin/startup.sh
```
# vi /usr/local/apache-tomcat-7.0.64/bin/startup.sh
加入如下行：
#chkconfig: 2345 80 90
#description:tomcat auto start
#processname: tomcat
```
编辑/usr/local/apache-tomcat-7.0.64/bin/catalina.sh
```
# vi /usr/local/apache-tomcat-7.0.64/bin/catalina.sh
```
搜索export关键字，加入如下行：
```
export CATALINA_BASE=/usr/local/apache-tomcat-7.0.64
export CATALINA_HOME=/usr/local/apache-tomcat-7.0.64
export CATALINA_TMPDIR=/usr/local/apache-tomcat-7.0.64
```
将tomcat加入开机自启动
```
# vi /etc/rc.d/rc.local
```
加入如下内容：
```
export JAVA_HOME=/usr/local/jdk1.8.0_60
/usr/local/apache-tomcat-7.0.64/bin/startup.sh start
```
执行
```
# /usr/local/apache-tomcat-7.0.64/bin/startup.sh 启动tomcat
```
 打开浏览器测试：
tomcat默认监听8080端口，如果要修改成为80端口，按如下步骤修改：
```
# vi /usr/local/apache-tomcat-7.0.64/conf/server.xml
```
找到
```
<Connector port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
 <Connector executor="tomcatThreadPool"
               port="8080" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
```

修改为：
```
<Connector port="80" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
 <Connector executor="tomcatThreadPool"
               port="80" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
```
重启tomcat生效






