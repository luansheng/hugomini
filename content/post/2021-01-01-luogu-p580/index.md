---
title: luogu P580
author: Sheng Luan
date: '2021-01-01'
slug: luogu-p580
categories:
  - C++
tags:
  - C++
---

[题目](https://www.luogu.com.cn/problem/P5082)

```c++
#include<bits/stdc++.h>    //万能头文件
using namespace std;
int main()
{
    int n;  //科目的数量
    int a;  //保存单科满分
    int b;  // 保存单科成绩
    double score1=0;  //所有科目满分总成绩
    double score2=0;  //所有科目实际成绩
    ios::sync_with_stdio(false);  //取消输入输出缓存，避免提交时TLE（时间超限问题）
    cin.tie(0);    //接触cin与cout输出的绑定，提升输入输出的速度
    cout.tie(0);
    cin >> n;      //读入科目的数量
    // 读入所有科目的满分成绩，计算总和
    for(int i=0;i<n;i++)
    {
        cin >> a;
        score1 += a;
    }
    // 读入所有科目的实际成绩
    for(int i=0;i<n;i++)
    {
        cin >> b;
        score2 += b;
    }
    // 计算标准成绩，setprecision函数包括在iomanip头文件中
    cout << setprecision(6) << fixed << (3*score1-2*score2)/(score1-score2) << endl;
    return 0;
}
```

需要注意的点，为了避免TLE问题，需要关闭缓存，以及解除`cin`和`cout`的同步绑定问题。也可以换用`scanf`和`printf`函数来避免TLE问题。

此外，需要把`score1`和`score2`定义为double类型，不然`(3*score1-2*score2)/(score1-score2)`的计算结果将仍然是整数。

