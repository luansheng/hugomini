---
title: 最小二乘均值的估计模型
author: Sheng Luan
date: '2017-06-10'
categories:
  - lmm
tags:
  - least-squares means
  - marginal means
  - ASReml
slug: least-squares-means-note-1
header:
  caption: ''
  image: ''
---

# 1.最小二乘均值的定义和背景
## 1.1 最小二乘均值的定义（来自lsmeans包简介）

定义：least-squares means (LS means for short) for a linear model are simply predictions-or averages thereof-over a regular grid of predictor settings which I call **the reference grid**, 简称为LS means。

Ls means的历史可以追溯到1960年，1977年Harvey写出了计算机程序LSML，并且贡献了SAS软件中的HARVEY过程。以后，lsmeans声明加入到了SAS的各种过程如GLM中。SAS、单机版ASReml、R中的包lsmeans和ASReml-R都可以计算LS means。

在协方差分析模型中 LS means与协变量校正均值（covariate-adjusted means）相同。在不平衡因子试验中，每一个因子的LS means跟主效应均值非常相似，但是进行了不平衡校正。后边这种解释，跟未加权的均值（unweighted means)方法非常相似。

LS means 并不是很好理解，术语本身就会令人迷惑。[Searle](#Searle)（1980）详细的讨论了对于各种因子、嵌套和协方差模型，该如何定义最小二乘均值。Searle建议利用术语"predicted marginal means"来代替"least-squares means",可能更为合理。

需要强调的两点：

* 最小二乘均值根据参考表格（reference grid）计算
* 一旦建立了参考表格，最小二乘均值就是基于表格的简单预测，或者说是预测值列表的边际均值（marginal means）。

## 1.2 参考表格（reference grid）
为了计算预测值，我们需要定义一套参考水平（见下文）；
* 参考水平的组合构成参考表格
* 参考水平的获取方法
    * 如果是因子，那么因子的每个水平作为参考水平；
    * 如果是协变量，那么用协变量的总体均值作为参考水平；
    * 因此参考表格涉及到模型和数据两个层面。

### 1.2.1 橙子售卖数据集
oranges的数据集(36行×6列)结构如下：

* 两个品种，对应两个价格（price1和price2）和两个销量（sales1和sales2）；
* 然后还有store和day两个列变量，分别表示售卖的商店和时间；
* store和day两个变量为因子类型，价格为整数类型，销量为数字类型。

```r
dim(oranges)
```

```
## [1] 36  6
```

```r
head(oranges)
```

```
##   store day price1 price2  sales1  sales2
## 1     1   1     37     61 11.3208  0.0047
## 2     1   2     37     37 12.9151  0.0037
## 3     1   3     45     53 18.8947  7.5429
## 4     1   4     41     41 14.6739  7.0652
## 5     1   5     57     41  8.6493 21.2085
## 6     1   6     49     33  9.5238 16.6667
```

```r
str(oranges)
```

```
## 'data.frame':	36 obs. of  6 variables:
##  $ store : Factor w/ 6 levels "1","2","3","4",..: 1 1 1 1 1 1 2 2 2 2 ...
##  $ day   : Factor w/ 6 levels "1","2","3","4",..: 1 2 3 4 5 6 1 2 3 4 ...
##  $ price1: int  37 37 45 41 57 49 49 53 53 53 ...
##  $ price2: int  61 37 53 41 41 33 49 53 45 53 ...
##  $ sales1: num  11.32 12.92 18.89 14.67 8.65 ...
##  $ sales2: num  0.0047 0.0037 7.5429 7.0652 21.2085 ...
```
### 1.2.2 计算最小二乘均值

#### 1.2.2.1 建立模型
建立模型，分析影响品种1销量（Sales1）的主要因素:  

* 在模型中包括store,day, price1和price2等4个因素;
* 其中store和day由于是因子变量，因此作为固定效应；price1和price2作为协变量;
* 这里把price2纳入模型，是因为品种2的价格也会影响品种1的销量。

```r
oranges.lm1 <- lm(sales1 ~ price1 + price2 + store + day , data = oranges)
anova(oranges.lm1)
```

```
## Analysis of Variance Table
## 
## Response: sales1
##           Df Sum Sq Mean Sq F value    Pr(>F)    
## price1     1 516.59  516.59 29.0996 1.763e-05 ***
## price2     1  62.73   62.73  3.5334  0.072873 .  
## store      5 212.95   42.59  2.3991  0.068548 .  
## day        5 433.10   86.62  4.8793  0.003456 ** 
## Residuals 23 408.31   17.75                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
其中`lm()`函数为R自带的函数，包括在stats包中。`anova()`给出了方差分析表。

从表中可以看出，price2对sales1的影响未达到显著水平。

#### 1.2.2.2 建立参考表格
lsmeans包中的`ref.grid()`可以用来建立参考表格，代码如下：

```r
oranges.rg1 <- ref.grid(oranges.lm1)
oranges.rg1
```

```
## 'ref.grid' object with variables:
##     price1 = 51.222
##     price2 = 48.556
##     store = 1, 2, 3, 4, 5, 6
##     day = 1, 2, 3, 4, 5, 6
```

从上边结果中可以看出，两个价格协变量price1和price2用它们的均值作为参考水平。

两个因子用它们各自的6个水平作为参考水平。因此参考表格共计包括$1×1×6×6=36$个水平组合。

#### 1.2.2.3 获得不同参考水平组合的预测值
LS means基于参考表格的预测值进行计算。参考表格的预测值可以通过`summary()`或者`predict()`获得。

```r
oranges.rg1.prediction <- summary(oranges.rg1)
oranges.rg1.prediction
```

```
##    price1   price2 store day prediction       SE df
##  51.22222 48.55556 1     1     2.918413 2.717559 23
##  51.22222 48.55556 2     1     4.961475 2.377742 23
##  51.22222 48.55556 3     1     3.200891 2.377742 23
##  51.22222 48.55556 4     1     6.198757 2.363673 23
##  51.22222 48.55556 5     1     5.543218 2.363116 23
##  51.22222 48.55556 6     1    10.563739 2.366683 23
##  51.22222 48.55556 1     2     3.848804 2.701335 23
##  51.22222 48.55556 2     2     5.891866 2.335579 23
##  51.22222 48.55556 3     2     4.131282 2.335579 23
##  51.22222 48.55556 4     2     7.129148 2.352186 23
##  51.22222 48.55556 5     2     6.473609 2.330670 23
##  51.22222 48.55556 6     2    11.494130 2.339254 23
##  51.22222 48.55556 1     3    11.018569 2.534556 23
##  51.22222 48.55556 2     3    13.061630 2.416451 23
##  51.22222 48.55556 3     3    11.301047 2.416451 23
##  51.22222 48.55556 4     3    14.298913 2.431679 23
##  51.22222 48.55556 5     3    13.643374 2.363673 23
##  51.22222 48.55556 6     3    18.663895 2.347839 23
##  51.22222 48.55556 1     4     6.096286 2.651370 23
##  51.22222 48.55556 2     4     8.139348 2.352186 23
##  51.22222 48.55556 3     4     6.378765 2.352186 23
##  51.22222 48.55556 4     4     9.376630 2.388653 23
##  51.22222 48.55556 5     4     8.721091 2.337599 23
##  51.22222 48.55556 6     4    13.741613 2.341304 23
##  51.22222 48.55556 1     5    12.795800 2.444597 23
##  51.22222 48.55556 2     5    14.838862 2.466155 23
##  51.22222 48.55556 3     5    13.078278 2.466155 23
##  51.22222 48.55556 4     5    16.076144 2.519089 23
##  51.22222 48.55556 5     5    15.420605 2.395544 23
##  51.22222 48.55556 6     5    20.441126 2.370343 23
##  51.22222 48.55556 1     6     8.748779 2.786176 23
##  51.22222 48.55556 2     6    10.791841 2.337599 23
##  51.22222 48.55556 3     6     9.031258 2.337599 23
##  51.22222 48.55556 4     6    12.029123 2.364688 23
##  51.22222 48.55556 5     6    11.373584 2.352318 23
##  51.22222 48.55556 6     6    16.394106 2.370539 23
```
#### 1.2.2.4 计算最小二乘均值
有了基于参考表格的预测值后，通过lsmeans包中的`lsmeans()`函数可以直接获得某一个因子各水平的最小二乘均值。

```r
lsmeans(oranges.rg1,"day")
```

```
##  day    lsmean       SE df  lower.CL  upper.CL
##  1    5.564415 1.768083 23  1.906856  9.221974
##  2    6.494807 1.728959 23  2.918183 10.071430
##  3   13.664571 1.751505 23 10.041308 17.287835
##  4    8.742289 1.733920 23  5.155403 12.329175
##  5   15.441803 1.785809 23 11.747576 19.136029
##  6   11.394782 1.766726 23  7.740031 15.049533
## 
## Results are averaged over the levels of: store 
## Confidence level used: 0.95
```

上面结果，给出了每一天品种1销量(**Sales1**)的最小二乘均值。

可以从看出，周三、周五的销量最高，周六次之。

#### 1.2.2.5 其他方法验证
上述结果实际上是对oranges.rg1.prediction预测数据集，按照day不同水平进行均值汇总输出的结果。

利用dplyr包相关函数手动计算day六个水平的最小二乘均值：

```r
suppressMessages(require(dplyr))
oranges.rg1.day.lsmeans <- oranges.rg1.prediction %>% 
  group_by(day) %>% 
  summarise(lsmean=mean(prediction))
oranges.rg1.day.lsmeans
```

```
## # A tibble: 6 x 2
##      day    lsmean
##   <fctr>     <dbl>
## 1      1  5.564415
## 2      2  6.494807
## 3      3 13.664571
## 4      4  8.742289
## 5      5 15.441803
## 6      6 11.394782
```
进一步利用ASReml-R中的相关函数，计算day六个水平的最小二乘均值，相互验证。


```r
suppressMessages(require(asreml))
```

```r
oranges.asreml <-
  asreml(
    fixed = sales1 ~ -1+store + day + price1 + price2 ,
    rcov = ~ units,
    family = asreml.gaussian(),
    data = oranges,
    maxiter = 100
  )
```

```
## ASReml: Thu Jun 15 12:34:50 2017
## 
##      LogLik         S2      DF      wall     cpu
##     -60.6324     17.7525    23  12:34:50     0.0
##     -60.6324     17.7525    23  12:34:50     0.0
## 
## Finished on: Thu Jun 15 12:34:50 2017
##  
## LogLikelihood Converged
```

```r
oranges.asreml.lsmeans <- predict(oranges.asreml,classify = "day")
```

```
## ASReml: Thu Jun 15 12:34:53 2017
## 
##      LogLik         S2      DF      wall     cpu
##     -60.6324     17.7525    23  12:34:53     0.0
##     -60.6324     17.7525    23  12:34:53     0.0
## 
## Finished on: Thu Jun 15 12:34:53 2017
##  
## LogLikelihood Converged
```

```r
oranges.asreml.lsmeans$predictions$pvals
```

```
## 
## Notes:
## - The predictions are obtained by averaging across the hypertable
##   calculated from model terms constructed solely from factors in
##   the averaging and classify sets.
## - Use "average" to move ignored factors into the averaging set.
## 
## - price1 evaluated at average value of 51.222222
## - price2 evaluated at average value of 48.555556
## - The SIMPLE averaging set:  store 
## 
##   day predicted.value standard.error est.status
## 1   1        5.564415       1.768083  Estimable
## 2   2        6.494807       1.728959  Estimable
## 3   3       13.664571       1.751505  Estimable
## 4   4        8.742289       1.733920  Estimable
## 5   5       15.441803       1.785808  Estimable
## 6   6       11.394782       1.766726  Estimable
```
从结果来看，利用lsmeans，手动汇总和asreml给出的结果都是一致的。上述结果有助于加深对于LS means的理解。

### 1.2.3 调整参考表格
在计算LS means的时候，可以考虑设置协变量的值，以及要预测的因子的水平。  
譬如，我们可以设置在price1=50，price2=40以及price2=60水平上，只预测2,3,4三天的最小二乘均值。

```r
org.lsm <- lsmeans(oranges.lm1,"day",by="price2",at=list(price1=50,price2=c(40,60),day=c("2","3","4")))
org.lsm
```

```
## price2 = 40:
##  day    lsmean       SE df  lower.CL upper.CL
##  2    6.236227 1.887106 23  2.332452 10.14000
##  3   13.405992 2.119376 23  9.021730 17.79025
##  4    8.483710 1.866510 23  4.622540 12.34488
## 
## price2 = 60:
##  day    lsmean       SE df  lower.CL upper.CL
##  2    9.213169 2.109448 23  4.849443 13.57689
##  3   16.382933 1.905216 23 12.441693 20.32417
##  4   11.460651 2.178054 23  6.955003 15.96630
## 
## Results are averaged over the levels of: store 
## Confidence level used: 0.95
```

# 2. 基于ASReml单机版的LS means实例分析

在动物育种中 ，lsmeans经常用作不同群体性能的比较。
假定有3个群体，每个群体包含数量不等的家系，本文的目的是比较不同群体的生长性能，即收获体重的差异。

## 2.1 固定效应
如果模型中同时包括固定效应和随机效应，首先建立只包括固定效应（除残差随机效应外）的模型，通过**Wald F**统计检验显著性。

在ASReml中，**Wald F**统计检验方法的方法有两种，F-inc和F-con。F-inc表示incremental form，F-con表示conditional form。

模型：

`$$y_{ijkln}=\mu+Pop_{i}+Sex_{j}+Tank_{k}+Sex_{i}×Tank_{k}+\\
Tbw_{l}(Sex_{i}×Tank_{k})+e_{ijkln}$$`

ASReml代码：

```
!PATH 1 #估计固定效应的显著性
!cycle 3 6 7 8
Input2014/growthG$I.csv !SKIP 1 !MAXIT 150 !EXTRA 5 !MVINCLUDE !SUM
TABULATE HarvestBW StockingMeanBW !stats ~ FamilyClass
!DDF
HarvestBW ~ mu  FamilyClass Sex TankID Sex.TankID Sex.TankID.StockingMeanBW
```
ASreml输出的结果文件.asr中的LogL值的结果（8的结果）：
```
 Univariate analysis of HarvestBW                                       
 Summary of 11989 records retained of 11989 read
  Warning: Fewer levels found in AnimalID  than specified
  Warning: Fewer levels found in SireID  than specified
  Warning: Fewer levels found in DamID  than specified
  Warning: Fewer levels found in Generation  than specified
 Forming       16 equations:  16 dense.
 Initial updates will be shrunk by factor    0.316
 Notice: LogL values are reported relative to a base of -30000.000    
 Notice: 6 singularities detected in design matrix.
   1 LogL=-4887.55     S2=  123.83      11979 df 
   2 LogL=-4887.55     S2=  123.83      11979 df 
   3 LogL=-4887.55     S2=  123.83      11979 df 
   4 LogL=-4887.55     S2=  123.83      11979 df 
   5 LogL=-4887.55     S2=  123.83      11979 df 
   6 LogL=-4887.55     S2=  123.83      11979 df 
```

ASreml输出的结果文件.asr中的Wald F检验结果：所有固定效应及其交互效应都是显著的。

因此需要将他们都包括在分析模型中。

```
                                   Wald F statistics
     Source of Variation           NumDF     DenDF    F-inc            P-inc
  14 mu                                1   11979.0 0.18E+06            <.001
   7 FamilyClass                       2   11979.0    47.90            <.001

   5 Sex                               1   11979.0  8420.41            <.001
   6 TankID                            1   11979.0   803.90            <.001
  15 Sex.TankID                        1   11979.0    32.54            <.001
  17 Sex.TankID.StockingMeanBW         4   11979.0   321.53            <.001
```

## 2.2 随机效应
每个群体中包括数量不等的家系，为了去除群体内家系结构的差异，需要把家系作为随机效应去除掉。
模型：

`$$y_{ijkln}=\mu+Pop_{i}+Sex_{j}+Tank_{k}+Sex_{i}×Tank_{k}+\\
Tbw_{l}(Sex_{i}×Tank_{k})+Fam_{l}(Pop_{i})+e_{ijkln}$$`

ASReml代码

```
!PATH 2 # PATH 1中模型的结果表明，所有的固定效应和协变量都是显著的，进一步加入家系效应,作为随机效应
!cycle 3 6 7 8
Input2014/growthG$I.csv !SKIP 1 !MAXIT 150 !EXTRA 5 !MVINCLUDE !SUM
TABULATE HarvestBW StockingMeanBW !stats ~ FamilyClass
!DDF
HarvestBW ~ mu  FamilyClass Sex TankID Sex.TankID Sex.TankID.StockingMeanBW,
           !r FamilyClass.FamilyID
```

LogL值：`LogL=-4573.14`，大于2.1部分`LogL=-4887.55`，因此需要将全同胞家系组效应作为随机效应保留在分析模型中。

```
 Univariate analysis of HarvestBW                                       
 Summary of 11989 records retained of 11989 read
  Warning: Fewer levels found in AnimalID  than specified
  Warning: Fewer levels found in SireID  than specified
  Warning: Fewer levels found in DamID  than specified
  Warning: Fewer levels found in Generation  than specified
 QUALIFIERS: predict FamilyClass !TDIFF 
 Forming      388 equations:  16 dense.
 Initial updates will be shrunk by factor    0.316
 Notice: LogL values are reported relative to a base of -30000.000    
 Notice: 6 singularities detected in design matrix.
   1 LogL=-4573.86     S2=  114.78      11979 df   0.1000    
   2 LogL=-4573.45     S2=  114.84      11979 df   0.9397E-01
   3 LogL=-4573.19     S2=  114.90      11979 df   0.8755E-01
   4 LogL=-4573.14     S2=  114.95      11979 df   0.8345E-01
   5 LogL=-4573.14     S2=  114.95      11979 df   0.8358E-01
   6 LogL=-4573.14     S2=  114.95      11979 df   0.8358E-01
   7 LogL=-4573.14     S2=  114.95      11979 df   0.8358E-01
   8 LogL=-4573.14     S2=  114.95      11979 df   0.8358E-01
   9 LogL=-4573.14     S2=  114.95      11979 df   0.8358E-01
  10 LogL=-4573.14     S2=  114.95      11979 df   0.8358E-01
 Final parameter values                        0.8358E-01
```

Wald F检验

```
                                   Wald F statistics
     Source of Variation           NumDF     DenDF    F-inc            P-inc
  14 mu                                1     119.0 20904.91            <.001
   7 FamilyClass                       2     118.2     5.15            0.007

   5 Sex                               1   11922.3  8887.92            <.001
   6 TankID                            1   11912.6   795.62            <.001
  15 Sex.TankID                        1   11891.1    37.25            <.001
  17 Sex.TankID.StockingMeanBW         4     898.5   145.53            <.001
```

## 2.3 模型中进一步考虑平滑样本曲线
在模型分析中，通过初始体重变量对收获体重进行校正。由于不同群体的初始体重，可能会存在一个较大的差别，不同初始体重，生长速度存在不同，因此用三次平滑样本曲线，可以更加精确地对结果进行校正。
ASReml代码：通过spl()函数来实现上述功能。

```
!PATH 3 #在PATH 2的基础上，进一步加入spl(StockingMeanBW)随机效应
!cycle 3 6 7 8
Input2014/growthG$I.csv !SKIP 1 !MAXIT 150 !EXTRA 5 !MVINCLUDE !SUM
TABULATE HarvestBW StockingMeanBW !stats ~ FamilyClass
!DDF
HarvestBW ~ mu  FamilyClass Sex TankID Sex.TankID Sex.TankID.StockingMeanBW,
            !r FamilyClass.FamilyID Sex.TankID.spl(StockingMeanBW)
```
LogL值：与2.2 `LogL=-4573.14`相比，本次`LogL=-4526.67`，更大，且似然比检验明显会达到显著水平。因此在模型中应该加入spl函数对收获体重进行校正。

```
   1 LogL=-4592.74     S2=  112.75      11979 df    :   1 components restrained
   2 LogL=-4549.23     S2=  113.53      11979 df    :   1 components restrained
   3 LogL=-4527.87     S2=  114.01      11979 df   0.4000E-03 0.5931E-01
   4 LogL=-4526.87     S2=  114.20      11979 df   0.1467E-03 0.5565E-01
   5 LogL=-4526.68     S2=  114.17      11979 df   0.1847E-03 0.5548E-01
   6 LogL=-4526.67     S2=  114.16      11979 df   0.1960E-03 0.5523E-01
   7 LogL=-4526.67     S2=  114.16      11979 df   0.1972E-03 0.5517E-01
   8 LogL=-4526.67     S2=  114.16      11979 df   0.1973E-03 0.5516E-01
   9 LogL=-4526.67     S2=  114.16      11979 df   0.1973E-03 0.5516E-01
  10 LogL=-4526.67     S2=  114.16      11979 df   0.1973E-03 0.5516E-01
  11 LogL=-4526.67     S2=  114.16      11979 df   0.1973E-03 0.5516E-01
 Final parameter values                        0.1973E-03 0.5516E-01
```
Wald F 检验，所有固定效应和协变量均达到极显著水平。

在分析过程中，存在一种情况，模型中只包括固定效应时，各种效应的Wald F检验达到显著或极显著水平。  
但是加入**随机效应**后，原先的固定效应可能会**不再显著**。  
在这种情况下，**以没有包括随机效应的模型拟合结果为准，固定效应保留。**

```
                                   Wald F statistics
     Source of Variation           NumDF     DenDF    F-inc            P-inc
  14 mu                                1     126.6 19176.67            <.001
   7 FamilyClass                       2     115.0     8.89            <.001

   5 Sex                               1    2074.6  4361.97            <.001
   6 TankID                            1    2162.5   488.94            <.001
  15 Sex.TankID                        1    2162.0    15.08            <.001
  17 Sex.TankID.StockingMeanBW         4     170.1    17.27            <.001
```

## 2.4 最小二乘均值
```
predict FamilyClass !TDIFF
```
上述语句放在模型语句后边，ASReml生成一个.pvs文件，包括三个群体的最小二乘均值:
```
 Predicted values of HarvestBW                                       
 Model terms involving  StockingMeanBW  are predicted at the average:       1.3630
 The SIMPLE averaging set:  TankID Sex 
 The ignored set: FamilyID 

 FamilyClass     Predicted_Value Standard_Error Ecode
 SPWP                    46.0236         0.7740 E
 SP                      46.8604         0.3769 E
 WP                      43.7606         0.8069 E
 SED: Standard Error of Difference: Min      0.7881    Mean      0.8848    Max      1.0546 

 Predicted values with t statistics
   46.02    
   46.86       1.06
   43.76      -2.15  -3.82
```
`!TDIFF`限定符，给出了最小二乘均值的T统计检验值。在ASReml-R中，提供了`predict()`函数解析`asreml()`计算出的模型结果，计算最小二乘均值。  
对于lsmeans包，提供了`lsmeans()`函数，可以对lme4、nlme等线性混合效应模型包的输出结果进行解析，求解最小二乘均值。

<a id="Searle">Searle</a> SR, Speed FM, Milliken GA (1980). Population marginal means in the linear model: A
alternative to least squares means. The American Statistician, 34(4), 216-221.
