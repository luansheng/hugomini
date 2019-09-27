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

GS在水产中特别适合宰杀性状、性别连锁性状(只有可以分辨性别时，才可以测量性状）、疾病抗性等。而且水产动物应用GS的一个优势：**对于不能在候选个体上直接测量的性状，GS可以替代同胞选择，充分的利用家系内变异**。

GBLUP假定性状为多基因(polygenic)结构，即所有的分型标记效应相同，用于构建基因组亲缘关系G矩阵。与之相反，贝叶斯变量选择模型（Bayesian variable selection model）假定性状的遗传方差可通过部分标记解释。**如果性状受几个具有中高效应值的QTL控制，那么贝叶斯模型的预能力将会好于GBLUP**。GBLUP方法进一步可以扩展为ssGBLUP方法，同时利用系谱和基因组亲缘关系。wssGBLUP方法则是模仿贝叶斯方法，在模型中拟合可解释性状遗传方差的SNP位点。

性状的遗传结构和群体的结构对于基因组预测的准确性具有重要意义。因此，初次开展GS选择评估时，评估不同GS模型的预测能力，并与系谱基础的模型进行对比分析，是非常重要的。

最近的发表一篇关于[虹鳟BCWD的GS研究](#rt2016)，同样是由NCCCWA（National Center for Cool and Cold Water Aquaculture, Agricultureal Research Service, Unite States)完成的实验，表明GS模型并不能提高预测的准确度。作者认为，主要原因是训练群体样本数较小、验证群体家系样本不平衡等原因造成的。本文与之相比，样本数更大，交配设计更加平衡，家系数量更多。

本文的主要目的：

* 在一个以生长为主育种目标性状的商业育种群体中预测BCWD抗性的GEBV
* 利用后裔测定数据，比较三个GS模型的GEBV与系谱基础的EBV的准确性
* 利用不同的抽样方案，评价不同的实验设计在提高基因组预测准确性上的作用

## 材料与方法
### 鱼类个体养殖和疾病侵染测试
鱼的养殖和BCWD 21天存活实验的细节在[其他文献1](#1)、[文献2](#2)中报道了。

### 训练（Training samples）和验证数据（Testing samples）

本文中一个特殊的地方，验证群体也就是testing samples，并不是同时进行高通量分型和BCWD抗性测试的个体。验证群体选择了YC 2015世代家系的亲本，亲本个体进行了高通量SNP分型，但并没有进行BCWD细菌侵染测试。因为从生物安保的角度，进行了BCWD侵染测试的个体，不可能再用于产生后代。因此，YC 2013世代验证群体（YC 2015家系的亲本）的BCWD抗性数据，是通过后裔即YC 2015世代测定获得的。

训练和验证数据集见下图。
<div align="center">
<img src="/post/images/RTGSFig1.gif"  alt="训练和验证数据集" height= "380" width="100%" >
</div>


* 从YC 2013世代选择102个家系，用于进行BCWD抗性测试。
* 由于个体鱼太小无法标记，因此以家系为单位，每个家系设置2个平行进行BCWD侵染测试。
* 每个家系每个测试池40尾鱼，共计7893尾鱼进行BCWD侵染测试。
* 训练群体：从102个家系中选择50个家系，共计1473尾鱼进行SNP分型；其中25个家系（40尾/家系）与验证群体是全同胞关系；另外25个家系（~20尾/家系），与验证群体之间的遗传联系很弱。
* 验证群体：测试样本由930尾鱼组成,包括25个家系（31-44尾鱼/家系），这些家系与训练群体中的25个家系是一致的。
* 验证群体以家系为基础的BCWD抗性育种值，通过以系谱为基础的BLUP方法利用同一世代 7893尾个体计算得到；验证群体利用GS模型和同一世代数据，也可以得到GEBV。
* 从验证群体中选择193尾个体，交配产生下一世代即YC 2015世代138个后代测试家系(Progeny Testing Familiy, PTF)。对来自138个家系共计9968尾个体进行BCWD抗性测试，计算平均后代表型(Mean progeny phenotype, MPP)。

### BCWD抗性表型
主要有两个性状参数：

* **DAYS**-存活天数。整个侵染测试21天，记录在测试期内的存活天数。如果21天时还存活的个体，记为21天。
* **STATUS**：21d测试期后仍然存活的个体，记为2；测试期内死亡的个体记为1。

### SNP 分型平台

* [Rainbow Trout Axiom® 57 K SNP array](#3). 剔除一些不符合期望孟德尔分离的SNP位点（校正Bonferroni到p<0.10）。
* 从训练组中剔除了2尾鱼，根据系谱找不到亲本。
* 质控后，分型数据集共计有41868个SNP标记。

进一步用BLUPF90进行后续质控：

* SNP位点的分型检出率大于0.9；
* MAF 大于0.05；
* 偏离Hardy-Weinberg equilibrium 要小于0.15 ，指期望杂合度与观测杂合度之差；
* Parent-progeny pairs were tested for discrepant homozygous SNPs, those SNPS with a conflict rate of more than 1% were discarded；
* 质控后获得35,636个SNP。

### 系谱为基础的EBV估计
对于验证群体的930尾鱼，利用P-BLUP（pedigree-based BLUP）估计BCWD抗性EBV。这里需要注意，这930尾用于验证的鱼没有BCWD抗性值。利用验证鱼的同胞和旁系（collateral relatives）亲属的数据集，来估计验证鱼的家系育种值。数据集包括前边讲的7893尾（102个家系，其中包括39个半同胞家系组=78个家系+24个非半同胞家系）。

系谱数据集包括7个世代共计32279尾鱼。

建立评估模型时：

* 没有考虑家系组共同环境效应，作者给出的理由是考虑该效应，会导致遗传参数估计值偏低。特别需要指出的是，**由于家系内个体间的差别可以通过亲缘关系来区分，在基因组选择中因此可以不用考虑全同胞家系组的共同环境效应？？**。
* 测试池效应与家系遗传效应可能会重叠，因此也没有放在模型中。
* 作者认为家系平均体重，由于每个家系只有1个值，因此也会跟家系效应混淆，因此也没有放在模型中。

对于阈值性状，在本文中指的是STATUS（binary trait），估计得到的遗传力利用公式进行了转换：      

`$$h^{2}_{observed}=(h^{2}_{liability}i^{2}p)/(1-p)$$`

i指的是相关个体偏离群体均值的平均偏差，p是死亡率的发生率（Incidence）。从后边来看，用的也是阈值模型和probit连接函数!!!???这个公式有些晦涩难懂。这个公式需要后续再仔细分析。

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

计算MPP回归到EBV的回归系数，作为EBV的偏差。GEBV的偏差，也是指MPP回归到GEBV的回归系数。回归系数为1表示，估计的EBV或者GEBV是真实育种值（本文中是MPP）的无偏估计。回归系数与1的差值，可以表示预测偏差。这可以从回归系数的定义公式中得到解释(y表示MPP，x表示EBV或GEBV）：

`$$\hat{\beta}_{1}=\frac{\sum_{i=1}^{n}(x_{i}-\bar{x})(y_{i}-\bar{y_{i}})}{\sum_{i=1}^{n}(x_{i}-\bar{x})^{2}}$$`

计算回归系数前，STATUS性状的预测EBV和GEBV需要从underlying scale of liability转换到observed scale。利用BLUPF90和GENSEL软件，probit连接函数完成分类数据的分析，EBV和GEBV需要转换为标准正态累计分布函数。

### GS研究设计对GEBV准确性的影响
为了评估样本量、验证群与测试群间的亲缘关系对GEBV预测准确性的影响，设计了体重GS方案，见图2。

<div align="center">
<img src="/post/images/RTGSFig2.webp"  alt="评价GS设计方案对GEBV准确性的影响" height= "380" width="100%" >
</div>

* 训练群体样本量梯度：500、1000、1500；
* 训练群体家系数量梯度：25、50；
* 训练群体家系内个体数梯度：20、40；
* 训练群体个体是验证群体的全同胞个体所占比例：66%表示训练群体内有66%的个体是验证群体的全同胞；0表示训练群体内没有鱼是验证群体的全同胞。

具体5种方案：

* 方案1：训练群体有两个家系组，第一组25个家系，共计979尾个体，每个家系40尾个体，同时每个家系也有同胞个体在验证组中；第二组25个家系，共计494尾个体，每个家系20尾，没有同胞个体在验证组中；
* 方案2：训练群第一组25个家系，每个家系的个体数量减少为20尾，其他同方案1；
* 方案3：与方案1相比，训练群体仅保留第一组25个家系；
* 方案4：与方案2相比，训练群体仅保留第一组25个家系；
* 方案5：与方案1相比，训练群体仅保留第二组家系。

评估GS实验设计对GEBV准确性的影响时，用的是基于BayesB方法估计获得的GEBV，因为该方法获得的GEBV准确性最高。

## 结果
### 平均后代表型和中亲EBV或者GEBV
对于反应BCWD抗性的DAYS和STATUS两个性状，基于138个后代测试家系（PTF）数据计算出平均后代表型MPP、中亲EBV和GEBV。结算结果在附件[Table S1](https://static-content.springer.com/esm/art%3A10.1186%2Fs12711-017-0293-6/MediaObjects/12711_2017_293_MOESM1_ESM.xlsx)中。其中对于中亲GEBV，列出了ssGBLUP、wssGBLUP、wssGBLUP2和wssGBLUP3等多种方法的计算结果。

### BCWD抗性的遗传力
利用P-BLUP模型，获得DAYS和STATUS性状的遗传力分别为0.37和0.35。利用不同的GS模型，获得DAYS的遗传力在0.23-0.33，STAUTS性状的遗传力在0.25-0.35。结果见表1和表2。

### EBV的准确性和偏差
对于DAYS和STATUS，EBV的准确性分别为0.34和0.36。前者低于后者。预测能力是通过计算MPP与中亲EBV的相关系数得到的。这两个性状的偏差分别为0.86和0.67。由于偏差使用回归系数表示的，DAYS的回归系数更大，更接近1，意味着它的偏差小。

### GEBV的准确性和偏差
对于DAYS性状，不同GEBV模型的准确性在0.63-0.71之间，BayesB模型的预测能力最强。预测偏差在0.65-1.16之间，ssGBLUP方法的预测值，偏差最小。

对于STATUS性状，不同GEBV模型的准确性在0.66-0.71之间，BayesB模型的预测能力最强。预测偏差在0.64-1.01之间，BayesB方法的预测值，偏差最小。

总体而言，利用各种GS模型获得的STATUS性状的预测准确性要高于DAYS性状，趋势与P-BLUP是一致的。但是DAYS性状的预测偏差要小于STATUS性状。

### EBV和GEBV准确性比较
对于DAYS和STATUS性状，预测准确性最高的是BayesB方法，与P-BLUP相比，提高了108.8%和97.2%。其次wssGBLUP2，然后是wssGBLUP3，最差是ssGBLUP。即便是ssGBLUP，相比P-BLUP，预测能力也分别提高了85.3%和83.3%。

### 五个GS方案GEBV的准确性和偏差
利用BayesB分析了五种GS方案的预测能力。方案1和3预测能力最高（0.69 to 0.72），然后是方案2（0.67），方案4（0.53 to 0.61）和方案5（0.22 to 0.25）。方案5的准确性，甚至低于传统的P-BLUP。

对DAYS性状，利用方案1和3估计的GEBV偏差最小（1.16 and 1.26），利用方案5估计的GEBV偏差最大。对于STATUS性状，方案1偏差最小，方案2和5偏差较大，其中方案5偏差最大。

## 讨论
本文第一次在一个商业有鳍（finfish）鱼类群体中，通过后裔测试的方式，证明了GEBV的准确性要高于系谱为基础的EBV。在其他鱼类群体中，仅仅是通过交叉验证的方式对参考群体评估GEBV的准确性。

利用BayesB获得的DAYS和STATUS性状GEBV的准确性接近（0.71），并且高于ssGBLUP和wssGBLUP。然而，利用ssGBLUP方法获得的STATUS性状GEBV的准确性（0.66-0.70）要高于DAYS性状GEBV的准确性（0.63-0.67）。作者给出的解释有三个：

* 阈值模型可以更好的拟合STATUS；但是对于DAYS性状，实质上是更像分散的分类性状，总共只有21d，利用线性模型不能很好的拟合。
* 对于侵染实验结束时仍然存活的鱼，DAYS性状设定为21d，性状测量的并不准确。
* STATUS的遗传力估计值高于DAYS性状。

对于BCWD性状，如果BCWD性状由超过500个loci控制，那么参考群体为1473，遗传力为0.3，根据这篇文章[Accuracy of Predicting the Genetic Risk of Disease Using a Genome-Wide Approach](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2561058/)推测，预测能力期望可以达到0.68（根据。本文BayesB的预测结果也与此相似。如果假定BCWD性状受超过500个独立的loci控制（少数主效基因和多数为微效多基因），在遗传力为0.3的水平下，当参考群体个体数为3000和10000时，GEBV的期望预测能力可以分别达到0.8和0.93。

在奶牛中，利用大参考群体（欧洲荷斯坦奶牛，参考群超过4000头牛），获得性能产奶量性状的基因组预测的准确性超过0.8，健康相关性状则超过0.7。该群体后裔测试公牛组成，其产奶性能通过平均女儿性能进行准确测定。而本文研究的一个亮点，是基于一个较小的参考群体，获得了一个较高预测准确性。（It was remarkable to have genomic evaluation with an accuracy of 0.71 using a relatively small training dataset)。ps:**群体样本数达到1473，已经很高了，对虾类而言，如果每尾分型成本500元，意味着要花掉70到80万人民币！**本文作者推测，这样一个高选择准确性是由于：

* 参考群和验证群之间的较高的亲缘关系；
* 虹鳟群体的有效群体大小比较小，导致连锁不平衡扩大（entensive linkage disequilibrium），从而需要估计的有效染色体区段效应变少，因此可以更好地预测和更好的准确性。

在混合鲑鳟鱼群体（Admixed salmonid population）中，广泛观察到大范围连锁不平衡(Long-range LD）。

这种高度的大范围连锁不平衡，是由于不同群体在选育过程中不断混合产生的。这种群体混合也会减少小范围连锁不平衡（short-range LD）。遗传分离群体的混合（Admixture of genetically divergent populations）能够显著的提升跨大基因组区域、多世代间的连锁不平衡。由于重组，不连锁基因间由混合产生的LD（ADmixture-generated LD，ALD）会快速衰减（2-4代内），但是连锁基因间的ALD衰减会很慢。**对那些间隔1cM的位点，10代和20代后，仍然分别有90%和82%的ALD保留。**在[大西洋鲑](https://www.frontiersin.org/articles/10.3389/fgene.2014.00402/full)中，利用一个小的训练群体（n=1963），由于存在高度的ALD，同样获得了较高的预测准确性。

参考群体和验证群体的样本数要大于此前GS研究的样本数，因此与此前的研究相比，有一个更好的GEBV预测准确性。在本文研究中，从获得的高预测准确性来看，训练群体和验证群体的样本数可能接近于最优化了。尽管如此（Nonetheless），根据理论预测，继续增加参考群体的样本数到3000甚至100000，预测的准确性将进一步提高。

性状的遗传力对预测GEBV的准确性影响非常大。对于DAYS和STATUS性状，本文基于P-BLUP模型获得的遗传力和通过GS模型利用标记解释的方差组分，与以前报道的BCWD抗性的遗传力非常接近。

### 模型比较

DAYS性状的预测偏差，要小于STATUS性状。作者给出的解释是：通过阈值模型，对二分变量转换为underlying scale水平进行分析，估计出的方差组分偏高，从而造成预测偏差变大。

BCWD抗性通过分析发现是寡基因遗传模式（Oligogenic inheritance），是由少数几个主效QTL和微效多基因/位点共同组成。因此变量选择模型比GS模型具有更高的GEBV估计准确性。在当前的研究中，这也是wssGBLUP2和BayesB方法具有更高的准确性的原因。

总体来讲，**选择什么模型取决于性状的遗传结构**。对于微效多基因结构，GBLUP和ssGBLUP模型好用。对于寡基因结构，BayesB和wssGBLUP模型好用。

### GS试验设计比较

这部分结果特别有意思。方案3比方案1的参考样本数少了494个，但是二者预测GEBV的准确性相当。原因可能是：

 * 方案3的参考群样本与验证群体的亲缘关系要高于方案1的原因。（1.0 vs 0.66）
 * 方案3参考群样本间的亲缘关系也要高于方案1
 
这给我们设计GS方案一个非常重要的启发：**需要根据候选群体，选择跟它亲缘关系最近的个体构建参考群，并且参考群个体间的亲缘关系也要近。**
 
方案3比方案2的准确性要高，也是因为上述原因。

而方案3好于方案4，是因为每个家系的个体数量更多。

方案5的预测准确性最差，是因为该方案参考群与与验证群间的亲缘关非常远，而且样本量也非常小。

两个特别启示：

* 跨群体进行GS评估，譬如参考群体来自一个群体，候选群体来自另外一个群体，效果非常差，GS的准确性会很低；
* 针对不同的世代，参考群体需要更新；


### 附加评论
与畜牧大动物相比，在以规模化家系为基础的水产动物育种体系开展GS研究，最大的挑战在于候选个体（selection candidate）的数量多，并且与分型成本相比，单尾个体价值低。

在抗病性选育项目中，传统的同胞测试方案需要重新设计，以利用GS的优势来提高选择的准确性，增加遗传进展。作者建议：

* 首先利用传统的同胞测试，预选出抗性强的家系
* 从抗性强的家系中选择个体，进行分型，降低分型成本
* 对候选个体（来自预选家系）进行基因分型，预测其GEBV

在畜牧中利用GS的优势，是会增加育种值和选择反应的准确性，但是不会增加甚至降低近交率。









参考文献：      
<a id="1">1</a> Leeds TD, Silverstein JT, Weber GM, Vallejo RL, Palti Y, Rexroad CE, et al. Response to selection for bacterial cold water disease resistance in rainbow trout. J Anim Sci.
2010;88:1936–46.      
<a id="2">2</a> Silverstein JT, Vallejo RL, Palti Y, Leeds TD, Rexroad CE 3rd, Welch TJ, et al. Rainbow trout resistance to bacterial cold-water disease is moderately heritable and is not adversely correlated with growth. J Anim Sci. 2009;87:860–7.          
<a id="3">3</a> Palti Y, Gao G, Liu S, Kent MP, Lien S, Miller MR, et al. The development and characterization of a 57 K single nucleotide polymorphism array for rainbow trout. Mol Ecol Resour. 2015;15:662–72.          
<a id="rt2016">4</a> Vallejo RL, Leeds TD, Fragomeni BO, Gao G, Hernandez AG, Misztal I, et al. Evaluation of genome-enabled selection for bacterial cold water disease resistance using progeny performance data in rainbow trout: insights on genotyping methods and genomic prediction models. Front Genet. 2016;7:96.         
<a id="5">5</a> Jørgen Ødegård1, Thomas Moen, Nina Santi, SvenA. Korsvoll, Sissel Kjøglum1 and Theo H.E. Meuwissen. Genomic prediction in an admixed population of Atlantic salmon (Salmo salar). Front Genet. 2014;5:402.         
