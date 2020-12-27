---
title: 如何配合Rstudio，配置git，并把代码库上传到github网站上
author: Sheng Luan
date: '2020-12-27'
slug: how-to-set-up-git-and-github-for-r-project
categories:
  - 其他
tags:
  - Git
---

这个过程是非常繁琐的，所以一直没有详细写的冲动。最近电脑坏了，换了一台，不得不重新配置，因此把整个过程又重新走了一遍，非常痛苦，所以赶紧记载下来。

整个过程可以参照这本电子书：[《Happy Git and GitHub for the useR》](https://happygitwithr.com/index.html)，写的非常详细，但是英文读起来还是比较痛苦。

下述过程是在win 10系统上的配置过程。

## 安装git
从[这个地址](https://git-scm.com/downloads)安装即可。Git跟github并不是一回事。Git是一个版本控制系统程序，用来记录你的电脑上对代码的每一处细微的修改。而Github是一个网站，用来远程存储你的代码库各个修改版本。

Git的官方解释：

Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

关于Git的操作，可以看[《廖雪峰的网站》](https://www.liaoxuefeng.com/wiki/896043488029600/)。讲解的非常详细。

安装好以后，从开始菜单中找到"Git Bash"，输入下边命令，对git进行简单配置，告诉git作者的名字（譬如张三，名字要用英文如拼音San Zhang）和邮箱（譬如zhangsan@163.com）：
```git
git config --global user.name "San Zhang"
git config --global user.email "zhangsan@163.com"
git config --global --list
```
最后一条命令，查看配置是否成功。

## 在Rstudio中设置Git
依次点击菜单Tools-->Global Options-->Git/SVN，如下图设置：
<div align="center">
<img src="/post/images/RstudioGit.jpg"  alt="Rstudio Git" height= "500" width="100%" >
</div>

