
---
title:  nginx挂载软连接的问题
date: 2016-11-24 22:10:06
tags:  
       - 后端
       - nginx
comments: true
---
问题：在nginx的html文件目录挂载了一个软连接，发现通过nginx访问始终是403，访问限制。
<!-- more-->
后来查询google发现原因是nginx对软连接进行访问限制，没有办法通过nginx去访问。
解决：取消软连接，利用nfs挂载文件
这里实际服务器为例子。
执行命令：
```
mount -l
```
发现没有挂载，所以执行mount命令将文件路径挂载到nginx的html下面即可。
```
mount 10.10.1.151:/opt/emm/uploads /usr/share/nginx/html
```
随后
```
vim  /etc/fstab
```
看到没有记录，这样每次服务器重启后挂载就会消失。这里修改下文件：
```
10.10.1.151:/opt/emm  /opt/emm nfs defaults 0 0 
10.10.1.151:/opt/emm/uploads  /usr/share/nginx/uploads  nfs defaults 0 0
```
 退出保存修改。
 然后执行命令查看：
```
mount -a
```
挂载成功。



