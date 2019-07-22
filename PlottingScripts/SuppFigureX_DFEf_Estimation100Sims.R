setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

library(viridis)

Divisions <- 30
DivisionsPlusOne <- Divisions + 1
Sums <- c()
FullConcatenation <- c()

################################################### Two plots on same place ############################

ColorViridis <- viridis(4)

Alpha = 0.184
Beta = 319.8626 * 10

P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,Alpha,scale=Beta) - pgamma((i-1)*2.5,Alpha,scale=Beta)
    P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((160000)*2500*1000)) # Original Test
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientListBoyko <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantBoyko.txt")

### P (allele is at 1%)

P_allele_at_OnePercent = nrow(SelectionCoefficientListBoyko)/((160000)*2500*1000) # Original
Alpha = 0.11
Beta = 8636364 * 0.01

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5 - 0.25,Alpha,scale=Beta) - pgamma(max((i-1)*2.5 - 0.25,0),Alpha,scale=Beta)
    #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((160000)*2500*1000)) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantBoyko.txt")

TwoNsValues <- SelectionCoefficientList$V2*20000

Breaks <- c(0,2.5*0:300 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ sum(Counts_At_OnePercent_Given2Ns[1:50])


DFEPars <- read.table ("../ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")
MLE <- read.table("../Results/MLEDFEs/ConstantBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

DFEParameterNumber <- (Column[1]-1)*70 + Row[1]


P_Allele_Is_2Ns_given_OnePercent <- c()
# MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(nrow=1,ncol=50)

FourNs <- SelectionCoefficientListBoyko$V2 * 40000

for (j in 1:100){
Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1
DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
P_Allele_Is_2Ns_given_OnePercent <- c()
for (i in 1:55){
    UpperBound <- i*5 + 2
    LowerBound <- (i-1)*5 + 3
    CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
}
ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent[1:Divisions] * P_allele_at_OnePercent
ProbsMouse <- ProbsMouse[1:Divisions] / Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]
ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
if (j==1){
    #    MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
    MatrixFinalProbs <- matrix(ProbsMouse,nrow=1)
}else{
    #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
     MatrixFinalProbs <- rbind ( MatrixFinalProbs,ProbsMouse)
}
}
GammaLimit <- Divisions * 2.5
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((160000)*2500*1000)

# Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:55){
        UpperBound <- i*5 + 2
        LowerBound <- (i-1)*5 + 3
        CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    OtherProbsMouse <- c(P_Allele_Is_2Ns_given_OnePercent[1:Divisions],1-sum(P_Allele_Is_2Ns_given_OnePercent[1:Divisions]))
    OtherProbsMouse <-  OtherProbsMouse[1:DivisionsPlusOne] / Probabilities_At_One_Percent_Given_2NsMouse[1:DivisionsPlusOne]
    OtherProbsMouse <- OtherProbsMouse[1:DivisionsPlusOne] / sum (OtherProbsMouse[1:DivisionsPlusOne] )
    if (j==1){
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
        OtherMatrixFinalProbs <- matrix(OtherProbsMouse,nrow=1)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
    }else{
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
        OtherMatrixFinalProbs <- rbind ( OtherMatrixFinalProbs,OtherProbsMouse)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent, P_Allele_Is_2Ns_given_OnePercent)
    }
}

Labels <- c()
for (i in 1:20){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}
Label <- paste(">","150",sep="")
Labels <- c("0-5","50-55","100-150",Label)

pdf("../Figures/SuppFigure12_DFEf_Estimation100Sims.pdf",width=10,height = 14)
par(mar=c(4.1,5.1,2.6,2.1))
par(mfrow = c(4,1))

###### April 18, 2018. Add
counts <- table(mtcars$vs, mtcars$gear)
Test <- counts[1,]
Test <- c(Test,c(Probabilities_At_One_Percent_Given_2NsMouse[4:Divisions],1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions])))

Test[1] <- Probabilities_At_One_Percent_Given_2NsMouse[1]
Test[2] <- Probabilities_At_One_Percent_Given_2NsMouse[2]
Test[3] <- Probabilities_At_One_Percent_Given_2NsMouse[3]
colnames(Test) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50", "50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", "100-105", "105-110", "110-115", "115-120", "120-125", "125-130", "130-135", "135-140", "140-145", "145-150", ">150")

rownames(Test) <- c("Probability")
###### April 18, 2018. End


plot(1:DivisionsPlusOne,c(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions], 1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "A) Constant size - Human DFE",cex.main = 2)
# barplot (Test,col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "A) Constant size - Human DFE",cex.main = 2)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
#    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
# points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
# points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[2],lwd=4)
# lines(1:31,c(P_Allele_Is_2Ns_given_OnePercent[1:30],  1 - sum(P_Allele_Is_2Ns_given_OnePercent[1:30])),col=ColorViridis[4],lwd=3)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
#    points(i,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
# points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
# points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)

FinalMedian <- c()
MiniSum <- 0
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    points(i,Quantiles[1],col="red",pch=25, bg = "red")
    points(i,Quantiles[2],col="red",pch=24, bg = "red")
    Check <- ifelse((Quantiles[1] < Probabilities_At_One_Percent_Given_2NsMouse[i]) && (Quantiles[2] > Probabilities_At_One_Percent_Given_2NsMouse[i]),1,0)
    FullConcatenation <- c(FullConcatenation, Check)
    MiniSum <- MiniSum + Check
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
points(DivisionsPlusOne,Quantiles[1],col="red",pch=25, bg = "red")
points(DivisionsPlusOne,Quantiles[2],col="red",pch=24, bg = "red")
Check <- ifelse((Quantiles[1] < (1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]))) && (Quantiles[2] > (1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]))),1,0)
FullConcatenation <- c(FullConcatenation, Check)
MiniSum <- MiniSum + Check
Sums <- c(Sums, MiniSum)
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[4],lwd=2)


# for (i in 1:30){
#    segments (i,OtherUpSDProbsMouse[i],x1=i,y1=max(OtherDownSDProbsMouse[i],0),col=ColorViridis[3], lwd = 3, lty = 2)
# }
# segments (31, 1 - sum(OtherUpSDProbsMouse[1:30]),x1=31,y1=max( 1 - sum(OtherDownSDProbsMouse[1:30])),col=ColorViridis[3], lwd = 3, lty = 2)


# Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
# Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
# Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression <- expression(paste("5% and 95% percentile of the inferred P(",bolditalic(s[j])," | f, DFE, D)"))
Expression2 <- expression(paste("P(",bolditalic(s[j])," | f, DFE, D)"))

legend("top",c(Expression, Expression2),pch=19,col=c("red","black"),cex=2)

axis(1, at=c(1:DivisionsPlusOne), labels=FALSE,cex.lab=1,cex=1,cex.axis=1)
axis(1, at=c(1,11,21,31), labels=Labels,cex.lab=2,cex=2,cex.axis=2,col.ticks="red")


# dev.off()


###################################### Plot 2 ################################################################################################################## 

ColorViridis <- viridis(4)

Alpha = 0.11
Beta = 8636364 * 0.01

P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,Alpha,scale=Beta) - pgamma((i-1)*2.5,Alpha,scale=Beta)
    P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((160000)*2500*1000)) # Original Test
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientListBoyko <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantMouse.txt")

### P (allele is at 1%)

P_allele_at_OnePercent = nrow(SelectionCoefficientListBoyko)/((160000)*2500*1000) # Original
Alpha = 0.184
Beta = 319.8626 * 10

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5 - 0.25,Alpha,scale=Beta) - pgamma(max((i-1)*2.5 - 0.25,0),Alpha,scale=Beta)
    #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((160000)*2500*1000)) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantMouse.txt")

TwoNsValues <- SelectionCoefficientList$V2*20000

Breaks <- c(0,2.5*0:200 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ sum(Counts_At_OnePercent_Given2Ns[1:50])


DFEPars <- read.table ("../ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")
MLE <- read.table("../Results/MLEDFEs/ConstantMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

DFEParameterNumber <- (Column[1]-1)*70 + Row[1]


P_Allele_Is_2Ns_given_OnePercent <- c()
# MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(nrow=1,ncol=50)

FourNs <- SelectionCoefficientListBoyko$V2 * 40000

for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:55){
        UpperBound <- i*5 + 2
        LowerBound <- (i-1)*5 + 3
        CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent[1:Divisions] * P_allele_at_OnePercent
    ProbsMouse <- ProbsMouse[1:Divisions] / Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]
    ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
    if (j==1){
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
        MatrixFinalProbs <- matrix(ProbsMouse,nrow=1)
    }else{
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
        MatrixFinalProbs <- rbind ( MatrixFinalProbs,ProbsMouse)
    }
}

GammaLimit <- Divisions * 2.5
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((160000)*2500*1000)

# Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:55){
        UpperBound <- i*5 + 2
        LowerBound <- (i-1)*5 + 3
        CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    OtherProbsMouse <- c(P_Allele_Is_2Ns_given_OnePercent[1:Divisions],1-sum(P_Allele_Is_2Ns_given_OnePercent[1:Divisions]))
    OtherProbsMouse <-  OtherProbsMouse[1:DivisionsPlusOne] / Probabilities_At_One_Percent_Given_2NsMouse[1:DivisionsPlusOne]
    OtherProbsMouse <- OtherProbsMouse[1:DivisionsPlusOne] / sum (OtherProbsMouse[1:DivisionsPlusOne] )
    if (j==1){
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
        OtherMatrixFinalProbs <- matrix(OtherProbsMouse,nrow=1)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
    }else{
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
        OtherMatrixFinalProbs <- rbind ( OtherMatrixFinalProbs,OtherProbsMouse)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent, P_Allele_Is_2Ns_given_OnePercent)
    }
}

Labels <- c()
for (i in 1:20){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}
Label <- paste(">","150",sep="")
Labels <- c("0-5","50-55","100-150",Label)

# pdf("../Figures/SuppFigure11_DFEf_toDFEOn100Sims.pdf",width=7,height = 14)
# par(mar=c(4.1,5.1,2.6,2.1))
# par(mfrow = c(4,1))

plot(1:DivisionsPlusOne,c(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions], 1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "B) Constant size - Mouse DFE",cex.main = 2)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
    #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
#segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


#lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[2],lwd=4)
# lines(1:31,c(P_Allele_Is_2Ns_given_OnePercent[1:30],  1 - sum(P_Allele_Is_2Ns_given_OnePercent[1:30])),col=ColorViridis[4],lwd=3)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
    #    points(i,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
#segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

#lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)


FinalMedian <- c()
MiniSum <- 0
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    points(i,Quantiles[1],col="red",pch=25, bg = "red")
    points(i,Quantiles[2],col="red",pch=24, bg = "red")
    Check <- ifelse((Quantiles[1] < Probabilities_At_One_Percent_Given_2NsMouse[i]) && (Quantiles[2] > Probabilities_At_One_Percent_Given_2NsMouse[i]),1,0)
    FullConcatenation <- c(FullConcatenation, Check)
    MiniSum <- MiniSum + Check
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}


Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
points(DivisionsPlusOne,Quantiles[1],col="red",pch=25, bg = "red")
points(DivisionsPlusOne,Quantiles[2],col="red",pch=24, bg = "red")
Check <- ifelse((Quantiles[1] < (1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]))) && (Quantiles[2] > (1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]))),1,0)
FullConcatenation <- c(FullConcatenation, Check)

MiniSum <- MiniSum + Check
Sums <- c(Sums, MiniSum)
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

#lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[4],lwd=2)


# for (i in 1:30){
#    segments (i,OtherUpSDProbsMouse[i],x1=i,y1=max(OtherDownSDProbsMouse[i],0),col=ColorViridis[3], lwd = 3, lty = 2)
# }
# segments (31, 1 - sum(OtherUpSDProbsMouse[1:30]),x1=31,y1=max( 1 - sum(OtherDownSDProbsMouse[1:30])),col=ColorViridis[3], lwd = 3, lty = 2)


# Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
# Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
# Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression <- expression(paste("5% and 95% percentile of the inferred P(",bolditalic(s[j])," | f, DFE, D)"))
Expression2 <- expression(paste("P(",bolditalic(s[j])," | f, DFE, D)"))

legend("top",c(Expression, Expression2),pch=19,col=c("red","black"),cex=2)


axis(1, at=c(1:31), labels=FALSE,cex.lab=1,cex=1,cex.axis=1)
axis(1, at=c(1,11,21,31), labels=Labels,cex.lab=2,cex=2,cex.axis=2,col.ticks="red")


###################################### Plot 3 ##################################################################################################################


ColorViridis <- viridis(4)

Alpha = 0.184
Beta = 319.8626 * 10

P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,Alpha,scale=Beta) - pgamma((i-1)*2.5,Alpha,scale=Beta)
    P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((80000 + (100000/10000)*100)*2500*1000)) # Original Test
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientListBoyko <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionBoyko.txt")

### P (allele is at 1%)

P_allele_at_OnePercent = nrow(SelectionCoefficientListBoyko)/((80000 + (100000/10000)*100)*2500*1000) # Original
Alpha = 0.11
Beta = 8636364 * 0.01

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5 - 0.25,Alpha,scale=Beta) - pgamma(max((i-1)*2.5 - 0.25,0),Alpha,scale=Beta)
    #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((80000 + (100000/10000)*100)*2500*1000)) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionBoyko.txt")

TwoNsValues <- SelectionCoefficientList$V2*10000

Breaks <- c(0,2.5*0:200 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ sum(Counts_At_OnePercent_Given2Ns[1:50])


DFEPars <- read.table ("../ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")
MLE <- read.table("../Results/MLEDFEs/PopExpansionBoykoMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

DFEParameterNumber <- (Column[1]-1)*70 + Row[1]


P_Allele_Is_2Ns_given_OnePercent <- c()
# MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(nrow=1,ncol=50)

FourNs <- SelectionCoefficientListBoyko$V2 * 20000

for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:55){
        UpperBound <- i*5 + 2
        LowerBound <- (i-1)*5 + 3
        CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent[1:Divisions] * P_allele_at_OnePercent
    ProbsMouse <- ProbsMouse[1:Divisions] / Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]
    ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
    if (j==1){
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
        MatrixFinalProbs <- matrix(ProbsMouse,nrow=1)
    }else{
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
        MatrixFinalProbs <- rbind ( MatrixFinalProbs,ProbsMouse)
    }
}

GammaLimit <- Divisions * 2.5
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((80000 + (100000/10000)*100)*2500*1000)


# Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:55){
        UpperBound <- i*5 + 2
        LowerBound <- (i-1)*5 + 3
        CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    OtherProbsMouse <- c(P_Allele_Is_2Ns_given_OnePercent[1:Divisions],1-sum(P_Allele_Is_2Ns_given_OnePercent[1:Divisions]))
    OtherProbsMouse <-  OtherProbsMouse[1:DivisionsPlusOne] / Probabilities_At_One_Percent_Given_2NsMouse[1:DivisionsPlusOne]
    OtherProbsMouse <- OtherProbsMouse[1:DivisionsPlusOne] / sum (OtherProbsMouse[1:DivisionsPlusOne] )
    if (j==1){
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
        OtherMatrixFinalProbs <- matrix(OtherProbsMouse,nrow=1)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
    }else{
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
        OtherMatrixFinalProbs <- rbind ( OtherMatrixFinalProbs,OtherProbsMouse)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent, P_Allele_Is_2Ns_given_OnePercent)
    }
}

Labels <- c()
for (i in 1:20){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}
Label <- paste(">","150",sep="")
Labels <- c("0-5","50-55","100-150",Label)

# pdf("../Figures/SuppFigure11_DFEf_toDFEOn100Sims.pdf",width=7,height = 14)
# par(mar=c(4.1,5.1,2.6,2.1))
# par(mfrow = c(4,1))

plot(1:DivisionsPlusOne,c(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions], 1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "C) Population expansion - Human DFE",cex.main = 2)


FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
    #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
#segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[2],lwd=4)
# lines(1:31,c(P_Allele_Is_2Ns_given_OnePercent[1:30],  1 - sum(P_Allele_Is_2Ns_given_OnePercent[1:30])),col=ColorViridis[4],lwd=3)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
    #    points(i,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
#segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

#lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)


FinalMedian <- c()
MiniSum <- 0
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    points(i,Quantiles[1],col="red",pch=25, bg = "red")
    points(i,Quantiles[2],col="red",pch=24, bg = "red")
    Check <- ifelse((Quantiles[1] < Probabilities_At_One_Percent_Given_2NsMouse[i]) && (Quantiles[2] > Probabilities_At_One_Percent_Given_2NsMouse[i]),1,0)
    MiniSum <- MiniSum + Check
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
points(DivisionsPlusOne,Quantiles[1],col="red",pch=25, bg = "red")
points(DivisionsPlusOne,Quantiles[2],col="red",pch=24, bg = "red")
Check <- ifelse((Quantiles[1] < (1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]))) && (Quantiles[2] > (1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]))),1,0)
MiniSum <- MiniSum + Check
Sums <- c(Sums, MiniSum)
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

#lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[4],lwd=2)


# for (i in 1:30){
#    segments (i,OtherUpSDProbsMouse[i],x1=i,y1=max(OtherDownSDProbsMouse[i],0),col=ColorViridis[3], lwd = 3, lty = 2)
# }
# segments (31, 1 - sum(OtherUpSDProbsMouse[1:30]),x1=31,y1=max( 1 - sum(OtherDownSDProbsMouse[1:30])),col=ColorViridis[3], lwd = 3, lty = 2)


# Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
# Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
# Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression <- expression(paste("5% and 95% percentile of the inferred P(",bolditalic(s[j])," | f, DFE, D)"))
Expression2 <- expression(paste("P(",bolditalic(s[j])," | f, DFE, D)"))

legend("top",c(Expression, Expression2),pch=19,col=c("red","black"),cex=2)


axis(1, at=c(1:31), labels=FALSE,cex.lab=1,cex=1,cex.axis=1)
axis(1, at=c(1,11,21,31), labels=Labels,cex.lab=2,cex=2,cex.axis=2,col.ticks="red")




###################################### Plot 4 ##################################################################################################################

ColorViridis <- viridis(4)

Alpha = 0.11
Beta = 8636364 * 0.01

P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,Alpha,scale=Beta) - pgamma((i-1)*2.5,Alpha,scale=Beta)
    P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((80000 + (100000/10000)*100)*2500*1000)) # Original Test
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientListBoyko <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouse.txt")

### P (allele is at 1%)

P_allele_at_OnePercent = nrow(SelectionCoefficientListBoyko)/((80000 + (100000/10000)*100)*2500*1000) # Original
Alpha = 0.184
Beta = 319.8626 * 10

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5 - 0.25,Alpha,scale=Beta) - pgamma(max((i-1)*2.5 - 0.25,0),Alpha,scale=Beta)
    #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((80000 + (100000/10000)*100)*2500*1000)) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouse.txt")

TwoNsValues <- SelectionCoefficientList$V2*10000

Breaks <- c(0,2.5*0:300 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ sum(Counts_At_OnePercent_Given2Ns[1:50])


DFEPars <- read.table ("../ScriptsOctober22_2017/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")
MLE <- read.table("../Results/MLEDFEs/PopExpansionMouseMLE.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

DFEParameterNumber <- (Column[1]-1)*70 + Row[1]


P_Allele_Is_2Ns_given_OnePercent <- c()
# MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(nrow=1,ncol=50)

FourNs <- SelectionCoefficientListBoyko$V2 * 20000

for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:55){
        UpperBound <- i*5 + 2
        LowerBound <- (i-1)*5 + 3
        CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent[1:Divisions] * P_allele_at_OnePercent
    ProbsMouse <- ProbsMouse[1:Divisions] / Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]
    ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
    if (j==1){
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
        MatrixFinalProbs <- matrix(ProbsMouse,nrow=1)
    }else{
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
        MatrixFinalProbs <- rbind ( MatrixFinalProbs,ProbsMouse)
    }
}

GammaLimit <- Divisions * 2.5
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((80000 + (100000/10000)*100)*2500*1000)

# Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:55){
        UpperBound <- i*5 + 2
        LowerBound <- (i-1)*5 + 3
        CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    OtherProbsMouse <- c(P_Allele_Is_2Ns_given_OnePercent[1:Divisions],1-sum(P_Allele_Is_2Ns_given_OnePercent[1:Divisions]))
    OtherProbsMouse <-  OtherProbsMouse[1:DivisionsPlusOne] / Probabilities_At_One_Percent_Given_2NsMouse[1:DivisionsPlusOne]
    OtherProbsMouse <- OtherProbsMouse[1:DivisionsPlusOne] / sum (OtherProbsMouse[1:DivisionsPlusOne] )
    if (j==1){
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
        OtherMatrixFinalProbs <- matrix(OtherProbsMouse,nrow=1)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
    }else{
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
        OtherMatrixFinalProbs <- rbind ( OtherMatrixFinalProbs,OtherProbsMouse)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent, P_Allele_Is_2Ns_given_OnePercent)
    }
}

Labels <- c()
for (i in 1:20){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}
Label <- paste(">","150",sep="")
Labels <- c("0-5","50-55","100-150",Label)

# pdf("../Figures/SuppFigure11_DFEf_toDFEOn100Sims.pdf",width=7,height = 14)
# par(mar=c(4.1,5.1,2.6,2.1))
# par(mfrow = c(4,1))

plot(1:DivisionsPlusOne,c(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions], 1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "D) Population expansion - Mouse DFE",cex.main = 2)


FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
    #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
#segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
# points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
# points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[2],lwd=4)
# lines(1:31,c(P_Allele_Is_2Ns_given_OnePercent[1:30],  1 - sum(P_Allele_Is_2Ns_given_OnePercent[1:30])),col=ColorViridis[4],lwd=3)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
    #    points(i,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
#segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

#lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)


FinalMedian <- c()
MiniSum <- 0
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    points(i,Quantiles[1],col="red",pch=25, bg = "red")
    points(i,Quantiles[2],col="red",pch=24, bg = "red")
    Check <- ifelse((Quantiles[1] < Probabilities_At_One_Percent_Given_2NsMouse[i]) && (Quantiles[2] > Probabilities_At_One_Percent_Given_2NsMouse[i]),1,0)
    MiniSum <- MiniSum + Check
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
points(DivisionsPlusOne,Quantiles[1],col="red",pch=25, bg = "red")
points(DivisionsPlusOne,Quantiles[2],col="red",pch=24, bg = "red")
Check <- ifelse((Quantiles[1] < (1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]))) && (Quantiles[2] > (1 - sum(Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]))),1,0)
MiniSum <- MiniSum + Check
Sums <- c(Sums, MiniSum)
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

#lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[4],lwd=2)


# for (i in 1:30){
#    segments (i,OtherUpSDProbsMouse[i],x1=i,y1=max(OtherDownSDProbsMouse[i],0),col=ColorViridis[3], lwd = 3, lty = 2)
# }
# segments (31, 1 - sum(OtherUpSDProbsMouse[1:30]),x1=31,y1=max( 1 - sum(OtherDownSDProbsMouse[1:30])),col=ColorViridis[3], lwd = 3, lty = 2)


# Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
# Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
# Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression <- expression(paste("5% and 95% percentile of the inferred P(",bolditalic(s[j])," | f, DFE, D)"))
Expression2 <- expression(paste("P(",bolditalic(s[j])," | f, DFE, D)"))

legend("top",c(Expression, Expression2),pch=19,col=c("red","black"),cex=2)


axis(1, at=c(1:31), labels=FALSE,cex.lab=1,cex=1,cex.axis=1)
axis(1, at=c(1,11,21,31), labels=Labels,cex.lab=2,cex=2,cex.axis=2,col.ticks="red")

dev.off()

