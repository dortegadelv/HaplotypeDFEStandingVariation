library(here)
library(viridis)
library(beanplot)

Divisions <- 20
DivisionsPlusOne <- Divisions + 1

################################################### Two plots on same place ############################

ColorViridis <- viridis(3)
ViridisColors <- viridis(3)

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

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantMouse.txt")

TwoNsValues <- SelectionCoefficientList$V2*20000

Breaks <- c(0,2.5*0:200 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ (NumberOfAllelesAt2Ns[1:50])


DFEParsOne <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

DFEParsTwo <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")

DFEPars <- rbind(DFEParsOne, DFEParsTwo)

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
DFEParameterNumber <- MLE$V1[j] + 1
P_Allele_Is_2Ns_given_OnePercent <- c()
for (i in 1:40){
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
    DifferenceMatrix <- ProbsMouse
}else{
    #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
     MatrixFinalProbs <- rbind ( MatrixFinalProbs,ProbsMouse)
     DifferenceMatrix <- rbind (DifferenceMatrix,ProbsMouse)
}
}
GammaLimit <- Divisions * 2.5
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((160000)*2500*1000)

Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:40){
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

pdf("../Figures/SuppFigure23_DFEf_toDFEOn100SimsPopExpansionDifRate.pdf",width=10,height = 14)
par(mar=c(4.1,5.1,2.6,2.1))
par(mfrow = c(4,1))

PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

# plot(1:DivisionsPlusOne,c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "A) Constant size - Human DFE",cex.main = 2)

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


PartTwo <- FinalMedian
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


PartThree <- FinalMedian
# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
    #    points(i,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


PartFour <- FinalMedian
# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[4],lwd=2)


# for (i in 1:30){
#    segments (i,OtherUpSDProbsMouse[i],x1=i,y1=max(OtherDownSDProbsMouse[i],0),col=ColorViridis[3], lwd = 3, lty = 2)
# }
# segments (31, 1 - sum(OtherUpSDProbsMouse[1:30]),x1=31,y1=max( 1 - sum(OtherDownSDProbsMouse[1:30])),col=ColorViridis[3], lwd = 3, lty = 2)


counts <- table(mtcars$vs, mtcars$gear)
counts <- rbind(counts,c(1,2,3))
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
for (i in 4:20){
counts <- cbind(counts,c(PartOne[i],PartTwo[i],PartFour[i]))
}

counts <- cbind(counts,c(1-sum(PartOne[1:20]),1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))

counts[1,1] <- PartOne[1]
counts[1,2] <- PartOne[2]
counts[1,3] <- PartOne[3]
counts[2,1] <- PartTwo[1]
counts[2,2] <- PartTwo[2]
counts[2,3] <- PartTwo[3]
counts[3,1] <- PartFour[1]
counts[3,2] <- PartFour[2]
counts[3,3] <- PartFour[3]

BoykoParams <- PartOne

colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50","50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| 1%, DFE, D)")

# barplot(log10(counts) - log10(0.0000000001), main="A) Constant Size - Human DFE", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, legend = c(expression("Real" ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression('P'[psi] * "(" * bolditalic(s[j]) * " | "* italic(f) * ", "* italic(D) *")")), beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5, bty = "n"), cex.main = 2, ylim = c(0,12), yaxt="n")

# axis (2,at=c(0,2,4,6,8,10), labels = c(0,10^-8,10^-6,10^-4,10^-2,10^0), cex.axis = 1.5, cex.lab = 1.5)


Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression4 <- expression(paste("Inferred P(",bolditalic(s[j])," | 1%, DFE, D)"))
# legend("top",c(Expression, Expression2, Expression3, Expression4),pch=19,col=ColorViridis,cex=2)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixFinalProbs[,i])
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        points((i - 1)* 4 + 2.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
        points((i - 1)* 4 + 2.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
        points((i - 1)* 4 + 2.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

points(Divisions*4 + 2.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*4 + 2.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*4 + 2.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 3.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*4 + 3.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*4 + 3.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*4 + 3.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


# axis(1, at=c(1:DivisionsPlusOne), labels=FALSE,cex.lab=1,cex=1,cex.axis=1)
# axis(1, at=c(1,11,21,31), labels=Labels,cex.lab=2,cex=2,cex.axis=2,col.ticks="red")


# dev.off()


###################################### Plot 2 ################################################################################################################## 

ColorViridis <- viridis(3)

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

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesConstantBoyko.txt")

TwoNsValues <- SelectionCoefficientList$V2*20000

Breaks <- c(0,2.5*0:300 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ (NumberOfAllelesAt2Ns[1:50])

DFEParsOne <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

DFEParsTwo <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")

DFEPars <- rbind(DFEParsOne, DFEParsTwo)

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
    for (i in 1:40){
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
        DifferenceMatrix <- rbind (DifferenceMatrix,ProbsMouse)
    }else{
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
        MatrixFinalProbs <- rbind ( MatrixFinalProbs,ProbsMouse)
        DifferenceMatrix <- rbind (DifferenceMatrix,ProbsMouse)
    }
}

GammaLimit <- Divisions * 2.5
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((160000)*2500*1000)

Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:40){
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

PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

# plot(1:DivisionsPlusOne,c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "A) Constant size - Human DFE",cex.main = 2)

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


PartTwo <- FinalMedian
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


PartThree <- FinalMedian
# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
    #    points(i,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


PartFour <- FinalMedian
# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[4],lwd=2)


# for (i in 1:30){
#    segments (i,OtherUpSDProbsMouse[i],x1=i,y1=max(OtherDownSDProbsMouse[i],0),col=ColorViridis[3], lwd = 3, lty = 2)
# }
# segments (31, 1 - sum(OtherUpSDProbsMouse[1:30]),x1=31,y1=max( 1 - sum(OtherDownSDProbsMouse[1:30])),col=ColorViridis[3], lwd = 3, lty = 2)



counts <- table(mtcars$vs, mtcars$gear)
counts <- rbind(counts,c(1,2,3))
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
for (i in 4:20){
    counts <- cbind(counts,c(PartOne[i],PartTwo[i],PartFour[i]))
}

counts <- cbind(counts,c(1-sum(PartOne[1:20]),1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))

counts[1,1] <- PartOne[1]
counts[1,2] <- PartOne[2]
counts[1,3] <- PartOne[3]
counts[2,1] <- PartTwo[1]
counts[2,2] <- PartTwo[2]
counts[2,3] <- PartTwo[3]
counts[3,1] <- PartFour[1]
counts[3,2] <- PartFour[2]
counts[3,3] <- PartFour[3]

BoykoParams <- rbind(BoykoParams, PartOne)

colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50","50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| 1%, DFE, D)")



#barplot(log10(counts) - log10(0.0000000001), main="B) Constant Size - Mouse DFE", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5), cex.main = 2, ylim = c(0,10), yaxt="n")

# axis (2,at=c(0,2,4,6,8,10), labels = c(0,10^-8,10^-6,10^-4,10^-2,10^0), cex.axis = 1.5, cex.lab = 1.5)


Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression4 <- expression(paste("Inferred P(",bolditalic(s[j])," | 1%, DFE, D)"))
# legend("top",c(Expression, Expression2, Expression3, Expression4),pch=19,col=ColorViridis,cex=2)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixFinalProbs[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 2.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 2.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 2.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)

    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

points(Divisions*4 + 2.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*4 + 2.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*4 + 2.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 3.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)

    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)


points(Divisions*4 + 3.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*4 + 3.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*4 + 3.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression4 <- expression(paste("Inferred P(",bolditalic(s[j])," | 1%, DFE, D)"))
# legend("top",c(Expression, Expression2, Expression3, Expression4),pch=19,col=ColorViridis,cex=2)

# axis(1, at=c(1:DivisionsPlusOne), labels=FALSE,cex.lab=1,cex=1,cex.axis=1)
# axis(1, at=c(1,11,21,31), labels=Labels,cex.lab=2,cex=2,cex.axis=2,col.ticks="red")


# dev.off()


###################################### Plot 3 ##################################################################################################################


ColorViridis <- viridis(3)

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

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouse.txt")

TwoNsValues <- SelectionCoefficientList$V2*10000

Breaks <- c(0,2.5*0:200 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ (NumberOfAllelesAt2Ns[1:50])

DFEParsOne <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

DFEParsTwo <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")

DFEPars <- rbind(DFEParsOne, DFEParsTwo)


MLE <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionBoykoDifRecRate.txt")

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
    for (i in 1:40){
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
        DifferenceMatrix <- rbind (DifferenceMatrix,ProbsMouse)
    }else{
        #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
        MatrixFinalProbs <- rbind ( MatrixFinalProbs,ProbsMouse)
        DifferenceMatrix <- rbind (DifferenceMatrix,ProbsMouse)
    }
}

GammaLimit <- Divisions * 2.5
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((80000 + (100000/10000)*100)*2500*1000)


Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:40){
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

PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

# plot(1:DivisionsPlusOne,c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "A) Constant size - Human DFE",cex.main = 2)

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


PartTwo <- FinalMedian
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


PartThree <- FinalMedian
# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
    #    points(i,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


PartFour <- FinalMedian
# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[4],lwd=2)


# for (i in 1:30){
#    segments (i,OtherUpSDProbsMouse[i],x1=i,y1=max(OtherDownSDProbsMouse[i],0),col=ColorViridis[3], lwd = 3, lty = 2)
# }
# segments (31, 1 - sum(OtherUpSDProbsMouse[1:30]),x1=31,y1=max( 1 - sum(OtherDownSDProbsMouse[1:30])),col=ColorViridis[3], lwd = 3, lty = 2)



counts <- table(mtcars$vs, mtcars$gear)
counts <- rbind(counts,c(1,2,3))
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
for (i in 4:20){
    counts <- cbind(counts,c(PartOne[i],PartTwo[i],PartFour[i]))
}

counts <- cbind(counts,c(1-sum(PartOne[1:20]),1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))

counts[1,1] <- PartOne[1]
counts[1,2] <- PartOne[2]
counts[1,3] <- PartOne[3]
counts[2,1] <- PartTwo[1]
counts[2,2] <- PartTwo[2]
counts[2,3] <- PartTwo[3]
counts[3,1] <- PartFour[1]
counts[3,2] <- PartFour[2]
counts[3,3] <- PartFour[3]

BoykoParams <- rbind(BoykoParams, PartOne)

colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50","50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| 1%, DFE, D)")

barplot(log10(counts) - log10(0.0000000001), main="C) Population expansion - Human DFE", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), legend = c(expression("Real" ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression('P'[psi] * "(" * bolditalic(s[j]) * " | "* italic(f) * ", "* italic(D) *")")), col=ViridisColors, beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5), cex.main = 2, ylim = c(0,15), yaxt="n")

axis (2,at=c(0,2,4,6,8,10), labels = c(0,10^-8,10^-6,10^-4,10^-2,10^0), cex.axis = 1.5, cex.lab = 1.5)


Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression4 <- expression(paste("Inferred P(",bolditalic(s[j])," | 1%, DFE, D)"))
# legend("top",c(Expression, Expression2, Expression3, Expression4),pch=19,col=ColorViridis,cex=2)

FinalMedian <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixFinalProbs[,i])
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 2.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 2.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 2.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)

    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])
points(Divisions*4 + 2.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*4 + 2.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*4 + 2.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)

FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 3.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)

    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))

points(Divisions*4 + 3.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*4 + 3.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*4 + 3.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)



dev.off()


############################################################################### Full data  #################################################################################
