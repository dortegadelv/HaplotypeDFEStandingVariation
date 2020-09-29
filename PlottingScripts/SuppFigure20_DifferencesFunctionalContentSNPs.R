library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)
library(lawstat)

MissenseVariants <- read.table("../Results/FunctionalContent_BValues/ProportionMis.txt")
SynonymousVariants <- read.table("../Results/FunctionalContent_BValues/ProportionSyn.txt")
MissenseVariantsB <- read.table("../Results/FunctionalContent_BValues/B_StatisticMis.txt")
SynonymousVariantsB <- read.table("../Results/FunctionalContent_BValues/B_StatisticSyn.txt")


pdf("../Figures/SuppFigure20_PropMisSyn.pdf",width=18,height=12/2)
par(mfrow=c(1,3))
par(mar=c(5.1,5.1,4.1,1.1))

beanplot(MissenseVariants$V1/500000, SynonymousVariants$V1/500000 ,names=c("Synonymous","Nonsynonymous"), ylab="Percentage of exonic positions",xlab="Type of variants",main="A) Percentage of exonic positions in a 250kb\nregion around the 1% frequency variants",cex.axis=1.7,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,log="",overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5)

beanplot(MissenseVariants$V2/500000, SynonymousVariants$V2/500000 ,names=c("Synonymous","Nonsynonymous"), ylab="Percentage of PhastCons positions",xlab="Type of variants",main="B) Percentage of PhastCons positions in a 250kb\nregion around the 1% frequency variants",cex.axis=1.7,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,log="",overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5)

beanplot(MissenseVariantsB$V3/1000, SynonymousVariantsB$V3/1000 ,names=c("Syn","Mis"),ylab="Average B values",xlab="Type of variants",main="C) Average B values in a 250kb\nregion around the 1% frequency variants",cex.axis=1.7,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,log="",overall=10000,what=c(FALSE,TRUE,FALSE,TRUE),overallline = "median",ll=0.5)

dev.off()

mean(MissenseVariants$V1/500000)
mean(MissenseVariants$V2/500000)
mean(MissenseVariantsB$V3/1000)

mean(SynonymousVariants$V1/500000)
mean(SynonymousVariants$V2/500000)
mean(SynonymousVariantsB$V3/1000)

median(MissenseVariants$V1/500000)
median(MissenseVariants$V2/500000)
median(MissenseVariantsB$V3/1000)

median(SynonymousVariants$V1/500000)
median(SynonymousVariants$V2/500000)
median(SynonymousVariantsB$V3/1000)

var(MissenseVariants$V1/500000)
var(MissenseVariants$V2/500000)
var(MissenseVariantsB$V3/1000)

var(SynonymousVariants$V1/500000)
var(SynonymousVariants$V2/500000)
var(SynonymousVariantsB$V3/1000)

wilcox.test(MissenseVariants$V1,SynonymousVariants$V1)
wilcox.test(MissenseVariants$V2,SynonymousVariants$V2)
wilcox.test(MissenseVariantsB$V3/1000,SynonymousVariantsB$V3/1000)


y <- c(MissenseVariants$V1,SynonymousVariants$V1)
group <- as.factor(c(rep(1, length(MissenseVariants$V1)), rep(2, length(SynonymousVariants$V1))))
levene.test(y,group)


y <- c(MissenseVariants$V2,SynonymousVariants$V2)
group <- as.factor(c(rep(1, length(MissenseVariants$V1)), rep(2, length(SynonymousVariants$V1))))
levene.test(y,group)


y <- c(MissenseVariantsB$V3/1000,SynonymousVariantsB$V3/1000)
group <- as.factor(c(rep(1, length(MissenseVariantsB$V3)), rep(2, length(SynonymousVariantsB$V3))))
levene.test(y,group)

#################################################### Non CpG Sites


MissenseVariants <- read.table("../Results/FunctionalContent_BValues/ProportionMis.txt")
SynonymousVariants <- read.table("../Results/FunctionalContent_BValues/ProportionSyn.txt")
MissenseVariantsB <- read.table("../Results/FunctionalContent_BValues/B_StatisticMis.txt")
SynonymousVariantsB <- read.table("../Results/FunctionalContent_BValues/B_StatisticSyn.txt")
MisPosNonCpG <- read.table("../Results/FunctionalContent_BValues/CpGMisOnePercentNumberPositions.frq")
SynPosNonCpG <- read.table("../Results/FunctionalContent_BValues/CpGSynOnePercentNumberPositions.frq")



pdf("../Figures/SuppFigure20_PropMisSynNotCpG.pdf",width=18,height=12/2)
par(mfrow=c(1,3))
par(mar=c(5.1,5.1,4.1,1.1))

beanplot(MissenseVariants$V1[MisPosNonCpG$V1+1]/500000, SynonymousVariants$V1[SynPosNonCpG$V1+1]/500000 ,names=c("Synonymous","Nonsynonymous"), ylab="Percentage of exonic positions",xlab="Type of variants",main="A) Percentage of exonic positions in a 250kb\nregion around the 1% frequency variants",cex.axis=1.7,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,log="",overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)

beanplot(MissenseVariants$V2[MisPosNonCpG$V1+1]/500000, SynonymousVariants$V2[SynPosNonCpG$V1+1]/500000 ,names=c("Synonymous","Nonsynonymous"), ylab="Percentage of PhastCons positions",xlab="Type of variants",main="B) Percentage of PhastCons positions in a 250kb\nregion around the 1% frequency variants",cex.axis=1.7,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,log="",overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)

beanplot(MissenseVariantsB$V3[MisPosNonCpG$V1+1]/1000, SynonymousVariantsB$V3[SynPosNonCpG$V1+1]/1000 ,names=c("Synonymous","Nonsynonymous"),ylab="Average B values",xlab="Type of variants",main="C) Average B values in a 250kb\nregion around the 1% frequency variants",cex.axis=1.7,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,log="",overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)

dev.off()

mean(MissenseVariants$V1[MisPosNonCpG$V1+1]/500000)
mean(MissenseVariants$V2[MisPosNonCpG$V1+1]/500000)
mean(MissenseVariantsB$V3[MisPosNonCpG$V1+1]/1000)

mean(SynonymousVariants$V1[SynPosNonCpG$V1+1]/500000)
mean(SynonymousVariants$V2[SynPosNonCpG$V1+1]/500000)
mean(SynonymousVariantsB$V3[SynPosNonCpG$V1+1]/1000)

median(MissenseVariants$V1[MisPosNonCpG$V1+1]/500000)
median(MissenseVariants$V2[MisPosNonCpG$V1+1]/500000)
median(MissenseVariantsB$V3[MisPosNonCpG$V1+1]/1000)

median(SynonymousVariants$V1[SynPosNonCpG$V1+1]/500000)
median(SynonymousVariants$V2[SynPosNonCpG$V1+1]/500000)
median(SynonymousVariantsB$V3[SynPosNonCpG$V1+1]/1000)

var(MissenseVariants$V1[MisPosNonCpG$V1+1]/500000)
var(MissenseVariants$V2[MisPosNonCpG$V1+1]/500000)
var(MissenseVariantsB$V3[MisPosNonCpG$V1+1]/1000)

var(SynonymousVariants$V1[SynPosNonCpG$V1+1]/500000)
var(SynonymousVariants$V2[SynPosNonCpG$V1+1]/500000)
var(SynonymousVariantsB$V3[SynPosNonCpG$V1+1]/1000)

wilcox.test(MissenseVariants$V1[MisPosNonCpG$V1+1],SynonymousVariants$V1[SynPosNonCpG$V1+1])
wilcox.test(MissenseVariants$V2[MisPosNonCpG$V1+1],SynonymousVariants$V2[SynPosNonCpG$V1+1])
wilcox.test(MissenseVariantsB$V3[MisPosNonCpG$V1+1]/1000,SynonymousVariantsB$V3[SynPosNonCpG$V1+1]/1000)


y <- c(MissenseVariants$V1[MisPosNonCpG$V1+1],SynonymousVariants$V1[SynPosNonCpG$V1+1])
group <- as.factor(c(rep(1, length(MissenseVariants$V1[MisPosNonCpG$V1+1])), rep(2, length(SynonymousVariants$V1[SynPosNonCpG$V1+1]))))
levene.test(y,group)


y <- c(MissenseVariants$V2[MisPosNonCpG$V1+1],SynonymousVariants$V2[SynPosNonCpG$V1+1])
group <- as.factor(c(rep(1, length(MissenseVariants$V1[MisPosNonCpG$V1+1])), rep(2, length(SynonymousVariants$V1[SynPosNonCpG$V1+1]))))
levene.test(y,group)


y <- c(MissenseVariantsB$V3[MisPosNonCpG$V1+1]/1000,SynonymousVariantsB$V3[SynPosNonCpG$V1+1]/1000)
group <- as.factor(c(rep(1, length(MissenseVariantsB$V3[MisPosNonCpG$V1+1])), rep(2, length(SynonymousVariantsB$V3[SynPosNonCpG$V1+1]))))
levene.test(y,group)



