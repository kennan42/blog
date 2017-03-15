---
title:  nodejs开发(1)--安装篇
date: 2016-12-16 22:10:06
tags:  
       - 后端
       - nodejs
comments: true
---
![](http://ken-blog.image.alimmdn.com/test/nodejs.jpeg@200h)
<!-- more-->
##### 安装
我的系统是centos，以centos为例：
#####  一、 yum方式安装
要通过 yum 来安装 nodejs 和 npm 需要先给 yum 添加 epel 源：
`添加 epel 源:`
64位：
```
rpm -ivh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
```
32位：
```
rpm -ivh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
```
导入 key:
```
rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
```
`添加 remi 源:`
```
rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-remi
```

安装完成之后执行：
```
##注意：这步也许不需要
curl --silent --location https://rpm.nodesource.com/setup_5.x | bash -

```

```
yum -y install nodejs
```
安装结束。

`注意：如果安装过程提示gcc相关报错,需要先执行`

```
yum install -y gcc-c++ make
```
`再执行：`
```
yum -y install nodejs
```

#####  二、 源码安装
##### 1.安装下载源码
```
##这里源码地址自己替换最新的
cd /usr/local/src/
wget http://nodejs.org/dist/v0.10.24/node-v0.10.24.tar.gz
```
##### 2.解压源码
```
tar  zxvf    node-v0.10.24.tar.gz
```
##### 3.编译安装
```
cd node-v0.10.24
./configure --prefix=/usr/local/node/0.10.24
make                                                                                                    
make install
```
>./configure --prefix
指定安装路径
不指定prefix，则可执行文件默认放在/usr /local/bin，库文件默认放在/usr/local/lib，配置文件默认放在/usr/local/etc。其它的资源文件放在/usr /local/share。你要卸载这个程序，要么在原来的make目录下用一次make uninstall（前提是make文件指定过uninstall）,要么去上述目录里面把相关的文件一个个手工删掉。
指定prefix，直接删掉一个文件夹就够了。

##### 4.配置NODE_HOME
进入profile编辑环境变量
```
vim /etc/profile
```
设置nodejs环境变量，在 `export PATH USER LOGNAME MAIL HOSTNAME HISTSIZE HISTCONTROL` 一行的上面添加如下内容:
```
#set for nodejs
export NODE_HOME=/usr/local/node/0.10.24
export PATH=$NODE_HOME/bin:$PATH
```
:wq保存并退出，编译/etc/profile 使配置生效
```
source /etc/profile
```
验证是否安装配置成功
```
node -v
```
输出 v0.10.24 表示配置成功。
npm模块安装路径：
`/usr/local/node/0.10.24/lib/node_modules/`
