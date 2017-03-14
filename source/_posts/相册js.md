---
title: PhotoSwipe中文API
date: 2016-11-23 12:10:06
tags: 
      - 相册
      - PhotoSwipe
comments: true
---
PhotoSwipe 是专为移动触摸设备设计的相册/画廊.兼容所有iPhone、iPad、黑莓6+,以及桌面浏览器.底层实现基于HTML/CSS/JavaScript,是一款免费开源的相册产品
<!--more-->
#### 入门
开始之前你应该知道的第一件事:
- PhotoSwipe不是一个简单的jQuery插件，至少需要基本的JavaScript知识来安装。
- PhotoSwipe需要预先定义的图片尺寸（[更多相关信息][1]）。
- 如果您在非响应网站上使用PhotoSwipe，则控件将在移动设备上进行缩放（整个页面缩放）。因此，您需要实现自定义控件（例如右上角的单个大关闭按钮）。
- 文档中的所有代码都是纯Vanilla JS，并支持IE 8及更高版本。如果您的网站或应用程序使用一些JavaScript框架（如jQuery或MooTools）或您不需要支持旧的浏览器 - 随意简化代码。
- 避免为移动设备投放大图片（大于2000x1500像素），因为它们会大大降低动画效果，并可能导致崩溃（尤其是在iOS Safari上）。可能的解决方案：[提供响应图像][2]，或在单独的页面上打开图像，或使用支持图像平铺的库（如[传单][3]）（[更多在常见问题][4]）。
#### 初始化
##### 步骤1：包括JS和CSS文件
你可以找到他们[DIST][4] /文件夹的[GitHub][5]存储库。Sass和未编译的JS文件位于文件夹[src] [6]/中。如果您计划修改现有样式，我建议使用Sass，因为代码是结构化的和注释的。

```
<!-- Core CSS file -->
<link rel="stylesheet" href="path/to/photoswipe.css"> 

<!-- Skin CSS file (styling of UI - buttons, caption, etc.)
     In the folder of skin CSS file there are also:
     - .png and .svg icons sprite, 
     - preloader.gif (for browsers that do not support CSS animations) -->
<link rel="stylesheet" href="path/to/default-skin/default-skin.css"> 

<!-- Core JS file -->
<script src="path/to/photoswipe.min.js"></script> 

<!-- UI JS file -->
<script src="path/to/photoswipe-ui-default.min.js"></script> 
```
不管你如何和在哪里将包括JS和CSS文件。代码只有在您调用时才会执行new PhotoSwipe()。所以，如果你不需要PhotoSwipe最初打开，随意推迟文件加载。
PhotoSwipe还支持AMD加载器（如RequireJS）和CommonJS，使用它们像这样：
```
require([ 
        'path/to/photoswipe.js', 
        'path/to/photoswipe-ui-default.js' 
    ], function( PhotoSwipe, PhotoSwipeUI_Default ) {

    //      var gallery = new PhotoSwipe( someElement, PhotoSwipeUI_Default ...
    //      gallery.init() 
    //      ...

});
```
此外，您可以通过Bower（bower install photoswipe）或NPM（npm install photoswipe）安装它。
##### 步骤2：向DOM中添加PhotoSwipe（.pswp）元素
您可以通过JS动态添加HTML代码（直接在初始化之前），或者在页面中初始化（像在演示页面上完成）。这个代码可以追加到任何地方，但最好是在关闭之前</body>。您可以在多个库中重复使用它（只要使用相同的UI类）。
```
<!-- Root element of PhotoSwipe. Must have class pswp. -->
<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">

    <!-- Background of PhotoSwipe. 
         It's a separate element as animating opacity is faster than rgba(). -->
    <div class="pswp__bg"></div>

    <!-- Slides wrapper with overflow:hidden. -->
    <div class="pswp__scroll-wrap">

        <!-- Container that holds slides. 
            PhotoSwipe keeps only 3 of them in the DOM to save memory.
            Don't modify these 3 pswp__item elements, data is added later on. -->
        <div class="pswp__container">
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
        </div>

        <!-- Default (PhotoSwipeUI_Default) interface on top of sliding area. Can be changed. -->
        <div class="pswp__ui pswp__ui--hidden">

            <div class="pswp__top-bar">

                <!--  Controls are self-explanatory. Order can be changed. -->

                <div class="pswp__counter"></div>

                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>

                <button class="pswp__button pswp__button--share" title="Share"></button>

                <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>

                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>

                <!-- Preloader demo http://codepen.io/dimsemenov/pen/yyBWoR -->
                <!-- element will get class pswp__preloader--active when preloader is running -->
                <div class="pswp__preloader">
                    <div class="pswp__preloader__icn">
                      <div class="pswp__preloader__cut">
                        <div class="pswp__preloader__donut"></div>
                      </div>
                    </div>
                </div>
            </div>

            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                <div class="pswp__share-tooltip"></div> 
            </div>

            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
            </button>

            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
            </button>

            <div class="pswp__caption">
                <div class="pswp__caption__center"></div>
            </div>

        </div>

    </div>

</div>
```
`pswp__bg`，`pswp__scroll-wrap`，`pswp__container`和`pswp__item`元件的顺序不应被改变。
你可能会问，为什么PhotoSwipe不通过JS自动添加这个代码，原因很简单 - 只是为了保存文件大小，万一你需要一些修改布局。
##### 步骤3：初始化
执行`PhotoSwipe`构造函数。它接受4个参数：
1、`.pswp`元素（必须添加到DOM）。
2、PhotoSwipe UI类。如果你包含默认`photoswipe-ui-default.js`，类将会`PhotoSwipeUI_Default`。可以false。
3、具有对象的数组（幻灯片）。
4、[选项][8]。
```
var pswpElement = document.querySelectorAll('.pswp')[0];

// build items array
var items = [
    {
        src: 'https://placekitten.com/600/400',
        w: 600,
        h: 400
    },
    {
        src: 'https://placekitten.com/1200/900',
        w: 1200,
        h: 900
    }
];

// define options (if needed)
var options = {
    // optionName: 'option value'
    // for example:
    index: 0 // start at first slide
};

// Initializes and opens PhotoSwipe
var gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, items, options);
gallery.init();
```
最后你应该得到这样的东西：
`HTML代码`:
```
<button id="btn">Open PhotoSwipe</button>

<!-- Root element of PhotoSwipe. Must have class pswp. -->
<div class="pswp" tabindex="-1" role="dialog" aria-hidden="true">

    <!-- Background of PhotoSwipe. 
         It's a separate element, as animating opacity is faster than rgba(). -->
    <div class="pswp__bg"></div>

    <!-- Slides wrapper with overflow:hidden. -->
    <div class="pswp__scroll-wrap">

        <!-- Container that holds slides. PhotoSwipe keeps only 3 slides in DOM to save memory. -->
        <div class="pswp__container">
            <!-- don't modify these 3 pswp__item elements, data is added later on -->
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
            <div class="pswp__item"></div>
        </div>

        <!-- Default (PhotoSwipeUI_Default) interface on top of sliding area. Can be changed. -->
        <div class="pswp__ui pswp__ui--hidden">

            <div class="pswp__top-bar">

                <!--  Controls are self-explanatory. Order can be changed. -->

                <div class="pswp__counter"></div>

                <button class="pswp__button pswp__button--close" title="Close (Esc)"></button>

                <button class="pswp__button pswp__button--share" title="Share"></button>

                <button class="pswp__button pswp__button--fs" title="Toggle fullscreen"></button>

                <button class="pswp__button pswp__button--zoom" title="Zoom in/out"></button>

                <!-- Preloader demo http://codepen.io/dimsemenov/pen/yyBWoR -->
                <!-- element will get class pswp__preloader--active when preloader is running -->
                <div class="pswp__preloader">
                    <div class="pswp__preloader__icn">
                      <div class="pswp__preloader__cut">
                        <div class="pswp__preloader__donut"></div>
                      </div>
                    </div>
                </div>
            </div>

            <div class="pswp__share-modal pswp__share-modal--hidden pswp__single-tap">
                <div class="pswp__share-tooltip"></div> 
            </div>

            <button class="pswp__button pswp__button--arrow--left" title="Previous (arrow left)">
            </button>

            <button class="pswp__button pswp__button--arrow--right" title="Next (arrow right)">
            </button>

            <div class="pswp__caption">
                <div class="pswp__caption__center"></div>
            </div>

          </div>

        </div>

</div>
```

`JS代码`：
```
var openPhotoSwipe = function() {
    var pswpElement = document.querySelectorAll('.pswp')[0];

    // build items array
    var items = [
        {
            src: 'https://farm2.staticflickr.com/1043/5186867718_06b2e9e551_b.jpg',
            w: 964,
            h: 1024
        },
        {
            src: 'https://farm7.staticflickr.com/6175/6176698785_7dee72237e_b.jpg',
            w: 1024,
            h: 683
        }
    ];
    
    // define options (if needed)
    var options = {
			 // history & focus options are disabled on CodePen        
      	history: false,
      	focus: false,

        showAnimationDuration: 0,
        hideAnimationDuration: 0
        
    };
    
    var gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, items, options);
    gallery.init();
};

openPhotoSwipe();

document.getElementById('btn').onclick = openPhotoSwipe;
```
####  创建幻灯片对象数组
数组中的每个对象都应包含有关幻灯片的数据，它可以是您想要在PhotoSwipe中显示的任何内容 - 图片路径，字幕字符串，共享数量，评论等。
默认情况下，PhotoSwipe仅使用5个属性：（src路径到图像），w（图像宽度），h（图像高度），msrc（小图像占位符的路径，大图像将被加载在顶部），html（自定义HTML，更多关于它）。
在导航期间，PhotoSwipe会向此对象添加自己的属性（如minZoom或loaded）
```
var slides = [

    // slide 1
    {

        src: 'path/to/image1.jpg', // path to image
        w: 1024, // image width
        h: 768, // image height

        msrc: 'path/to/small-image.jpg', // small image placeholder,
                        // main (large) image loads on top of it,
                        // if you skip this parameter - grey rectangle will be displayed,
                        // try to define this property only when small image was loaded before



        title: 'Image Caption'  // used by Default PhotoSwipe UI
                                // if you skip it, there won't be any caption


        // You may add more properties here and use them.
        // For example, demo gallery uses "author" property, which is used in the caption.
        // author: 'John Doe'

    },

    // slide 2
    {
        src: 'path/to/image2.jpg', 
        w: 600, 
        h: 600

        // etc.
    }

    // etc.

];
```
您可以在PhotoSwipe读取它们之前直接动态定义幻灯片对象属性，使用gettingData事件（更多信息在文档的API部分）。例如，该技术可以用于为不同的屏幕尺寸提供不同的图像。

#### 如何从链接列表构建幻灯片数组
假设您有一个看起来像这样的链接/缩略图列表（关于图库标记的更多信息）：
```
<div class="my-gallery" itemscope itemtype="http://schema.org/ImageGallery">

    <figure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="large-image.jpg" itemprop="contentUrl" data-size="600x400">
            <img src="small-image.jpg" itemprop="thumbnail" alt="Image description" />
        </a>
        <figcaption itemprop="caption description">Image caption</figcaption>
    </figure>

    <figure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
        <a href="large-image.jpg" itemprop="contentUrl" data-size="600x400">
            <img src="small-image.jpg" itemprop="thumbnail" alt="Image description" />
        </a>
        <figcaption itemprop="caption description">Image caption</figcaption>
    </figure>


</div>
```
...并且您想要点击缩略图以大图片打开PhotoSwipe（就像在演示页上完成的一样）。所有你需要做的是：
1、将点击事件绑定到链接/缩略图。
2、用户点击缩略图后，找到其索引。
3、从DOM元素创建幻灯片对象数组 - 循环遍历所有链接并检索href属性（大图片网址），data-size属性（其大小），src缩略图和标题内容。
PhotoSwipe真的不在乎你会怎么做。如果你使用jQuery或MooTools等框架，或者如果你不需要支持IE8，代码可以大大简化。
这里是纯IE的支持的vanilla JS实现：
```
var initPhotoSwipeFromDOM = function(gallerySelector) {

    // parse slide data (url, title, size ...) from DOM elements 
    // (children of gallerySelector)
    var parseThumbnailElements = function(el) {
        var thumbElements = el.childNodes,
            numNodes = thumbElements.length,
            items = [],
            figureEl,
            linkEl,
            size,
            item;

        for(var i = 0; i < numNodes; i++) {

            figureEl = thumbElements[i]; // <figure> element

            // include only element nodes 
            if(figureEl.nodeType !== 1) {
                continue;
            }

            linkEl = figureEl.children[0]; // <a> element

            size = linkEl.getAttribute('data-size').split('x');

            // create slide object
            item = {
                src: linkEl.getAttribute('href'),
                w: parseInt(size[0], 10),
                h: parseInt(size[1], 10)
            };



            if(figureEl.children.length > 1) {
                // <figcaption> content
                item.title = figureEl.children[1].innerHTML; 
            }

            if(linkEl.children.length > 0) {
                // <img> thumbnail element, retrieving thumbnail url
                item.msrc = linkEl.children[0].getAttribute('src');
            } 

            item.el = figureEl; // save link to element for getThumbBoundsFn
            items.push(item);
        }

        return items;
    };

    // find nearest parent element
    var closest = function closest(el, fn) {
        return el && ( fn(el) ? el : closest(el.parentNode, fn) );
    };

    // triggers when user clicks on thumbnail
    var onThumbnailsClick = function(e) {
        e = e || window.event;
        e.preventDefault ? e.preventDefault() : e.returnValue = false;

        var eTarget = e.target || e.srcElement;

        // find root element of slide
        var clickedListItem = closest(eTarget, function(el) {
            return (el.tagName && el.tagName.toUpperCase() === 'FIGURE');
        });

        if(!clickedListItem) {
            return;
        }

        // find index of clicked item by looping through all child nodes
        // alternatively, you may define index via data- attribute
        var clickedGallery = clickedListItem.parentNode,
            childNodes = clickedListItem.parentNode.childNodes,
            numChildNodes = childNodes.length,
            nodeIndex = 0,
            index;

        for (var i = 0; i < numChildNodes; i++) {
            if(childNodes[i].nodeType !== 1) { 
                continue; 
            }

            if(childNodes[i] === clickedListItem) {
                index = nodeIndex;
                break;
            }
            nodeIndex++;
        }



        if(index >= 0) {
            // open PhotoSwipe if valid index found
            openPhotoSwipe( index, clickedGallery );
        }
        return false;
    };

    // parse picture index and gallery index from URL (#&pid=1&gid=2)
    var photoswipeParseHash = function() {
        var hash = window.location.hash.substring(1),
        params = {};

        if(hash.length < 5) {
            return params;
        }

        var vars = hash.split('&');
        for (var i = 0; i < vars.length; i++) {
            if(!vars[i]) {
                continue;
            }
            var pair = vars[i].split('=');  
            if(pair.length < 2) {
                continue;
            }           
            params[pair[0]] = pair[1];
        }

        if(params.gid) {
            params.gid = parseInt(params.gid, 10);
        }

        return params;
    };

    var openPhotoSwipe = function(index, galleryElement, disableAnimation, fromURL) {
        var pswpElement = document.querySelectorAll('.pswp')[0],
            gallery,
            options,
            items;

        items = parseThumbnailElements(galleryElement);

        // define options (if needed)
        options = {

            // define gallery index (for URL)
            galleryUID: galleryElement.getAttribute('data-pswp-uid'),

            getThumbBoundsFn: function(index) {
                // See Options -> getThumbBoundsFn section of documentation for more info
                var thumbnail = items[index].el.getElementsByTagName('img')[0], // find thumbnail
                    pageYScroll = window.pageYOffset || document.documentElement.scrollTop,
                    rect = thumbnail.getBoundingClientRect(); 

                return {x:rect.left, y:rect.top + pageYScroll, w:rect.width};
            }

        };

        // PhotoSwipe opened from URL
        if(fromURL) {
            if(options.galleryPIDs) {
                // parse real index when custom PIDs are used 
                // http://photoswipe.com/documentation/faq.html#custom-pid-in-url
                for(var j = 0; j < items.length; j++) {
                    if(items[j].pid == index) {
                        options.index = j;
                        break;
                    }
                }
            } else {
                // in URL indexes start from 1
                options.index = parseInt(index, 10) - 1;
            }
        } else {
            options.index = parseInt(index, 10);
        }

        // exit if index not found
        if( isNaN(options.index) ) {
            return;
        }

        if(disableAnimation) {
            options.showAnimationDuration = 0;
        }

        // Pass data to PhotoSwipe and initialize it
        gallery = new PhotoSwipe( pswpElement, PhotoSwipeUI_Default, items, options);
        gallery.init();
    };

    // loop through all gallery elements and bind events
    var galleryElements = document.querySelectorAll( gallerySelector );

    for(var i = 0, l = galleryElements.length; i < l; i++) {
        galleryElements[i].setAttribute('data-pswp-uid', i+1);
        galleryElements[i].onclick = onThumbnailsClick;
    }

    // Parse URL and open gallery if it contains #&pid=3&gid=1
    var hashData = photoswipeParseHash();
    if(hashData.pid && hashData.gid) {
        openPhotoSwipe( hashData.pid ,  galleryElements[ hashData.gid - 1 ], true, true );
    }
};

// execute above function
initPhotoSwipeFromDOM('.my-gallery');
```

提示：您可以从CodePen下载示例以在本地播放（Edit on CodePen- > Share- > Export .zip）。
如果您使用的标记与此示例不同，则需要编辑功能parseThumbnailElements。
如果你没有纯粹的JavaScript经验，并且不知道如何解析DOM，请参考QuirksMode和MDN上的文档。
请注意，IE8不支持HTML5<figure>和<figcaption>元素，因此您需要在节中包含html5shiv<head>（cdnjs托管版本用于示例）：
<!--[if lt IE 9]>
    <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.2/html5shiv.min.js"></script>
<![endif]-->



[1]:http://photoswipe.com/documentation/faq.html#image-size
[2]:http://photoswipe.com/documentation/responsive-images.html
[3]:http://leafletjs.com/
[4]:http://photoswipe.com/documentation/faq.html#mobile-crash
[5]:https://github.com/dimsemenov/PhotoSwipe/tree/master/dist
[6]:https://github.com/dimsemenov/PhotoSwipe
[7]:https://github.com/dimsemenov/PhotoSwipe/tree/master/src

[8]:http://photoswipe.com/documentation/options.html
