---
title: 配置ubuntu和R的中文环境，用于作图
author: Sheng Luan
date: '2019-07-13'
slug: drawing-a-figure-with-cjk-character
categories:
  - 操作系统
  - R
tags:
  - ubuntu
  - Rstudio
---

今天偶然间又看到当年崇拜的天才少年，技术大神[王垠](http://www.yinwang.org/)的消息。他好像在做设计程序语言和编译器方面的研究，对我这个业余程序员来说，这个方向有些遥远和陌生。当年他从清华在读博士退学的檄文，以及[《完全用GNU/Linux工作》](https://www.cnblogs.com/skyseraph/archive/2010/10/30/1865280.html)的博文，我读的是热血澎湃，对linux开始感兴趣，记得在2006年博士毕业前夕，开始鼓捣ubuntu，开始接触R，差一点耽误了博士毕业论文的提交。再回首，已是十多年前的事情了。随着大数据和人工智能的发展，现在R已经开始火起来了。回想起来，人都是会成长，不断成熟的，后来的王垠不再那么偏激，也认为unix并不是那么完美无缺，开始正面评价[微软设计的系统和软件越来越好了](http://www.yinwang.org/blog-cn/2013/03/07/linux-windows-mac)。       
絮絮叨叨王垠的事情，只能说明自己老了。这篇blog真正的目的是要记录配置ubuntu和Rstudio让它支持中文的过程。跟老婆说，可能没有白浪费的时间。当年读博士时，对ubuntu的热爱，记住的好多vim命令，现在竟然能够用上了。      
### 问题
在阿里云租了一个服务器，安装了Ubuntu-18.04系统。研究生峻宇反应，即使安装了showtext包，也无法在rstudio server上绘制包括中文轴标题的图片。
### 解决方案
通过root账户putty远程登录。我知道这里操作不规范，应该使用普通账户，通过sudo命令来完成。但是，sudo命令的用法已经忘掉了。      
一开始，我以为是字体设置的原因，ubuntu下默认是没有windows字体的，如黑体。后来发现不是这个原因。解决步骤如下：    
#### 1. 设置ubuntu中文环境

* 通过`echo $LANG`命令查看系统本地的locale，发现是**en_US.utf8**。因此需要先把系统的locale设置为中文utf-8。      
* 通过`cat  /etc/locale.gen`命令查看系统支持的locale，发现支持**zh_CN.UTF-8**。        
* 通过`locale-gen zh_CN.UTF-8`命令产生中文locale。       
* 通过`localectl set-locale LANG=zh_CN.utf8`命令设置系统缺省的locale环境为中文。ps：这是为了图省事，你也可以为每个用户、每个session单独设置独立的locale，具体参见[这里](https://www.shellhacks.com/linux-define-locale-language-settings/)。       
* 再次通过`echo $LANG`命令查看系统的默认locale是否修改为中文utf-8。       
* 通过`apt-get install xfonts-wqy`命令安装中文字体，譬如文泉驿等。
* 然后`reboot`命令重启一下服务器。

#### 2. 设置R中文环境

* 通过putty以root账号登录，在控制台输入`R`进入R环境。在R控制台中通过`install.packages("showtext")`函数安装showtext包以及sysfonts包。          
* 通过`library(showtext)`函数加载showtext包后，通过`font_install(source_han_serif())`命令安装中文字体。会安装开源的文泉驿、黑体和宋体等字体。      
* 通过`font_families()`函数查看是否已经安装了wqy-microhei和source-han-serif-cn等字体家族。


#### 3. 中文显示

进行了上述设置后，重启启动R，在Rstudio中plot面板上的图形应该可以显示中文了。如果还不可以，试着利用`ggsave()`函数把ggplot2画出的图形保存为jpeg等文件，再打开发现中文可以正常显示了。

题外话：Cairo是R中一个用于创建高质量的矢量图形(PDF, PostScript, SVG) 和 位图(PNG, JPEG, TIFF)的包，建议安装。在阿里云ubuntu 18.04系统中安装遇到了问题，通过安装以下两个库解决了:

* sudo apt-get install libcairo2-dev
* sudo apg-get install libXt-dev

ps: 一般在ubuntu中安装库，库名是libXt-dev结尾，而不是libXt-devel结尾。
