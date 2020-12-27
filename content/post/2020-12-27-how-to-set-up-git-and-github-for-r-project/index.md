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
```bash
git config --global user.name "San Zhang"
git config --global user.email "zhangsan@163.com"
git config --global --list
```
最后一条命令，查看配置是否成功。

## git使用
具体参照廖雪峰文档。简单举个例子。譬如新建一个文件夹myrepo，用于保存你的项目代码。

在Rstudio中新建一个readme.txt文档，保存在myrepo文件夹中。注意文件要保存为utf-8格式。关于Rstudio的一些设置，可以参考[之前的blog](https://luansheng.netlify.app/2017/11/19/lmm-tutorial-1/)。

通过`Git Bash`启动Bash shell。输入以下命令，初始化该文件夹，作为代码仓库。
```bash
git init
```
接下来，把文件readme.txt添加到初始化成功的代码库中。这样以后对于readme.txt的任何修改，就会被git记录下来。

```bash
git add readme.txt
```

然后对本次提交行为，进行记录说明，方便后续修改回溯。
```bash
git commit -m "Added the readme file"
```

接下来，我们尝试把myrepo中的内容同步保存到github网站上。

## 注册一个github账户
到[github](https://github.com/)官网注册一个账户。假设申请成功的用户名为**zhangsan**，后边我们会用到这个名字。

## 生成SSH key
把本地代码传输到github，一般是通过SSH协议。我们需要生成一个本地电脑的SSH key，保存到github网站上。生成SSH Key的命令为：
```git
ssh-keygen -t rsa -C "zhangsan@163.com"
```
成功的话，你会在用户主目录下发现.ssh目录，里边保存了id_rsa和id_rsa.pub两个文件，这两个就是SSH Key的秘钥对，id_rsa是私钥，不能泄露出去，id_rsa.pub是公钥，可以放心地告诉任何人。

## 将id_rsa.pub保存到github网站上
具体做法为：

登陆GitHub，打开“Account settings”，“SSH Keys”页面：

然后，点“Add SSH Key”，填上任意Title（**建议以你电脑的英文名字标注，因为可能会从多个不同的电脑终端提交相同的代码，需要提交多个电脑终端的公钥**），在Key文本框里粘贴id_rsa.pub文件的内容。

具体可参考廖雪峰的[学习教程](https://www.liaoxuefeng.com/wiki/896043488029600/896954117292416)

## 生成PTA
如果计划通过https协议提交代码，可以考虑生成PAT（personal access token）。具体可参考[《Chapter 10 Cache credentials for HTTPS》](https://happygitwithr.com/credential-caching.html)

首先通过R包usethis来生成PAT：
```r
usethis::create_github_token()
```
注意一定要及时保存生成的PAT。

然后通过R包gitcreds中的gitcreds_set()函数，将PAT写入当前电脑中。
```r
library(gitcreds)
gitcreds_set()
```

## 在github网站上建立一个空的远程仓库myrepo
具体方法参照[廖雪峰教程](https://www.liaoxuefeng.com/wiki/896043488029600/898732864121440)。


## 将代码库远程存储到github网站上
启动Git Bash，需要在本地myrepo文件夹下执行以下操作。
```Bash
git branch -M main #确保提交的是主分支
git remote add origin git@github.com:zhangsan/myrepo.git
git push -u origin main
```
请注意，其中zhangsan为在github上申请成功的用户名。

如果平常的工作是在Rstudio中写代码，感觉又记不住这些复杂的git命令。可以考虑使用Rstudio中简易的git客户端功能。我个人在使用，感觉够用。

## 在Rstudio中设置Git
依次点击菜单Tools-->Global Options-->Git/SVN，确保Git程序被发现，SSH RSA Key（私钥）文件已经正确填写。

一般在win 10系统中，git.exe默认路径为`C:/Program Files/Git/bin/git.exe`。

私钥文件如前所述，一般是在用户目录下.ssh文件夹中，名称默认为id_rsa文件。

具体可参考[该链接](https://happygitwithr.com/rstudio-see-git.html)配置。

配置好之后，就可以打开Rstudio，写好新的R脚本，保存在myrepo文件夹中，然后通过Rstudio中的git面板来进行Commit、Push和Pull。







