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

* YC 2013世代共计102个家系。由于个体鱼太小无法标记，因此以家系为单位，设置2个池进行BCWD侵染测试；
* 每个家系每个测试池40尾鱼，共计7893尾鱼进行BCWD侵染测试；
* 训练群体：从102个家系中选择50个家系，共计1473尾鱼进行SNP分型；其中25个家系（40尾/家系）与验证群体是全同胞关系；另外25个家系（~20尾/家系），与验证群体之间的遗传联系很弱；
* 验证群体：测试样本由930尾鱼组成,包括25个家系（31-44尾鱼/家系），这些家系与训练群体中的25个家系是一致的；
* 验证群体以家系为基础的BCWD抗性育种值，通过以系谱为基础的BLUP方法利用同一世代 7893尾个体计算得到；验证群体利用GS模型和同一世代数据，也可以得到GEBV。
* 从验证群体中选择193尾个体，交配产生下一世代即YC 2015世代138个后代测试家系(Progeny Testing Familiy, PTF)。对来自138个家系共计9968尾个体进行BCWD抗性测试，计算平均后代表型(Mean progeny phenotype, MPP)。

### BCWD抗性表型
主要有两个性状参数：

* DAYS 存活天数。整个侵染测试21天，记录在测试期内的存活天数。如果21天时还存活的个体，记为21天；
* STATUS 21d测试期后仍然存活的个体，记为2；测试期内死亡的个体记为1；

### SNP 分型平台

* [Rainbow Trout Axiom® 57 K SNP array](#3). 剔除一些不符合期望孟德尔分离的SNP位点（校正Bonferroni到p<0.10）
* 从训练组中剔除了2尾鱼，根据系谱找不到亲本
* 质控后，分型数据集共计有41868个SNP标记

进一步用BLUPF90进行后续质控

* SNP位点的分型检出率大于0.9
* MAF 大于0.05
* 偏离Hardy-Weinberg equilibrium 要小于0.15 ，指期望杂合度与观测杂合度之差
* Parent-progeny pairs were tested for discrepant homozygous SNPs, those SNPS with a conflict rate of more than 1% were discarded
* 质控后获得35,636个SNP

### 系谱为基础的EBV估计
对于验证群体的930尾鱼，利用P-BLUP（pedigree-based BLUP）估计BCWD抗性EBV。这里需要注意，这930尾用于验证的鱼没有BCWD抗性值。利用验证鱼的同胞和旁系（collateral relatives）亲属的数据集，来估计验证鱼的家系育种值。数据集包括前边讲的7893尾（102个家系，其中包括39个半同胞家系组=78个家系+24个非半同胞家系）。

系谱数据集包括7个世代共计32279尾鱼。

建立评估模型时：

* 没有考虑家系组共同环境效应，作者给出的理由是考虑该效应，会导致遗传参数估计值偏低。特别需要指出的是，**由于家系内个体间的差别可以通过亲缘关系来区分，在基因组选择中因此可以不用考虑全同胞家系组的共同环境效应？？**。
* 测试池效应与家系遗传效应可能会重叠，因此也没有放在模型中。
* 作者认为家系平均体重，由于每个家系只有1个值，因此也会跟家系效应类似，混淆，因此也没有放在模型中。

对于阈值性状，在本文中指的是STATUS（binary trait），估计得到的遗传力利用公式进行了转换：      

`$$h^{2}_{observed}=(h^{2}_{liability}i^{2}p)/(1-p)$$`

i指的是相关个体偏离群体均值的平均偏差，p是死亡率的发生率（Incidence）。这个公式有些晦涩难懂。这个公式需要后续再仔细分析。

### 利用贝叶斯变量选择模型估计EBV

利用BayesB方法进行遗传评估，育种分析模型为动物模型（animal model）。需要设定一些参数：

* mixture parameter π是已知的，且π满足条件k ≤ n；n是训练群体鱼的个体数；
* 利用5倍交叉验证对三个π值0.96、0.97和0.98进行了测试，最终选择了0.97，产生最准确的预测值；
* 在BayesB分析中，GENSEL软件应用Gibbs抽样方式；
* 在本研究中，使用210000个蒙特卡洛迭代分析DAYS和STATUS性状，其中最初的10000个samples主要是用作burn-in，丢弃掉；
* 剩下的20万个samples中，每40个sample保留1个，共计保留5000个samples用于分析；
* 利用R包CODA评估MCMC迭代的混合和收敛是否正常？（proper mixing and convergence） ；确保MCMC samples were drawn from the full posterior distribution。

### 利用ssGBLUP方法估计育种值
采用ssGBLUP和wssGBLUP两种方法估计验证群体的GEBV。这里需要注意，验证群体没有进行BCWD抗性测试。在wssGBLUP分析中，在第一次迭代中，每一个SNP的加权值均是1s，这表示所有的SNP都有相同的加权值，也就是标准的ssGBLUP；在接下来的迭代过程中，利用上一个迭代估计得到的SNP效应值和相应的等位基因频率计算个体的SNP方差用作加权值。[需要具体研究一下]

与BayesB方法相比，ssGBLUP也使用了其他没有分型的YC 2013世代6420尾个体的表型数据。

DAYS性状用的是线性模型，STATUS性状用的是阈值模型。利用BLUPF90完成ssGBLUP和sssGBLUP分析。

对于STATUS性状，在执行ssGBLUP和wssGBLUP分析前，先利用贝叶斯分析方法计算出遗传参数，用作先验值。贝叶斯分析的方法，同上。



### EBV和GEBV的预测能力与偏差
EBV和GEBV，也就是加性遗传效应的预测能力，通过中亲（mid-parent）EBV或GEBV（代替个体EBV）与MPP(平均后代性能)之间的相关来表示。之所以没有使用个体的EBV或GEBV，是因为193尾鱼互相交配，产生了138个家系。在农业动物和家禽中，经常采用的一种策略是193尾鱼分别与一个大的随机群体交配，产生后代。如果是这种策略，可以用个体的EBV或GEBV代替。

计算MPP回归到EBV的回归系数，来评估EBV的偏差。GEBV的偏差，也是通过计算MPP回归到GEBV的回归系数。回归系数为1表示，估计的EBV或者GEBV是真实育种值（本文中是MPP）的无偏估计。回归系数与1的差值，表示预测偏差。这可以从回归系数的定义公式中得到解释(y表示MPP，x表示EBV或GEBV）：

`$$\hat{\beta}_{1}=\frac{\sum_{i=1}^{n}(x_{i}-\bar{x})(y_{i}-\bar{y_{i}})}{\sum_{i=1}^{n}(x_{i}-\bar{x})^{2}}$$`

计算回归系数前，STATUS性状的预测EBV和GEBV需要从underlying scale of liability转换到observed scale。利用BLUPF90和GENSEL软件，probit连接函数完成分类数据的分析，EBV和GEBV需要转换为标准正态累计分布函数。

### GS研究设计对GEBV准确性的影响

为了评估样本量、验证群与测试群间的亲缘关系对GEBV预测准确性的影响，设计了体重GS方案，见图2。

![示意图](/post/images/RTGSFig2.webp)。

* 训练群体样本量梯度：500、1000、1500
* 训练群体家系数量梯度：25、50
* 训练群体家系内个体数梯度：20、40
* 训练群体个体时验证群体的全同胞个体所占比例：66%表示训练群体内有66%的个体时验证群体的全同胞；0表示训练群体内没有鱼是验证群体的全同胞

具体5种方案：

* 方案1：训练群体有两个家系组，第一组25个家系，共计979尾个体，每个家系40尾个体，同时每个家系也有同胞个体在验证组中；第二组25个家系，共计494尾个体，每个家系20尾，没有同胞个体在验证组中；
* 方案2：训练群第一组25个家系，每个家系的个体数量减少为20尾，其他同方案1；
* 方案3：与方案1相比，训练群体仅保留第一组25个家系；
* 方案4：与方案2相比，训练群体仅保留第一组25个家系；
* 方案5：与方案1相比，训练群体仅保留第二组家系；

参考文献：      
<a id="1">1</a> Leeds TD, Silverstein JT, Weber GM, Vallejo RL, Palti Y, Rexroad CE, et al. Response to selection for bacterial cold water disease resistance in rainbow trout. J Anim Sci.
2010;88:1936–46.      
<a id="2">2</a> Silverstein JT, Vallejo RL, Palti Y, Leeds TD, Rexroad CE 3rd, Welch TJ, et al. Rainbow trout resistance to bacterial cold-water disease is moderately heritable and is not adversely correlated with growth. J Anim Sci. 2009;87:860–7.          
<a id="3">3</a> Palti Y, Gao G, Liu S, Kent MP, Lien S, Miller MR, et al. The development and characterization of a 57 K single nucleotide polymorphism array for rainbow trout. Mol Ecol Resour. 2015;15:662–72.