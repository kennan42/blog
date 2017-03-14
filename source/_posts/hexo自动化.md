---
title: hexo部署和自动化发布
date: 2016-11-14 11:10:06
tags: hexo
comments:  true
---
 这里安装hexo过程省略，参考其他文章。这里主要说下如何利用git自动化发布：

> 安装git：sudo apt-get install git

- **创建GitHub Repository** ，在git上创建一个reop库，取名hexo_static
- **安装插件** 

``` 
 $ npm install hexo-deployer-git --save

```

<!-- more -->

- **修改配置文件**  

```
deploy: 
  type: git 
  repo: git@github.com:$username/hexo_static.git
  branch: master
```

注意替换username为自己的git名字，注意这里如果使用https协议的git，那么每次都会要求输入账户和密码，这里使用git协议，在ssh里保存密钥，这样不用每次都输入密码
- **执行命令** 

``` 
$ hexo generate
$ hexo deploy
```

generate:  生成静态文件，文件生成在pulic目录下
deploy: 发布到git的库hexo_static
- **实现自动化** 
> 这里实现自动化思路：通过git --bare 生成一个裸库bare，裸库bare作为一个远程库remote，在裸库实现一个钩子post-receive，当本地库进行push的时候，自动运行钩子，从而更新静态文件目录A，使用nginx进行转发到静态文件目录A。

- **第1步：初始化空仓库**
 
``` 
$ git init --bare ~/hexo_bare
```
 
- **第2步：初始化空仓库**
 
```
$ vim ~/hexo_bare/hooks/post-receive
```

编辑:
 
```
echo "start 钩子"
git --work-tree=/usr/local/nginx/html/myblog --git-dir=/usr/local/hexo_bare checkout -f
echo "end 钩子"
```
 
`这里注意钩子post-ceive后面不带.sample，同时注意赋予权限`：

```
chmod +x post-receive 
```

- **第3步：将空仓库关联到主仓库** 

```
$ git clone https://github.com/$username/hexo_static.git ~/hexo_static 
$ cd ~/hexo_static
$ git remote add live ~/hexo_bare
```

这里给空库起名live ,可以在本地库hexo_static
调用命令： git remote -v 查看到远程库名
`注意：查看下.git/config默认的库名是否是`

```
[branch "master"]
        remote = origin
        merge = refs/heads/master
```

- **第4步：创建自动化脚本** 

```
$ vim ~/hexo_blog/hexo_git_deploy.sh
```

脚本内容：

```
#!/bin/bash

hexo clean
hexo generate 
hexo deploy

( cd ~/hexo_static ; git pull origin; git push live master)
```

`注意：这里一定要git pull origin,不然无法pull成功！`
-   **第5步：nginx指定静态目录**
      在nginx的配置文件中配置即可
-   **第6步：执行自动化**

```
$ hexo new test
$ sh hexo_git_deplay.sh
```

脚本自动化发布成功！可以看到钩子成功执行！查看nginx的静态目录。发现test文件已经存在，甚至不用重启nginx！
至此完成自动化！



