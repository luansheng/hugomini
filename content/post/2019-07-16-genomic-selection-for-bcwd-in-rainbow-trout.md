---
title: 虹鳟细菌性冷水病抗性基因组选择模型的预测准确度是以传统系谱为基础的模型的2倍
author: Sheng Luan
date: '2019-07-16'
slug: genomic-selection-for-bcwd-in-rainbow-trout
categories:
  - 文献阅读
tags:
  - 选择育种
  - GS
---

文章阅读笔记：[Genomic selection models double the accuracy of predicted breeding values for bacterial cold water disease resistance compared to a traditional pedigree-based model in rainbow trout aquaculture]
(https://gsejournal.biomedcentral.com/articles/10.1186/s12711-017-0293-6)

## 前言
虹鳟细菌性冷水病（Bacterial cold water disease，BCWD）可导致卵黄囊期仔鱼大批量死亡，致死率可达50%。BCWD属于复杂性状，研究已经找到了数量性状位点。

GS在水产中特别适合宰杀性状、性别连锁性状、疾病抗性等。而且水产动物应用GS的一个优势：**对于不能在候选个体上直接测量的性状，GS可以替代同胞选择，充分的利用家系内变异**。

GBLUP假定性状为多基因结构，即所有的分型标记效应相同，用于构建基因组亲缘关系G矩阵。与之相反，贝叶斯变量选择模型（Bayesian variable selection model）假定性状的遗传方差可通过部分标记解释。**如果性状受几个具有中高效应值的QTL控制，那么贝叶斯模型的预能力将会好于GBLUP**。GBLUP方法进一步可以扩展为ssGBLUP方法，同时利用系谱和基因组亲缘关系。wssGBLUP方法则是模仿贝叶斯方法，在模型中拟合可解释性状遗传方差的SNP位点。

性状的遗传结构和群体的结构对于基因组预测的准确性具有重要意义。因此，初次开展GS选择评估时，评估不同GS模型的预测能力，并与系谱基础的模型进行对比分析，是非常重要的。

最近的发表一篇关于虹鳟BCWD的GS研究，同样是由NCCCWA（National Center for Cool and Cold Water Aquaculture, Agricultureal Research Service, Unite States)完成的实验，表明GS模型并不能提高预测的准确度。作者认为，主要原因是训练群体样本数较小、验证群体家系样本不平衡等原因造成的。本文与之相比，样本数更大，交配设计更加平衡，家系数量更多。

本文的主要目的：

* 在一个以生长为主育种目标性状的商业育种群体中预测BCWD的GEBV
* 利用后裔测定数据，比较三个GS模型的GEBV与系谱基础的EBV的准确性
* 利用不同的抽样方案，评价不同的实验设计在提高基因组预测准确性上的作用

## 材料与方法
### 鱼类个体养殖和疾病侵染测试
鱼的养殖和BCWD 21天存活实验的细节在[其他文献1](#1)、[文献2](#2)中报道了。

### 训练和验证数据（Testing samples）

本文中一个特殊的地方，验证群体也就是testing samples，并没有进行BCWD细菌侵染测试。因为进行了BCWD侵染测试的个体，从生物安保的角度，不可能再用于产生后代。因此，YC 2013世代testing samples的BCWD抗性数据，是通过后裔即YC 2015世代测定获得的。

训练和验证数据集见下图。

![示意图](/post/images/RTGSFig1.gif)。

* YC 2013世代共计102个家系，在两个池塘中测试；
* 每个家系每个测试池40尾鱼，共计7893尾鱼进行BCWD侵染测试；
* 训练群体：从102个家系中选择50个家系，共计1473尾鱼进行SNP分型；其中25个家系（40尾/家系）与验证群体是全同胞关系；另外25个家系（~20尾/家系），与testing samples之间的遗传联系很弱；
* 验证群体：测试样本由930尾鱼组成,包括25个家系（31-44尾鱼/家系），这些家系与训练群体中的25个家系是一致的；
* 验证群体以家系为基础的BCWD抗性育种值，通过以系谱为基础的BLUP方法利用同一世代 7893尾个体计算得到；验证群体利用GS模型和同一世代数据，也可以得到GEBV。
* 从验证群体中选择193尾个体，交配产生下一世代即YC 2015世代138个后代测试家系(Progeny Testing Familiy, PTF)。来自138个家系共计9968尾个体进行BCWD抗性测试，计算平均后代表型(Mean progeny phenotype, MPP)

参考文献：      
<a id="1">1</a> Leeds TD, Silverstein JT, Weber GM, Vallejo RL, Palti Y, Rexroad CE, et al. Response to selection for bacterial cold water disease resistance in rainbow trout. J Anim Sci.
2010;88:1936–46.      
<a id="2">2</a> Silverstein JT, Vallejo RL, Palti Y, Leeds TD, Rexroad CE 3rd, Welch TJ, et al. Rainbow trout resistance to bacterial cold-water disease is moderately heritable and is not adversely correlated with growth. J Anim Sci. 2009;87:860–7.