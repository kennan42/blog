---
title: Atom工具的使用
date: 2016-11-25 12:10:06
tags:
     - 前端
     - 工具
comments: true
---

Atom是git内部使用的编辑器，现在开源了，官网地址:https://atom.io/
<!-- more-->
这里推荐某大大的博客介绍：http://blog.csdn.net/crper/article/details/45786335

第一次打开时会发现文件显示多了.DS_Store，这个文件是MAC的finder文件，可以隐藏显示:
1.preference - > setting -> core 中，找到Ignored Names，在其中添加 .DS_Store，注意添加","
2.在packages中搜索"tree-view" 在其设置中，勾选 Hide Ignored Names

这里列出几种常用插件：
`color-picker `        : 取色器      快捷键：cmd+shift+c
`RIB - run in browser`:  浏览器预览   快捷键：ctrl+alt +r
`git-plus`   :git的快捷键: Cmd-Shift-H
`atom-ternjs`: JS代码智能补全
`CSScomb` :css美化
`atom-beautify`: atom美化代码，可以在保存的时候自动格式化
`alt-cmd-i`  :chrome调试
