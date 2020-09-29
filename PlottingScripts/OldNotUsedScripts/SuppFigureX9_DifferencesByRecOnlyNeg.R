library(here)
library(beanplot)

pdf("../Figures/SuppFigure9_Selection.pdf",height = 13.66667, width = 14)
par(mfrow=c(5,2),mar=c(4.1,3.1,6.1,1.1))

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

for (j in 1:1){
    MatrixData <- matrix(nrow=50, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"),  maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE), ylim =c(-90,90), overallline = "median",ll=0.5)
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

for (j in 1:1){
    MatrixData <- matrix(nrow=50, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5, names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"), cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5, ylim =c(-90,20),overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, bw="nrd0")
    abline(h=YValue[j], lty = 2)
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
    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5, names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"), cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5, ylim =c(-90,20),overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, bw="nrd0")
    abline(h=YValue[j], lty = 2)
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
    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5, names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"), cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5, ylim =c(-90,20),overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5, bw="nrd0")
    abline(h=YValue[j], lty = 2)
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
    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"),  maxstripline=0.15,beanlinewd=0.5,overall=10000, ylim =c(-90,90),what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
    abline(h=YValue[j], lty = 2)
}

plot.new()

for (j in 5:5){
    MatrixData <- matrix(nrow=50, ncol=21)
    for (i in 1:21){
        File <- paste (RecombinationPrefix[i],FourNsSuffix[j],sep = "")
        Data <- read.table(File)
        MatrixData[,i] <- Data$V1
    }
    beanplot(MatrixData[,1], MatrixData[,2],MatrixData[,3],MatrixData[,4],MatrixData[,5],MatrixData[,6],MatrixData[,7],MatrixData[,8],MatrixData[,9],MatrixData[,10],MatrixData[,11],MatrixData[,12],MatrixData[,13],MatrixData[,14],MatrixData[,15],MatrixData[,16],MatrixData[,17],MatrixData[,18],MatrixData[,19],MatrixData[,20],MatrixData[,21],ylab="Estimated 4Ns values",xlab="Quantile",main=Titles[j], cex.axis=2.2,cex.lab=2.5,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", names=c("0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"),  maxstripline=0.15,beanlinewd=0.5,overall=10000, ylim =c(-90,90),what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
    abline(h=YValue[j], lty = 2)
}

#plot("")


dev.off()




