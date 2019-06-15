---
title: my first blog
author: Sheng Luan
date: '2017-06-06'
slug: my-first-blog
categories:
  - github
tags:
  - mathjax
  - netlify
header:
  caption: ''
  image: ''
---

这是我的第一个blog，架构在github上，基于jekyll。
### 1. 数学公式

hugo支持数学公式，但是对于.md文档，为了正常显示公式。需要首先在layouts文件夹下，建立partials文件夹，然后新建head_custom.html文件，在文件中<head>块内加入下列语句：
``` javascript
<script type="text/javascript" async
   src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
```
请注意，下边的链接不再起作用。具体参见说明：http://docs.mathjax.org/en/latest/start.html
``` javascript   
<script type="text/javascript"
  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>
```
对于.md格式文档，为了正常显示公式，需要在\$$前后加入\`。

``` Latex
$$
\begin{align*}
  & \phi(x,y) = \phi \left(\sum_{i=1}^n x_ie_i, \sum_{j=1}^n y_je_j \right)
  = \sum_{i=1}^n \sum_{j=1}^n x_i y_j \phi(e_i, e_j) = \\
  & (x_1, \ldots, x_n) \left( \begin{array}{ccc}
      \phi(e_1, e_1) & \cdots & \phi(e_1, e_n) \\
      \vdots & \ddots & \vdots \\
      \phi(e_n, e_1) & \cdots & \phi(e_n, e_n)
    \end{array} \right)
  \left( \begin{array}{c}
      y_1 \\
      \vdots \\
      y_n
    \end{array} \right)
\end{align*}
$$
```
`$$\begin{align*}
  & \phi(x,y) = \phi \left(\sum_{i=1}^n x_ie_i, \sum_{j=1}^n y_je_j \right)
  = \sum_{i=1}^n \sum_{j=1}^n x_i y_j \phi(e_i, e_j) = \\
  & (x_1, \ldots, x_n) \left( \begin{array}{ccc}
      \phi(e_1, e_1) & \cdots & \phi(e_1, e_n) \\
      \vdots & \ddots & \vdots \\
      \phi(e_n, e_1) & \cdots & \phi(e_n, e_n)
    \end{array} \right)
  \left( \begin{array}{c}
      y_1 \\
      \vdots \\
      y_n
    \end{array} \right)
\end{align*}$$`

### 2. 页内跳转
找了好久，都没有找到如何页内跳转。如下所示：

"[]"内是点击会跳转的文字,"()"内#后边的"1"表示要跳转的链接的ID。
```markdown
[Searle](#1)(1980)详细的讨论了对于各种因子、嵌套和协方差模型，该如何定义最小二乘均值。
```
[Searle](#1)(1980)详细的讨论了对于各种因子、嵌套和协方差模型，该如何定义最小二乘均值。

定义跳转的目的地，与前边的"1"对应，也称锚点（anchor）
```markdown
<a id="1">1</a> Searle SR, Speed FM, Milliken GA (1980). Population marginal means in the linear model: A alternative to least squares means. The American Statistician, 34(4), 216-221.
```
<a id="1">1</a> Searle SR, Speed FM, Milliken GA (1980). Population marginal means in the linear model: A alternative to least squares means. The American Statistician, 34(4), 216-221.

### 3. 关于git的一些小问题（windows系统）
git现在的版本默认使用的是utf-8编码，但是在git log git status时，中文文件名会显示乱码。解决方案：
在git bash中输入下列命令：

```
git config --global core.quotepath false
git config --global gui.encoding utf-8 
git config --global i18n.commitencoding utf-8 
git config --global i18n.logoutputencoding utf-8 
export LESSCHARSET=utf-8
```
管用，但是作用机理不清楚。

git 自带vi，以前用过不短的时间，临时修改文件中的几个小地方还是很方便的。自动识别中文内容，不出现编码问题？在git bash中输入：

```
cd /etc
vi vimrc
```
在打开的vimrc文件开头添加以下代码：
```
set nu
set fencs=utf-8,gbk,utf-16,utf-32,ucs-bom
```

