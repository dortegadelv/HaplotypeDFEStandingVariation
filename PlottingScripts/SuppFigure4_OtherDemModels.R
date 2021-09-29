library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

##########

Plot <- paste("../Figures/SuppFigure4_PopExpansionTwoModels.pdf",sep="")

pdf(Plot, width = 7*2, height = 7*2)
par(mfrow=c(2,2), mar=c(5,5,5,2) + 0.1)

### Figure 3

Selection4Ns_0_100Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionYRI0_N10000.txt")
Selection4Ns_50_100Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionYRI50_N10000.txt")
Selection4Ns_100_100Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionYRI100_N10000.txt")
Selection4Ns_Minus50_100Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionYRI-50_N10000.txt")
Selection4Ns_Minus100_100Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionYRI-100_N10000.txt")

Selection4Ns_0_1000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionCEU0_N10000.txt")
Selection4Ns_50_1000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionCEU50_N10000.txt")
Selection4Ns_100_1000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionCEU100_N10000.txt")
Selection4Ns_Minus50_1000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionCEU-50_N10000.txt")
Selection4Ns_Minus100_1000Gens <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionCEU-100_N10000.txt")

PopulationSizes <- c(33000, 99000, 33000, 330000, 330000)
PopulationSizes <- PopulationSizes / 2
Times <- c(264000,10000, 3133, 200 , 200 )
Sums <- c()
CurrentSum <- 0
for (i in 1:length(Times)){
    Sums <- c(Sums,CurrentSum)
    CurrentSum <- CurrentSum + Times[i]
}

plot(Sums,PopulationSizes,type="s",xlim = c(CurrentSum-14000, CurrentSum),ylab="Effective Population Size",xlab="Time before the present",main="A) Demographic Model of Yoruba\nSchiffels and Durbin (2014) Nature Genetics model",xaxt= "n",cex.axis=2,cex.main=1.5,cex.lab=2.5,col="red",lwd=6)
axis(1,at=c(CurrentSum,CurrentSum-3533,CurrentSum-13533),labels = c("Present","3333","13333"),cex.axis=2.5)
# axis(2,at=c(5000,50000),labels = c("5000","50000"),cex.axis=2.5)

beanplot(Selection4Ns_0_100Gens$V1-200,Selection4Ns_100_100Gens$V1-200,Selection4Ns_Minus100_100Gens$V1-200,Selection4Ns_50_100Gens$V1-200,Selection4Ns_Minus50_100Gens$V1-200,names=c("0","25","-25","50","-50"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main=" Inference of Selection\nSchiffels and Durbin (2014) Nature Genetics model",cex.axis=2.2,cex.lab=2.5,cex.main=1.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, yaxt='n')
axis(2, at=c(-200, -150, -100, -50, 0, 50, 100, 150, 200), labels = c(-200, -150, -100, -50, 0, 50, 100, 150, 200), cex.axis = 2)
abline(h=0,lty=3)
abline(h=25,lty=3)
abline(h=-25,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)


PopulationSizes <- c(14620, 28948, 32326, 38110, 44932 , 52972 , 62452, 73630 , 86806 , 102342 , 120658 , 142250 , 167708, 197722, 233108 , 274826 , 324010 , 381998 , 450362 , 530962 , 625984, 738014, 834302, 834302)
PopulationSizes <- PopulationSizes / 2
Times <- c(116960, 5715, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 5, 5 )
Sums <- c()
CurrentSum <- 0
for (i in 1:length(Times)){
    Sums <- c(Sums,CurrentSum)
    CurrentSum <- CurrentSum + Times[i]
}

plot(Sums,PopulationSizes,type="s",xlim = c(122875-250, 122875),ylab="Effective Population Size",xlab="Time before the present",main="B) Demographic Model in Africans\nTennessen et al (2012) Science model ",xaxt= "n",cex.main=1.5,cex.lab=2.5,cex.axis=2,col="red",lwd=6)
axis(1,at=c(CurrentSum-5,CurrentSum-110,CurrentSum-210),labels = c("Present","105","205"),cex.axis=2.5)
# axis(2,at=c(5000,50000),labels = c("5000","50000"),cex.axis=2.5)
# abline(h=834302)

beanplot(Selection4Ns_0_1000Gens$V1-200,Selection4Ns_100_1000Gens$V1-200,Selection4Ns_Minus100_1000Gens$V1-200,Selection4Ns_50_1000Gens$V1-200,Selection4Ns_Minus50_1000Gens$V1-200,names=c("0","25","-25","50","-50"),ylab="Estimated 4Ns values",xlab="Real 4Ns values",main="Inference of Selection\nTennessen et al (2012) Science model",cex.axis=2.2,cex.lab=2.5,cex.main=1.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, yaxt='n')
axis(2, at=c(-200, -150, -100, -50, 0, 50, 100, 150, 200), labels = c(-200, -150, -100, -50, 0, 50, 100, 150, 200), cex.axis = 2)
abline(h=0,lty=3)
abline(h=25,lty=3)
abline(h=-25,lty=3)
abline(h=50,lty=3)
abline(h=-50,lty=3)

dev.off()

# pdf_compress(Plot, output = PlotC, gs_quality = "printer")
