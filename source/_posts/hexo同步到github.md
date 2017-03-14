
---
title: hexo同步到github
date: 2016-11-15 12:10:06
comments: true
tags: 
     - hexo
     - github
---
#### 上传本地项目到github
1. 建立Git仓库
```
git init
```
2. 将项目文件添加到仓库中
```
git add .
```
注意：add后面有个 .

<!--more-->
3. 将我们添加的文件commit到git仓库， 添加注释
```
git commit -m "注释"
```
4. 将本地的仓库与github上的仓库进行关联
```
git remote add origin "git仓库的地址"
```
>在这个工程中可能要求你输入账户密码，我们先保存ssh密钥在git上，使用git协议的地址就不会要求你输入了。

5. 上传之前我们先从git上拉取一下
```
git pull origin master
```
6. push本地项目到远程仓库
```
git push -u origin master
```
至此项目就上传到github上了。


