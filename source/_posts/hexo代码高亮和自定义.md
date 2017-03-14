---
title: hexo代码高亮和自定义
date: 2016-11-14 11:10:06
comments: true
tags: hexo
---


#### 设置代码高亮
设置好主题后，发布文章后，有的主题并没有设置代码高亮。要在hexo设置代码高亮，修改config：
```
highlight:
  enable: true
  line_number: true
  auto_detect: true
  tab_replace:
```
然后themes的config也要添加相应的高亮配置。
<!-- more -->
这段代码的作用，查看source/css/style.styl里面:
```
@import 'nib'

global-reset()
@import '_base/variable'
@import '_base/font'
@import '_base/public'
@import '_partial/header'
@import '_partial/index'
@import '_partial/article'
@import '_partial/helper'
@import '_partial/aside'
@import '_partial/footer'
if highlight
  @import '_base/code'
if duoshuo
  @import '_partial/duoshuo'
if fancybox
  @import '_partial/gallery'
```
可以看到，如果设置highlight，那么就引入_base/code下面的css样式。

#### 自定义代码高亮
Wordpress有个[Google Prettify][1]插件，在这里也可以进行高亮显示。
首先将config配置的highlight关闭：
```
highlight:
  enable: false
  line_number: false
  auto_detect: false
  tab_replace:
```
然后我们需要下载[prettify][2]，并引入css和js文件
```
 <!-- 代码高亮-->
 <link rel="stylesheet" href="/css/prettify.css" type="text/css">
 <script src="/js/prettify.js"type="text/javascript"></script>
```
这段代码需要在页面的head引入：
在layout的head.ejs文件中，我们可以查看有js,css文件引入，后面添加即可。

最后我们需要在网页加载完成之后调用即可：
```
$(window).load(function(){
 $('pre').addClass('prettyprint linenums').attr('style', 'overflow:auto;');
   prettyPrint();
 })
```
>**注意：**这段代码使用$(window).load，这是在页面加载完成后调用，跟(document).ready(function() 有所区别。前者只能调用一次，后者能调用多次。在这里，我们添加到文件after_footer.ejs中

```
$(document).ready(function(){ 
   console.log("执行调用prettify  start");
  $('pre').addClass('prettyprint linenums').attr('style', 'overflow:auto;');
   prettyPrint();
   console.log("执行调用prettify  end");
```
另外关于代码高亮的主题，可以在这个[网站][3]选择一套你喜欢的主题替换上面的prettify.css即可。
最后添加代码如下：
```
#head.ejs
<!-- 代码高亮-->
    <link rel="stylesheet" href="/css/tranquil-heart.min.css" type="text/css">
    <script src="/js/prettify.js" type="text/javascript"></script>
```


[1]:https://github.com/google/code-prettify
[2]:https://raw.githubusercontent.com/google/code-prettify/master/distrib/prettify-small.zip
[3]:http://jmblog.github.io/color-themes-for-google-code-prettify/



