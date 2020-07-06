---
title: AWK使用笔记
author: Sheng Luan
date: '2020-07-06'
slug: tricks-for-awk
categories:
  - 数据清洗
tags:
  - AWK
---

在Ubuntu下，默认安装mawk。建议使用gawk。如果没有安装，可以通过
```{bash}
apt-get install gawk
```
进行安装。

安装后，可以通过以下命令，选择默认使用的awk。
```{bash}
sudo update-alternatives --config awk
```

awk学习，建议参考<<The AWK Programming Language>>这本书，中译本见[这里](https://github.com/wuzhouhui/awk)。

## 1. 查看行列数的方法

假设example.csv是由英文逗号,分割的csv文件。

### 1.1 查看文件的行数

第一种方法，利用wc命令，该命令可以统计文件中单词、字符、行数等信息。

```{bash}
wc -l example.csv
```

第二种方法，通过awk命令。实际上awk是一门编程语言，查看行数的语句为：

```{bash}
awk 'END { print NR }' example.csv
```
**END**表示处理完文件后，打印出行数。这是并未对文件做任何处理。NR为awk的内置变量，是Number of Records的缩写，意为记录的计数。一条记录为一行。遍历完文件最后一条记录之后，NR保存最后一条记录的计数，也就是文件的行数。

### 1.2 查看文件的列数：

假定所有记录的列数相等，查看文件列数的最快方法为：
```{bash}
awk -F "," '{ print NF; exit}' example.csv
```

读取第一行，计算列数，awk程序退出。**-F**表示每一行通过英文逗号切割为多列。**NF**是awk的内置变量，是Number of Field的缩写，意为字段的数量。一个字段为一列。

## 2. 查看指定范围行和列的内容

### 2.1 查看指定范围的行内容

查看1-10行的数据
```{bash}
awk 'NR <=10 { print $0 }' example.csv
```
### 2.2 查看指定范围的行和列内容

查看前10行，第1-10列的数据，稍微复杂一些，需要用到循环：
```{bash}
awk -F "," ' NR<= 10 {for (i=1; i<11;i=i+1) {printf($i" ")}; printf("\n") }' example.csv
```
基本的逻辑：

* NR<=10 判断每行行号是否小于10，如果是，则输出；
* for循环部分针对每一行，通过**-F**指定的**英文逗号","对行**进行切割，通过for循环输出指定的列；
* 每一行列输出完毕后，再输出一个换行符号。

上述代码适合查看非常大的文件。




