---
title: ASReml语法高亮文件
author: Sheng Luan
date: '2019-12-01'
slug: syntax-highlight-for-asreml-in-vim
categories:
  - Linux
tags:
  - VIM
---

大约是2006或2007年，写过一个可以在Win平台下vim中使用的ASReml语法高亮文件。一转眼，Win已经进化到了10版本，vim也已经是8.1，ASReml已经是4.1了。ASReml增加了好多新的关键词，我的使用平台也从Win转移到了阿里云的Ubuntu。因此重新制作了一个ASReml的语法高亮文件，并记录了如何在vim中配置。

在配置过程中需要建立两个名为asreml.vim的文件，但是文件中的具体内容和保存位置是不一样的。

## 1. 建立ASReml.vim语法文件
切换到个人home路径，进入.vim路径：

```bash
cd ~
cd .vim
```
如果存在syntax文件夹，直接进入，如果不存在，建立该文件夹：
```bash
mkdir syntax
cd syntax
```
在此文件夹下，放置制作好的第一个asreml.vim文件[点击下载](/post/datasets/asreml.vim)。如要修改该文件，请注意保存为utf8格式。该文件中保存了ASReml4.1的语法关键字，增补了!OUTFOLDER、!ASSIGN、str和nrmv等新的限定符和函数。这个语法文件将ASReml中的关键字分主要分为三部分：

* 大小写都允许的限定符如!CONTINUE，以及几种操作状态如TABULATE、RESIDUAL、PREDCIT、VPREDICT；
* 只能小写的模型函数，如nrmv、giv等；
* 固定写法的模型term，主要包括：mu、mv、Trait和Tr等。

此外，数据文件中列名定义部分、注释和$定义的替代变量也进行了高亮设置。

## 2. 建立ASReml.vim文件类型探测文件
切换到个人home路径，进入.vim路径：
```bash
cd ~
cd .vim
```
如果存在ftdetect文件夹，直接进入。如果不存在，建立该文件夹后进入：
```bash
mkdir ftdetect
cd ftdetect
```
在此文件夹下，放置制作好的第二个asreml.vim文件。其实该文件中只有一行代码，请注意保存为utf8格式。
```vim
au BufNewFile,BufRead *.as setlocal filetype=asreml
```
意思是，当用vim打开扩展名为as的文件时，就按照第一个asreml.vim的着色方案，进行着色。

## 3. 效果图

打开一个as文件，如图所示（很喜欢主题[seoul256.vim](https://github.com/junegunn/seoul256.vim)主题的配色）：
<div align="center">
<img src="/post/images/asremlsyntax.png"  alt="asreml语法高亮截图" height= "600" width="100%" >
</div>
对于~和*等特殊字符，还没有实现着色。

