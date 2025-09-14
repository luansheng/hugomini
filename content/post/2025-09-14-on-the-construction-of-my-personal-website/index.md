---
title: 回溯个人网站的构建过程
author: Package Build
date: '2025-09-14'
categories:
  - 网站搭建
tags:
  - blogdown
  - R
slug: on-the-construction-of-my-personal-website
---

完全忘记了这个网站是如何建立起来的。经过最近两年的沉寂，计划重新启动这个网站。试着把网站的建立过程，重新梳理起来。

首先，网站是依托[blogdown](https://github.com/rstudio/blogdown "blogdown")这个包，建立起来的，差点忘了。包的开发者是[yihui xie](https://yihui.org/)。今天看了一下他的主页，已经从Rstudio离开了。目前在瑞士一家公司工作。当年经常看他的个人blog，我个人将他定义为一个技术大神。可能也是年龄大了，当爹了，事情太多，2024年开始blog基本不更新了。

经过整理，当年搭建这个网站，主要是参考了yihui专门写的关于blogdown的一本书[《**blogdown: Creating Websites with R Markdown》**](https://bookdown.org/yihui/blogdown/)**。另外参考两个帖子，**[Announcing blogdown v1.0](https://posit.co/blog/blogdown-v1.0/)和[Up & running with blogdown in 2021](https://www.apreshill.com/blog/2020-12-new-year-new-blogdown/)。介绍了blogdown的一些新变化。

目前这个文档是md格式。只需要从git界面中选择这个页面对应的md文件，Commit后，push提交就好。Rstudio结合git的配置过程，参加之前的blog，[如何配合Rstudio，配置git，并把代码库上传到github网站上](https://luansheng.netlify.app/2020/12/27/how-to-set-up-git-and-github-for-r-project/)。
