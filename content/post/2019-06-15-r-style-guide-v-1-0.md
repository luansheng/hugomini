---
title: R 语言编码规范 V 1.0
author: Sheng Luan
date: '2019-06-15'
slug: r-style-guide-v-1-0
categories:
  - R
tags:
  - R
---

## 一、符号和命名 (Notation and Naming)

### 1. 文件命名
#### 1.1 脚本文件名
以大写缩写或者小写全拼（首字母大写）命名, 扩展名以 .R（大写）结尾. 不要用中文命名. 也不要用下划线(_)或连字符(-)分割.    
考虑到在windows和linux平台下的通用性，R文件的内容应该存为utf-8格式.     
正确: QC.R; QualityControl.R     
错误: qc.R; Quality_Control.R  

#### 1.2 数据文件名
主要包括系谱文件和数据文件,格式为文本文件. 文本文件用记事本就可以打开.     
命名方法同上，扩展名为.csv. csv格式文件内容通过英文逗号(,)分割. 初次整理数据, 可以通过Excel等软件，另存为csv格式.     
后续在数据处理过程中可以通过data.table包中的fwrite函数存储为csv格式.     
正确: GFP2018G02GrowthData.csv; GFP2018G02GrowthPed.csv;     
分别表示罗氏沼虾（GFP）2018年G02代生长数据和系谱.     
错误: gfp_2018G02_growthData.csv.      
其他文件如加性遗传相关矩阵及其逆矩阵，扩展名通常分别为.grm和.giv格式.      
文件内容通常为3列稀疏矩阵格式，列间通过空格分隔.     
正确: GFP2018G02GrowthData.grm; GFP2018G02GrowthData.giv

### 2. 变量名：
以小写命名，'_' 分隔单词. 变量最后加一个后缀，表示变量的类型. 

- s 表示数值scalar，即长度为1的向量;如x_s <- 2;
- v 表示向量vector; R中向量是基本单位, 如 a_v <- c(1, 2, 3, 18)，要求 a_v的长度要大于1;
- l 表示列表list;
- m 表示矩阵matrix;
- a 表示数组array;
- df 表示数据框data frame;
- dt 表示data.table包专有的数据框格式data.table; 

因为R中类型的转换非常的方便和频繁，加入标识变量类型的后缀，我们可以更加清楚该用何种函数和方法处理该类型数据. 有时候，如果函数读入的数据类型不对, 会造成R进程崩溃.    
正确: sample_number_v 表示该变量是一个向量;    
正确: raw_geno_dt 表示该变量是一个data.table类型的数据框;    
正确: geno_012_m 表示该变量是一个矩阵类型;    
错误: samplenumber; sample.number; raw_geno;    
需要明确的另外一个规范是, data frame和data.table数据框中列名的命名:

采用缩写大写或首字母大写方式, 主要不要用下划线分割.    
正确: AnimalID; SireID; FamilyID;  HarvestBW;    
错误: animal_ID; sireid; damid; family_ID;    

### 3. 函数名
小写单词直接连在一次，不要使用 '.', '_', '-'等符号分隔，使用动词性短语.    
正确: numped; sortped; visped; checkped;   
错误: num_ped; sort-ped; VisPed; check_ped;     

## 二、 语法
### 1. 赋值
通常使用 '<-' 赋值, 而不是 '='.

### 2. 单行最大长度 
通常控制在88 个字符.

### 3. 缩进
通常是2个空格，不要使用制表符 (tabs) 或混合制表符和空格;    
括号内发生换行时，使其与括号内的第一个字符对齐;

### 4. 间距
所有 ',' 后空一格;    
二进制运算符 (如=,+,-,<,等) 两侧各空一格;    
正确: sample_num <- 215    
错误: sample_num<-215    
在左括号之前添加一个空格，函数调用时除外;    
正确: if (!is.character(geno_012_dt$IID))    
错误: if(!is.character(geno_012_dt$IID))    

### 5. 花括号 
右括弧应独立成行;    
括号内代码块新起一行写.    
正确:    
```r
if (!is.character(geno_012_dt$IID)) {
  geno_012_dt[, IID := as.character(IID)]
} 
```

else语句应该总是被花括号包围在同一行    
正确:    
```r
if (is.null(attributes(ped)$tidyped)) {
  stop("The pedigree need to be firstly trimmed by the tidyped() function!")
} else {
  if (!attr(ped,"tidyped")) {
   stop("The pedigree need to be firstly trimmed by the tidyped() function!")
  }
} 
```

**整体代码格式, 使用Rstudio软件中Code菜单中的"Reindent Lines"和"Reformat Code"功能进行整理.** 

## 三、代码结构
### 1. 总体布局和排序
(1) 版权声明注释    
(2) 作者信息    
(3) 文件描述，包括程序的目的、输入和输出    
(4) source() 和 library() 语句    
(5) 函数定义    
(6) 执行语句    

例如：    
```r
#================================================================================================
# 格式: utf-8
# 版权:  MIT + file LICENSE
# 作者：栾生, luansheng@ysfri.ac.cn
# 功能: 读取个体的SNP分型信息, 生成plink软件需要的ped和map文件，进行质控分析，输出文件.
#================================================================================================
```
### 2. 代码注释
- 注释以 '#' 后接一个空格开始
- 简短的注释可以放置在行尾，用2个空格隔开
- 较长的注释可以单独一行

整体代码示例：    
```r
#===Setup========================================================================================
# 请用Rstudio运行本程序. 运行程序前, 请依次点击Session菜单-> "Set working directory" -> 
# "To Source File Location", 把工作目录设定为R脚本所在路径.
rm(list = ls())
#加载data.table和xfun两个包
require(data.table)
require(xfun)

#===生成plink需要的ped和map文件================================================================
# 提供的输入文件包括215尾个体的分型信息, 第一行存储样本名称,从第5列开始是样本的名称;
# 第一列存储SNP位点名称
# 设置header参数为TRUE, 将从第一行中读取样本名字
# 在文件中,缺失的分型信息用--表示
raw_geno_dt <- fread(
  input = "../Data/GFP2017G01Ind215Geno.csv",
  sep = "\t",
  header = TRUE,
  stringsAsFactors = FALSE,
  na.strings = "--",
  data.table = TRUE
)

# 查看raw_geno_dt内容
print(raw_geno_dt)
# 查看行列数
dim(raw_geno_dt)

# 样本数
sample_num_v <- 215
# 位点数
snp_loci_num_v <- 124987

# 获取GFP2017G01Ind215Geno.csv文件中的行数, 大于等于SNP位点数
raw_row_num_v <- nrow(raw_geno_dt)
# 获取GFP2017G01Ind215Geno.csv文件中的列数, 大于分型个体数
raw_col_num_v <- ncol(raw_geno_dt)
# 获取SNP位点的名称
snp_loci_names_v <- raw_geno_dt$Ref_ID
# 获取样本的名称
sample_names_v <-
  colnames(raw_geno_dt)[(raw_col_num_v - sample_num_v + 1):raw_col_num_v]

# 利用data.table函数transpose进行行列转置
# 转置后,pure_geno_dt仅包括分型信息,每一行为一尾个体snp_loci_num_v个位点的分型信息
pure_geno_dt <-
  transpose(raw_geno_dt[(raw_row_num_v - snp_loci_num_v + 1):raw_row_num_v,
                        (raw_col_num_v - sample_num_v + 1):raw_col_num_v])
```
