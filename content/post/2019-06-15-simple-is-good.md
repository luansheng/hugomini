---
title: 更换hugo主题
author: Sheng Luan
date: '2019-06-15'
slug: simple-is-good
categories:
  - 其他
tags:
  - Hugo
  - theme
output: 
  html_document: 
    keep_md: yes
---

架构在netlify上的blog站点，一开始用的是hugo的经典[学术主题](https://themes.gohugo.io/academic/)。个性化和可配置性非常强，很是符合一个科研人员的需求。**但是**，用了两年后发现越来越慢了，目前总共不到50条blog，然而增加一条新的blog，经常需要等待3-5分钟才能够render完预览，甚至会更长。这些都忍了，最近不知道怎么搞的，hugo突然编译失败了，无法再更新blog。尝试了hugo最新版本，也是无法解决问题。本来想把hugo学术主题更新到最新版本，但是对hugo了解也不多，迁移是个大工程。

因此计划换个主题。要求只有一个，简单。发现[yihui](https://github.com/yihui)修改的[lithium](https://github.com/yihui/hugo-lithium)这个主题非常符合要求，很简单，也不需要怎么配置。因此花了一段时间，把所有的帖子重新render了一遍。

不过重新构建的站点，blog的**链接发生了变化**，现在每个blog链接地址带着日期。因此原blog的链接就失效了。这是很遗憾的事情。

把hugo部署在netlify上，原来记得是直接提交rmd文档即可。现在发现这样不行，必须要把render后的html和jpg等一起提交后，netlify才会编译并且publish成功。写这个帖子的时候，突然明白了，**netlify是可以调用Hugo识别markdown文档的，但是无法识别带有R代码的Rmd文档**。因为netlify无法预知你会使用哪些包，因此不可能配置R系统和各种包来解析rmd文档中的r脚本。

在重新render过程中，还犯了一个错误。电脑系统是windows，不知怎么的经常会自动变为英文系统。也没在意，结果在英文系统下，用rstudio编译，由于认为系统是英文，因此图片的中文标题，全部变为了unicode编码，不得不把操作系统改回中文系统，针对这些帖子重新render了一遍。

现在新加入一个blog，render很快，大概只需要几百ms，不到1秒。再见Hugo academic！特此留记。