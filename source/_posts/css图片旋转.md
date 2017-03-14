---
title:  CSS3 transition实现图片旋转
date: 2016-11-24 22:10:06
tags:  
       - 前端css
       - 图片旋转
comments: true
---

在CSS3中，实现旋转效果需要用到transform属性中的rotate属性；实现盒阴影效果需要使用box-shadow属性。具体参见下面的示例代码。
<!-- more -->
```
-webkit-transform:rotate(10deg); 
-moz-transform:rotate(10deg); transform:rotate(10deg); 
-webkit-box-shadow:2px 2px 3px rgba(135, 139, 144, 0.4); 
-moz-box-shadow:2px 2px 3px rgba(135, 139, 144, 0.4); 
box-shadow:2px 2px 3px rgba(135, 139, 144, 0.4);
```
上面代码部分，首先应该知道的是webkit表示webkit核心的浏览器，是其私有属性，作用于chrome和Safari浏览器，moz是Firefox浏览器的私有属性。
`transform`中文意思转换，含有多个属性值，其中`rotate`表示旋转，其他一些属性如`scale`-尺寸放大缩小（本文将会用到），`skew`表示倾斜角度，`translate`表移动距离。例如，本例中，`rotate(10deg)`表示顺时针旋转10度，如果要逆时针旋转，使用负值就可以了。
`box-shadow`表示盒阴影，其有四个参数，第一个参数表示水平偏移，例如2px表示投影右偏移2像素，第二个参数表示垂直偏移，2px表示投影向下偏移2像素，第三个参数表示模糊的大小，第四个参数为rgba颜色值，例如 `rgba(135, 139, 144, 0.4)`，括号内四个值分别指代`r(red),g(green),b(blue),a(opacity)`，这里表示透明度为40%的一种灰色。

##### 增加动画效果
CSS代码：
```
.pic{
    display:block; width:256px; margin:60px 0 0; 
    padding:10px 10px 15px; text-align:center; 
    background:white; border:1px solid #bfbfbf; 
    -webkit-transform:rotate(10deg); 
    -moz-transform:rotate(10deg); 
    transform:rotate(10deg);        
    -webkit-box-shadow:2px 2px 3px rgba(135, 139, 144, 0.4); 
    -moz-box-shadow:2px 2px 3px rgba(135, 139, 144, 0.4); 
    box-shadow:2px 2px 3px rgba(135, 139, 144, 0.4); 
    -webkit-transition:all 0.5s ease-in;
}
.pic:hover,.pic:focus,.pic:active{
    border-color:#9a9a9a; 
    -webkit-transform:rotate(0deg); 
    -moz-transform:rotate(0deg);
    transform:rotate(0deg);  
}
```
代码部分最关键的就是：`-webkit-transition:all 0.5s ease-in`;目前而言，`transition`仅webkit核心的浏览器支持，所以此效果仅在chrome或是Safari下有。
`transiton`属性有这几个值：
`transition-property `:* //指定过渡的性质，比如`transition-property:backgrond` 就是只指定`backgound`参与这个过渡
`transition-duration`:*//指定这个过渡的持续时间
`transition-delay`:* //延迟过渡时间
`transition-timing-function`:*//指定过渡类型，有ease | linear | ease-in | ease-out | ease-in-out | cubic-bezier

熟悉flash显示与动画编程的应该知道，这里的过渡类型的含义与flash中缓动类型（远不及flash丰富）是一致的：
`linear` //线性过度
`ease-in` //由慢到快
`ease-out` //由快到慢
`ease-in-out` //由慢到快在到慢

所以，`-webkit-transition:all 0.5s ease-in`表示的意思就是所有的属性都执行过渡效果，像角度啊，投影大小，边框色或是下面要讲到的比例啦等，执行时间为0.5秒，过渡动画类型为先慢后快。





