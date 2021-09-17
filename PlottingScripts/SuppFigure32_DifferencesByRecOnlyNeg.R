library(here)
library(beanplot)
library(viridis)

pdf("../Figures/SuppFigure32_Selection.pdf",height = 13.66667/(5/3), width = 14/2)
par(mfrow=c(3,1),mar=c(4.1,6.1,6.1,1.1))

RecombinationPrefix <- c()
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec0")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec191.352")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec495.326")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec783.562")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec1079.2")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec1370.047")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec1888.974")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec2244.487")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec2512.65")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec2881.44")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec3391.733")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec3977.678")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec4614.348")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec5215.098")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec5869.541")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec6966.051")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec7767.025")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec8498.236")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec10215.751")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec12984.294")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec23003.3")

FourNsSuffix <- c()
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_0.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-50.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_50.txt")

YValue <- c()
YValue <- c(YValue,0)
YValue <- c(YValue,-25)
YValue <- c(YValue,-50)
YValue <- c(YValue,25)
YValue <- c(YValue,50)

Titles <- c()
Titles <- c(Titles, "A) Selection Inference 4Ns = 0\n 1% +- 0.05% frequency variants")
Titles <- c(Titles, "B) Selection Inference 4Ns = -25\n 1% +- 0.05% frequency variants")
Titles <- c(Titles, "C) Selection Inference 4Ns = -50\n 1% +- 0.05% frequency variants")
Titles <- c(Titles, "D) Selection Inference 4Ns = 25\n 1% +- 0.05% frequency variants")
Titles <- c(Titles, "E) Selection Inference 4Ns = 50\n 1% +- 0.05% frequency variants")

RMSE_Normal <- 0
VectorRMSE_Normal <- c()

for (j in 1:5){
    MatrixData <- matrix(nrow=100, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
    
    RMSE_Normal <- RMSE_Normal + (sum(((MatrixData - YValue[j])^2)/2100))^(1/2)
    VectorRMSE_Normal <- c(VectorRMSE_Normal, (sum(((MatrixData - YValue[j])^2)/2100))^(1/2))
beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"),  maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE), ylim =c(-95,95), overallline = "median",ll=0.5)
abline(h=YValue[j], lty = 2)
}

# dev.off()

#####################################################################


# pdf("../../Figures/SuppFigure13_SelectionOnlyNeg.pdf")
# par(mfrow=c(3,1),mar=c(4.1,3.1,3.1,0.6))

RecombinationPrefix <- c()
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly720")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly72191.352")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly72495.326")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly72783.562")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly721079.2")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly721370.047")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly721888.974")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly722244.487")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly722512.65")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly722881.44")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly723391.733")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly723977.678")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly724614.348")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly725215.098")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly725869.541")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly726966.051")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly727767.025")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly728498.236")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly7210215.751")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly7212984.294")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnly7223003.3")


FourNsSuffix <- c()
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_0.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-50.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_50.txt")

YValue <- c()
YValue <- c(YValue,0)
YValue <- c(YValue,-25)
YValue <- c(YValue,-50)
YValue <- c(YValue,25)
YValue <- c(YValue,50)

Titles <- c()
Titles <- c(Titles, "F) Selection Inference 4Ns = 0 | 1% frequency variants\n (72 derived alleles in a sample of 7242 chromosomes)")
Titles <- c(Titles, "G) Selection Inference 4Ns = -25 | 1% frequency variants\n (72 derived alleles in a sample of 7242 chromosomes)")
Titles <- c(Titles, "H) Selection Inference 4Ns = -50 | 1% frequency variants\n (72 derived alleles in a sample of 7242 chromosomes)")
Titles <- c(Titles, "I) Selection Inference 4Ns = 25 | 1% frequency variants\n (72 derived alleles in a sample of 7242 chromosomes)")
Titles <- c(Titles, "J) Selection Inference 4Ns = 50 | 1% frequency variants\n (72 derived alleles in a sample of 7242 chromosomes)")

RMSE_72 <- 0
VectorRMSE_72 <- c()

for (j in 1:5){
    MatrixData <- matrix(nrow=100, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
    
    RMSE_72 <- RMSE_72 + (sum(((MatrixData - YValue[j])^2)/2100))^(1/2)
    VectorRMSE_72 <- c(VectorRMSE_72, (sum(((MatrixData - YValue[j])^2)/2100))^(1/2))

beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"),  maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE), ylim =c(-95,95), overallline = "median",ll=0.5, bw = "nrd0")
abline(h=YValue[j], lty = 2)
}

ViridisColors <- viridis(2)

plot(VectorRMSE_Normal,ylim= c(0,100), col = ViridisColors[1], xlab = "4Ns", ylab = "RMSE", cex.axis=2.2, cex.lab=2, cex.main=2.5, xaxt= "n", lwd = 6, main = "K) RMSE", type = "b", pch = 19, cex = 3)
lines(VectorRMSE_72, col = ViridisColors[2], lwd = 3, type = "b", pch = 19, cex = 3)
legend("topright",legend = c("1% +- 0.05% frequency variants", "1% frequency variants"),col=ViridisColors, pch=19, cex = 2, title = "", bty = "n")

axis(1, at=c(1, 2, 3, 4, 5), labels = c("0", "-25", "-50", "25", "50"), cex.axis=2.2, cex.lab=2.5)

dev.off()

RecombinationPrefix <- c()
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec0")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec484.278")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec855.292")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec1251.886")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec1624.489")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec2164.258")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec2699.187")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec3120.820")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec3509.574")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec4083.76")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec4496.201")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec5625.89")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec6448.182")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec7504.213")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec8522.912")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec9955.981")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec10977.747")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec12265.958")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec14138.413")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec19608.766")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec38656.841")

FourNsSuffix <- c()
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_0.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-50.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_50.txt")

YValue <- c()
YValue <- c(YValue,0)
YValue <- c(YValue,-25)
YValue <- c(YValue,-50)
YValue <- c(YValue,25)
YValue <- c(YValue,50)

Titles <- c()
Titles <- c(Titles, "Selection Inference 4Ns = 0\n 1% frequency variants (72 derived alleles in a sample of 7242 chromosomes)")
Titles <- c(Titles, "Selection Inference 4Ns = -25\n 1% frequency variants (72 derived alleles in a sample of 7242 chromosomes)")
Titles <- c(Titles, "Selection Inference 4Ns = -50\n 1% frequency variants (72 derived alleles in a sample of 7242 chromosomes)")
Titles <- c(Titles, "Selection Inference 4Ns = 25\n 1% frequency variants (72 derived alleles in a sample of 7242 chromosomes)")
Titles <- c(Titles, "Selection Inference 4Ns = 50\n 1% frequency variants (72 derived alleles in a sample of 7242 chromosomes)")

for (j in 2:2){
    MatrixData <- matrix(nrow=50, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"),  maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE), ylim =c(-90,90),overallline = "median",ll=0.5)
    abline(h=YValue[j], lty = 2)
}

# dev.off()

#####################################################################


# pdf("../../Figures/SuppFigure13_SelectionOnlyNeg.pdf")
# par(mfrow=c(3,1),mar=c(4.1,3.1,3.1,0.6))

RecombinationPrefix <- c()
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg0")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg484.278")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg855.292")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg1251.886")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg1624.489")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg2164.258")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg2699.187")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg3120.820")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg3509.574")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg4083.76")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg4496.201")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg5625.89")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg6448.182")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg7504.213")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg8522.912")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg9955.981")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg10977.747")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg12265.958")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg14138.413")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg19608.766")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg38656.841")

FourNsSuffix <- c()
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_0.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-50.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_50.txt")

YValue <- c()
YValue <- c(YValue,0)
YValue <- c(YValue,-25)
YValue <- c(YValue,-50)
YValue <- c(YValue,25)
YValue <- c(YValue,50)

Titles <- c()
Titles <- c(Titles, "Selection Inference 4Ns = 0\n")
Titles <- c(Titles, "Selection Inference 4Ns = -25\n")
Titles <- c(Titles, "Selection Inference 4Ns = -50\n")
Titles <- c(Titles, "Selection Inference 4Ns = 25\n")
Titles <- c(Titles, "Selection Inference 4Ns = 50\n")

for (j in 2:2){
    MatrixData <- matrix(nrow=50, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
#    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5, names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"), cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5, ylim =c(-90,20),overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, bw="nrd0")
#    abline(h=YValue[j], lty = 2)
}




RecombinationPrefix <- c()
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec0")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec484.278")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec855.292")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec1251.886")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec1624.489")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec2164.258")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec2699.187")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec3120.820")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec3509.574")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec4083.76")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec4496.201")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec5625.89")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec6448.182")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec7504.213")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec8522.912")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec9955.981")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec10977.747")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec12265.958")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec14138.413")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec19608.766")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec38656.841")

FourNsSuffix <- c()
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_0.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-50.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_50.txt")

YValue <- c()
YValue <- c(YValue,0)
YValue <- c(YValue,-25)
YValue <- c(YValue,-50)
YValue <- c(YValue,25)
YValue <- c(YValue,50)

Titles <- c()
Titles <- c(Titles, "Selection Inference 4Ns = 0")
Titles <- c(Titles, "Selection Inference 4Ns = -25")
Titles <- c(Titles, "Selection Inference 4Ns = -50")
Titles <- c(Titles, "Selection Inference 4Ns = 25")
Titles <- c(Titles, "Selection Inference 4Ns = 50")

for (j in 3:3){
    MatrixData <- matrix(nrow=50, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"),  maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE), ylim =c(-90,90),overallline = "median",ll=0.5,sub="HI!")
    abline(h=YValue[j], lty = 2)
}

# dev.off()

#####################################################################


# pdf("../../Figures/SuppFigure13_SelectionOnlyNeg.pdf")
# par(mfrow=c(3,1),mar=c(4.1,3.1,3.1,0.6))

RecombinationPrefix <- c()
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg0")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg484.278")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg855.292")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg1251.886")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg1624.489")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg2164.258")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg2699.187")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg3120.820")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg3509.574")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg4083.76")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg4496.201")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg5625.89")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg6448.182")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg7504.213")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg8522.912")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg9955.981")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg10977.747")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg12265.958")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg14138.413")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg19608.766")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRecOnlyNeg38656.841")

FourNsSuffix <- c()
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_0.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-50.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_50.txt")

YValue <- c()
YValue <- c(YValue,0)
YValue <- c(YValue,-25)
YValue <- c(YValue,-50)
YValue <- c(YValue,25)
YValue <- c(YValue,50)

Titles <- c()
Titles <- c(Titles, "Selection Inference 4Ns = 0\n")
Titles <- c(Titles, "Selection Inference 4Ns = -25\n")
Titles <- c(Titles, "Selection Inference 4Ns = -50\n")
Titles <- c(Titles, "Selection Inference 4Ns = 25\n")
Titles <- c(Titles, "Selection Inference 4Ns = 50\n")

for (j in 3:3){
    MatrixData <- matrix(nrow=50, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
#    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5, names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"), cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5, ylim =c(-90,20),overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, bw="nrd0")
#    abline(h=YValue[j], lty = 2)
}


RecombinationPrefix <- c()
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec0")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec484.278")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec855.292")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec1251.886")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec1624.489")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec2164.258")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec2699.187")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec3120.820")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec3509.574")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec4083.76")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec4496.201")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec5625.89")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec6448.182")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec7504.213")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec8522.912")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec9955.981")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec10977.747")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec12265.958")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec14138.413")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec19608.766")
RecombinationPrefix <- c(RecombinationPrefix,"../Results/ResultsSelectionInferred/SelectionUK10KSingleRecHighRec38656.841")

FourNsSuffix <- c()
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_0.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_-50.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_25.txt")
FourNsSuffix <- c(FourNsSuffix,"4Ns4Ns_50.txt")

YValue <- c()
YValue <- c(YValue,0)
YValue <- c(YValue,-25)
YValue <- c(YValue,-50)
YValue <- c(YValue,25)
YValue <- c(YValue,50)

Titles <- c()
Titles <- c(Titles, "Selection Inference 4Ns = 0")
Titles <- c(Titles, "Selection Inference 4Ns = -25")
Titles <- c(Titles, "Selection Inference 4Ns = -50")
Titles <- c(Titles, "Selection Inference 4Ns = 25")
Titles <- c(Titles, "Selection Inference 4Ns = 50")

for (j in 4:4){
    MatrixData <- matrix(nrow=50, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
#    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"),  maxstripline=0.15,beanlinewd=0.5,overall=10000, ylim =c(-90,90),what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
#    abline(h=YValue[j], lty = 2)
}

plot.new()

for (j in 5:5){
    MatrixData <- matrix(nrow=50, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
#    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"),  maxstripline=0.15,beanlinewd=0.5,overall=10000, ylim =c(-90,90),what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
#    abline(h=YValue[j], lty = 2)
}

#plot("")


dev.off()




