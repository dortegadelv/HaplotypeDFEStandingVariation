
library(here)
library(viridis)
library(beanplot)

Divisions <- 20
DivisionsPlusOne <- Divisions + 1

AllPartTwo <- c()
DifferencesMatrix <- matrix(nrow=21,ncol=400)
################################################### Two plots on same place ############################

ColorViridis <- viridis(3)
ViridisColors <- viridis(3)

Alpha = 0.184
Beta = 319.8626 * 10 * (926/2)/10000 * 5

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

SelectionCoefficientListBoyko <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_1.txt")

### P (allele is at 1%)
## Ns sites = 29277495
## Reps = 160
## Mut rate two thirds = 2.31 / 3.31 * 0.000000012*5
## Individuals time epochs = 1000 * 10000 + 10000 * 20
## Per individual = ( 29277495 * 160 * 0.6978852 * 0.00000006 )
##

P_allele_at_OnePercent = 5328/(196.1504 * (926 * 4630 + 23166 * 28)) # Original
Alpha = 0.11
Beta = 8636364 * 0.01 * (926/2)/10000 * 5

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5 - 0.25,Alpha,scale=Beta) - pgamma(max((i-1)*2.5 - 0.25,0),Alpha,scale=Beta)
    #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(400 * (10000.0 * 4630 + 10000 * 28 * 23166/926 ))) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientList <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_1.txt")

TwoNsValues <- SelectionCoefficientList$V2*926

Breaks <- c(0,2.5*0:200 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ (NumberOfAllelesAt2Ns[1:50])


DFEParsOne <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

DFEParsTwo <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")

DFEPars <- rbind(DFEParsOne, DFEParsTwo)

MLE <- read.table("../Results/MLEDFEs/SelectionPopExpansionSLiMPopExpansionChangedRecRateBoykoDFE_1.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

DFEParameterNumber <- (Column[1]-1)*70 + Row[1]


P_Allele_Is_2Ns_given_OnePercent <- c()
# MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(nrow=1,ncol=50)

FourNs <- SelectionCoefficientListBoyko$V2 *926 * 2

for (j in 1:100){
Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1
DFEParameterNumber <- MLE$V1[j] + 1
P_Allele_Is_2Ns_given_OnePercent <- c()
for (i in 1:Divisions){
    UpperBound <- i*5 + 2
    LowerBound <- (i-1)*5 + 3
    CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
}
ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent[1:Divisions] * P_allele_at_OnePercent
ProbsMouse <- ProbsMouse[1:Divisions] / Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]
if (sum (ProbsMouse[1:Divisions]) < 1.0 ){
ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
}else {
    ProbsMouse <- ProbsMouse[1:Divisions] / sum(ProbsMouse[1:Divisions])
    ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
}

if (j==1){
    #    MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
    MatrixFinalProbs <- matrix (ProbsMouse,nrow=1)
    DifferenceMatrix <- ProbsMouse
}else{
    #    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
     MatrixFinalProbs <- rbind ( MatrixFinalProbs,ProbsMouse)
     DifferenceMatrix <- rbind (DifferenceMatrix,ProbsMouse)
}
}
GammaLimit <- Divisions * 2.5
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((400 * (10000.0 * 4630 + 10000 * 28 * 23166/926 )))

Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:Divisions){
        UpperBound <- i*5 + 2
        LowerBound <- (i-1)*5 + 3
        CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    OtherProbsMouse <- c(P_Allele_Is_2Ns_given_OnePercent[1:Divisions],1-sum(P_Allele_Is_2Ns_given_OnePercent[1:Divisions]))
    OtherProbsMouse <-  OtherProbsMouse[1:DivisionsPlusOne] / Probabilities_At_One_Percent_Given_2NsMouse[1:DivisionsPlusOne]
    OtherProbsMouse <- OtherProbsMouse[1:DivisionsPlusOne] / sum (OtherProbsMouse[1:DivisionsPlusOne] )
    DifferencesMatrix[1:DivisionsPlusOne,i] <- OtherProbsMouse[i]
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

pdf("../Figures/SuppFigure26_DFEf_toDFESLiMThreeBins.pdf",width=10,height = 14)
par(mar=c(4.1,5.1,2.6,2.1))
par(mfrow = c(4,1))

PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

# plot(1:DivisionsPlusOne,c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "A) Constant size - Human DFE",cex.main = 2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixFinalProbs[,1],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
    #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(MatrixFinalProbs[,1],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

CurrentSums <- c()
for (i in 1:100){
    CurrentSums <- c(CurrentSums, sum(MatrixFinalProbs[i,2:20]))
}

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSums,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

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
for (i in 1:1){
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
    #    points(i,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

# CurrentSums <- c()
# for (i in 1:100){
#     CurrentSums <- c(CurrentSums, sum(OtherMatrixFinalProbs[i,2:20]))
# }

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSums,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
#segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


PartThree <- FinalMedian
# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
    #    points(i,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

CurrentSumsOnePercent <- c()
SumP_2Ns_OnePercent <- c()
for (i in 1:100){
    CurrentSumsOnePercent <- c(CurrentSumsOnePercent, sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,2:20]))
    SumP_2Ns_OnePercent <- c(SumP_2Ns_OnePercent, 1 - sum (MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20] ))
}

Quantiles <- quantile(CurrentSumsOnePercent,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSumsOnePercent,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

Quantiles <- quantile(SumP_2Ns_OnePercent,c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
Quantiles <- quantile(SumP_2Ns_OnePercent, c(0.5))
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
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
# for (i in 4:20){
# counts <- cbind(counts,c(PartOne[i],PartTwo[i],PartFour[i]))
# }

# counts <- cbind(counts,c(1-sum(PartOne[1:20]),1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))
AllPartTwo <- c(AllPartTwo,PartTwo[1:20],1-sum(PartTwo[1:20]))
counts[1,1] <- PartOne[1]
counts[1,2] <- sum(PartOne[2:20])
counts[1,3] <- 1-sum(PartOne[1:20])
counts[2,1] <- PartTwo[1]
counts[2,2] <- PartTwo[2]
counts[2,3] <- 1-sum(PartTwo[1:2])
counts[3,1] <- PartFour[1]
counts[3,2] <- PartFour[2]
counts[3,3] <- 1-sum(PartFour[1:2])

BoykoParams <- c()
BoykoParams <- rbind(BoykoParams,counts[1,1:3])

colnames(counts) <- c("0-5", "5-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| 1%, DFE, D)")

barplot(counts, main="A) Simulation Replicate 1", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, cex.main = 2, ylim = c(0,1.1))

legend("topleft", c(expression("Real" ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression('P'[psi] * "(" * bolditalic(s[j]) * " | "* italic(f) * ", "* italic(D) *")")), col=ViridisColors, pch=19,bty="n")

# axis (2,at=c(0,2,4,6,8,10), labels = c(0,10^-8,10^-6,10^-4,10^-2,10^0), cex.axis = 1.5, cex.lab = 1.5)


Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression4 <- expression(paste("Inferred P(",bolditalic(s[j])," | 1%, DFE, D)"))
# legend("top",c(Expression, Expression2, Expression3, Expression4),pch=19,col=ColorViridis,cex=2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixFinalProbs[,i])
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        points((i - 1)* 4 + 2.5, Quantiles[1],col="black",pch=24, bg = "black", cex=1)
        points((i - 1)* 4 + 2.5, Quantiles[2],col="black", pch=25, bg = "black", cex=1)
        points((i - 1)* 4 + 2.5, CurrentMean,col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

points(2*4 + 2.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(2*4 + 2.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(2*4 + 2.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
CurrentMean <- mean(CurrentSums)

points(1*4 + 2.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(1*4 + 2.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(1*4 + 2.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 3.5, Quantiles[1],col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, Quantiles[2],col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, CurrentMean,col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(SumP_2Ns_OnePercent,c(0.05,0.95))
CurrentMean <- mean(SumP_2Ns_OnePercent)

points(2*4 + 3.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(2*4 + 3.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(2*4 + 3.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)

Quantiles <- quantile(CurrentSumsOnePercent,c(0.05,0.95))
CurrentMean <- mean(CurrentSumsOnePercent)

points(1*4 + 3.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(1*4 + 3.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(1*4 + 3.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)



# axis(1, at=c(1:DivisionsPlusOne), labels=FALSE,cex.lab=1,cex=1,cex.axis=1)
# axis(1, at=c(1,11,21,31), labels=Labels,cex.lab=2,cex=2,cex.axis=2,col.ticks="red")

############################################# Plot 2



ColorViridis <- viridis(3)
ViridisColors <- viridis(3)

Alpha = 0.184
Beta = 319.8626 * 10 * (1034/2)/10000 * 5

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

SelectionCoefficientListBoyko <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_2.txt")

### P (allele is at 1%)
## Ns sites = 3350065
## Reps = 160
## Total = 3350065 * 160 * 2 / 3 = 1.491016e-05

P_allele_at_OnePercent = 5328/(196.1504 * (1034 * 5170 + 24463 * 25)) # Original
Alpha = 0.11
Beta = 8636364 * 0.01 * (1034/2)/10000 * 5

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5 - 0.25,Alpha,scale=Beta) - pgamma(max((i-1)*2.5 - 0.25,0),Alpha,scale=Beta)
    #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(400 * (10000.0 * 5170 + 10000 * 25 * 24463/1034 ))) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientList <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_2.txt")

TwoNsValues <- SelectionCoefficientList$V2*1034

Breaks <- c(0,2.5*0:200 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ (NumberOfAllelesAt2Ns[1:50])


DFEParsOne <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

DFEParsTwo <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")

DFEPars <- rbind(DFEParsOne, DFEParsTwo)

MLE <- read.table("../Results/MLEDFEs/SelectionPopExpansionSLiMPopExpansionChangedRecRateBoykoDFE_2.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

DFEParameterNumber <- (Column[1]-1)*70 + Row[1]


P_Allele_Is_2Ns_given_OnePercent <- c()
# MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(nrow=1,ncol=50)

FourNs <- SelectionCoefficientListBoyko$V2 *1034 * 2

for (j in 1:100){
Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1
DFEParameterNumber <- MLE$V1[j] + 1
P_Allele_Is_2Ns_given_OnePercent <- c()
for (i in 1:Divisions){
    UpperBound <- i*5 + 2
    LowerBound <- (i-1)*5 + 3
    CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
}
ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent[1:Divisions] * P_allele_at_OnePercent
ProbsMouse <- ProbsMouse[1:Divisions] / Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]
if (sum (ProbsMouse[1:Divisions]) < 1.0 ){
ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
}else {
    ProbsMouse <- ProbsMouse[1:Divisions] / sum(ProbsMouse[1:Divisions])
    ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
}
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
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((400 * (10000.0 * 5170 + 10000 * 25 * 24463/1034 )))

Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:Divisions){
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

# pdf("../Figures/SuppFigureSX12_DFEf_toDFESLiM.pdf",width=10,height = 14)
# par(mar=c(4.1,5.1,2.6,2.1))
# par(mfrow = c(4,1))


PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

# plot(1:DivisionsPlusOne,c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "A) Constant size - Human DFE",cex.main = 2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixFinalProbs[,1],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
    #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(MatrixFinalProbs[,1],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

CurrentSums <- c()
for (i in 1:100){
    CurrentSums <- c(CurrentSums, sum(MatrixFinalProbs[i,2:20]))
}

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSums,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

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
for (i in 1:1){
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
    #    points(i,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

# CurrentSums <- c()
# for (i in 1:100){
#     CurrentSums <- c(CurrentSums, sum(OtherMatrixFinalProbs[i,2:20]))
# }

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSums,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
#segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


PartThree <- FinalMedian
# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
    #    points(i,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

CurrentSumsOnePercent <- c()
SumP_2Ns_OnePercent <- c()
for (i in 1:100){
    CurrentSumsOnePercent <- c(CurrentSumsOnePercent, sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,2:20]))
    SumP_2Ns_OnePercent <- c(SumP_2Ns_OnePercent, 1 - sum (MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20] ))
}

Quantiles <- quantile(CurrentSumsOnePercent,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSumsOnePercent,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

Quantiles <- quantile(SumP_2Ns_OnePercent,c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
Quantiles <- quantile(SumP_2Ns_OnePercent, c(0.5))
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
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
# for (i in 4:20){
# counts <- cbind(counts,c(PartOne[i],PartTwo[i],PartFour[i]))
# }

# counts <- cbind(counts,c(1-sum(PartOne[1:20]),1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))
AllPartTwo <- c(AllPartTwo,PartTwo[1:20],1-sum(PartTwo[1:20]))
counts[1,1] <- PartOne[1]
counts[1,2] <- sum(PartOne[2:20])
counts[1,3] <- 1-sum(PartOne[1:20])
counts[2,1] <- PartTwo[1]
counts[2,2] <- PartTwo[2]
counts[2,3] <- 1-sum(PartTwo[1:2])
counts[3,1] <- PartFour[1]
counts[3,2] <- PartFour[2]
counts[3,3] <- 1-sum(PartFour[1:2])


BoykoParams <- rbind(BoykoParams,counts[1,1:3])

colnames(counts) <- c("0-5", "5-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| 1%, DFE, D)")

barplot(counts, main="B) Simulation Replicate 2", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5, bty = "n"), cex.main = 2, ylim = c(0,1.1))


legend("topleft", c(expression("Real" ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression('P'[psi] * "(" * bolditalic(s[j]) * " | "* italic(f) * ", "* italic(D) *")")), col=ViridisColors, pch=19,bty="n")


# axis (2,at=c(0,2,4,6,8,10), labels = c(0,10^-8,10^-6,10^-4,10^-2,10^0), cex.axis = 1.5, cex.lab = 1.5)


Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression4 <- expression(paste("Inferred P(",bolditalic(s[j])," | 1%, DFE, D)"))
# legend("top",c(Expression, Expression2, Expression3, Expression4),pch=19,col=ColorViridis,cex=2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixFinalProbs[,i])
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        points((i - 1)* 4 + 2.5, Quantiles[1],col="black",pch=24, bg = "black", cex=1)
        points((i - 1)* 4 + 2.5, Quantiles[2],col="black", pch=25, bg = "black", cex=1)
        points((i - 1)* 4 + 2.5, CurrentMean,col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

points(2*4 + 2.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(2*4 + 2.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(2*4 + 2.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
CurrentMean <- mean(CurrentSums)

points(1*4 + 2.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(1*4 + 2.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(1*4 + 2.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 3.5, Quantiles[1],col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, Quantiles[2],col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, CurrentMean,col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(SumP_2Ns_OnePercent,c(0.05,0.95))
CurrentMean <- mean(SumP_2Ns_OnePercent)

points(2*4 + 3.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(2*4 + 3.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(2*4 + 3.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)

Quantiles <- quantile(CurrentSumsOnePercent,c(0.05,0.95))
CurrentMean <- mean(CurrentSumsOnePercent)

points(1*4 + 3.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(1*4 + 3.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(1*4 + 3.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)



# dev.off()


################################################################### Figure 3 ###################################################################



ColorViridis <- viridis(3)
ViridisColors <- viridis(3)

Alpha = 0.184
Beta = 319.8626 * 10 * (1146/2)/10000 * 5

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

SelectionCoefficientListBoyko <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_3.txt")

### P (allele is at 1%)
## Ns sites = 3350065
## Reps = 160
## Total = 3350065 * 160 * 2 / 3 = 1.491016e-05

P_allele_at_OnePercent = 5328/((196.1504 * (1146 * 5730 + 26374 * 24))) # Original
Alpha = 0.11
Beta = 8636364 * 0.01 * (1146/2)/10000 * 5

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5 - 0.25,Alpha,scale=Beta) - pgamma(max((i-1)*2.5 - 0.25,0),Alpha,scale=Beta)
    #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(400 * (10000.0 * 5730 + 10000 * 24 * 26374/1146 ))) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientList <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_3.txt")

TwoNsValues <- SelectionCoefficientList$V2*1146

Breaks <- c(0,2.5*0:200 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ (NumberOfAllelesAt2Ns[1:50])


DFEParsOne <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

DFEParsTwo <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")

DFEPars <- rbind(DFEParsOne, DFEParsTwo)

MLE <- read.table("../Results/MLEDFEs/SelectionPopExpansionSLiMPopExpansionChangedRecRateBoykoDFE_3.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

DFEParameterNumber <- (Column[1]-1)*70 + Row[1]


P_Allele_Is_2Ns_given_OnePercent <- c()
# MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(nrow=1,ncol=50)

FourNs <- SelectionCoefficientListBoyko$V2 *1146 * 2

for (j in 1:100){
Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1
DFEParameterNumber <- MLE$V1[j] + 1
P_Allele_Is_2Ns_given_OnePercent <- c()
for (i in 1:Divisions){
    UpperBound <- i*5 + 2
    LowerBound <- (i-1)*5 + 3
    CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
}
ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent[1:Divisions] * P_allele_at_OnePercent
ProbsMouse <- ProbsMouse[1:Divisions] / Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]
if (sum (ProbsMouse[1:Divisions]) < 1.0 ){
ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
}else {
    ProbsMouse <- ProbsMouse[1:Divisions] / sum(ProbsMouse[1:Divisions])
    ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
}

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
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((400 * (10000.0 * 5730 + 10000 * 24 * 26374/1146 )))

Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:Divisions){
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

# pdf("../Figures/SuppFigureSX12_DFEf_toDFESLiM.pdf",width=10,height = 14)
# par(mar=c(4.1,5.1,2.6,2.1))
# par(mfrow = c(4,1))



PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

# plot(1:DivisionsPlusOne,c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "A) Constant size - Human DFE",cex.main = 2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixFinalProbs[,1],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
    #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(MatrixFinalProbs[,1],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

CurrentSums <- c()
for (i in 1:100){
    CurrentSums <- c(CurrentSums, sum(MatrixFinalProbs[i,2:20]))
}

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSums,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

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
for (i in 1:1){
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
    #    points(i,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

# CurrentSums <- c()
# for (i in 1:100){
#     CurrentSums <- c(CurrentSums, sum(OtherMatrixFinalProbs[i,2:20]))
# }

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSums,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
#segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


PartThree <- FinalMedian
# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
    #    points(i,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

CurrentSumsOnePercent <- c()
SumP_2Ns_OnePercent <- c()
for (i in 1:100){
    CurrentSumsOnePercent <- c(CurrentSumsOnePercent, sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,2:20]))
    SumP_2Ns_OnePercent <- c(SumP_2Ns_OnePercent, 1 - sum (MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20] ))
}

Quantiles <- quantile(CurrentSumsOnePercent,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSumsOnePercent,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

Quantiles <- quantile(SumP_2Ns_OnePercent,c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
Quantiles <- quantile(SumP_2Ns_OnePercent, c(0.5))
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
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
# for (i in 4:20){
# counts <- cbind(counts,c(PartOne[i],PartTwo[i],PartFour[i]))
# }

# counts <- cbind(counts,c(1-sum(PartOne[1:20]),1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))
AllPartTwo <- c(AllPartTwo,PartTwo[1:20],1-sum(PartTwo[1:20]))
counts[1,1] <- PartOne[1]
counts[1,2] <- sum(PartOne[2:20])
counts[1,3] <- 1-sum(PartOne[1:20])
counts[2,1] <- PartTwo[1]
counts[2,2] <- PartTwo[2]
counts[2,3] <- 1-sum(PartTwo[1:2])
counts[3,1] <- PartFour[1]
counts[3,2] <- PartFour[2]
counts[3,3] <- 1-sum(PartFour[1:2])


BoykoParams <- rbind(BoykoParams,counts[1,1:3])

colnames(counts) <- c("0-5", "5-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| 1%, DFE, D)")

barplot(counts, main="C) Simulation Replicate 3", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5, bty = "n"), cex.main = 2, ylim = c(0,1.1))

legend("topleft", c(expression("Real" ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression('P'[psi] * "(" * bolditalic(s[j]) * " | "* italic(f) * ", "* italic(D) *")")), col=ViridisColors, pch=19,bty="n")


# axis (2,at=c(0,2,4,6,8,10), labels = c(0,10^-8,10^-6,10^-4,10^-2,10^0), cex.axis = 1.5, cex.lab = 1.5)


Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression4 <- expression(paste("Inferred P(",bolditalic(s[j])," | 1%, DFE, D)"))
# legend("top",c(Expression, Expression2, Expression3, Expression4),pch=19,col=ColorViridis,cex=2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixFinalProbs[,i])
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        points((i - 1)* 4 + 2.5, Quantiles[1],col="black",pch=24, bg = "black", cex=1)
        points((i - 1)* 4 + 2.5, Quantiles[2],col="black", pch=25, bg = "black", cex=1)
        points((i - 1)* 4 + 2.5, CurrentMean,col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

points(2*4 + 2.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(2*4 + 2.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(2*4 + 2.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
CurrentMean <- mean(CurrentSums)

points(1*4 + 2.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(1*4 + 2.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(1*4 + 2.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 3.5, Quantiles[1],col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, Quantiles[2],col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, CurrentMean,col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(SumP_2Ns_OnePercent,c(0.05,0.95))
CurrentMean <- mean(SumP_2Ns_OnePercent)

points(2*4 + 3.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(2*4 + 3.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(2*4 + 3.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)

Quantiles <- quantile(CurrentSumsOnePercent,c(0.05,0.95))
CurrentMean <- mean(CurrentSumsOnePercent)

points(1*4 + 3.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(1*4 + 3.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(1*4 + 3.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)




################################################################### Figure 4 ###################################################################

ColorViridis <- viridis(3)
ViridisColors <- viridis(3)

Alpha = 0.184
Beta = 319.8626 * 10 * (784/2)/10000 * 5

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

SelectionCoefficientListBoyko <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_4.txt")

### P (allele is at 1%)
## Ns sites = 3350065
## Reps = 160
## Total = 3350065 * 160 * 2 / 3 = 1.491016e-05

P_allele_at_OnePercent = 5328/(196.1504 * (784 * 3920 + 26571 * 26)) # Original
Alpha = 0.11
Beta = 8636364 * 0.01 * (784/2)/10000 * 5

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5 - 0.25,Alpha,scale=Beta) - pgamma(max((i-1)*2.5 - 0.25,0),Alpha,scale=Beta)
    #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(400 * (10000.0 * 3920 + 10000 * 26 * 26571/784 ))) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

SelectionCoefficientList <- read.table("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_4.txt")

TwoNsValues <- SelectionCoefficientList$V2*784

Breaks <- c(0,2.5*0:200 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ (NumberOfAllelesAt2Ns[1:50])


DFEParsOne <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

DFEParsTwo <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")

DFEPars <- rbind(DFEParsOne, DFEParsTwo)

MLE <- read.table("../Results/MLEDFEs/SelectionPopExpansionSLiMPopExpansionChangedRecRateBoykoDFE_4.txt")

Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1

DFEParameterNumber <- (Column[1]-1)*70 + Row[1]


P_Allele_Is_2Ns_given_OnePercent <- c()
# MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(nrow=1,ncol=50)

FourNs <- SelectionCoefficientListBoyko$V2 *784 * 2

for (j in 1:100){
Row <- ( MLE$V1 ) %% 70 + 1
Column <- floor(( MLE$V1 ) / 70) + 1
DFEParameterNumber <- MLE$V1[j] + 1
P_Allele_Is_2Ns_given_OnePercent <- c()
for (i in 1:Divisions){
    UpperBound <- i*5 + 2
    LowerBound <- (i-1)*5 + 3
    CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
}
ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent[1:Divisions] * P_allele_at_OnePercent
ProbsMouse <- ProbsMouse[1:Divisions] / Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]
if (sum (ProbsMouse[1:Divisions]) < 1.0 ){
ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
}else {
    ProbsMouse <- ProbsMouse[1:Divisions] / sum(ProbsMouse[1:Divisions])
    ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
}
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
LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((400 * (10000.0 * 3920 + 10000 * 26 * 26571/784 )))

Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:Divisions){
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

# pdf("../Figures/SuppFigureSX12_DFEf_toDFESLiM.pdf",width=10,height = 14)
# par(mar=c(4.1,5.1,2.6,2.1))
# par(mfrow = c(4,1))


PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

# plot(1:DivisionsPlusOne,c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "A) Constant size - Human DFE",cex.main = 2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixFinalProbs[,1],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
    #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(MatrixFinalProbs[,1],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

CurrentSums <- c()
for (i in 1:100){
    CurrentSums <- c(CurrentSums, sum(MatrixFinalProbs[i,2:20]))
}

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSums,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

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
for (i in 1:1){
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
    #    points(i,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
    Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

# CurrentSums <- c()
# for (i in 1:100){
#     CurrentSums <- c(CurrentSums, sum(OtherMatrixFinalProbs[i,2:20]))
# }

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSums,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
#segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])


PartThree <- FinalMedian
# lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
    #    points(i,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

CurrentSumsOnePercent <- c()
SumP_2Ns_OnePercent <- c()
for (i in 1:100){
    CurrentSumsOnePercent <- c(CurrentSumsOnePercent, sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,2:20]))
    SumP_2Ns_OnePercent <- c(SumP_2Ns_OnePercent, 1 - sum (MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20] ))
}

Quantiles <- quantile(CurrentSumsOnePercent,c(0.05,0.95))
#segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
#    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
#    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
Quantiles <- quantile(CurrentSumsOnePercent,c(0.5))
FinalMedian <- c(FinalMedian,Quantiles[1])

Quantiles <- quantile(SumP_2Ns_OnePercent,c(0.05,0.95))
# segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
#points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
#points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
Quantiles <- quantile(SumP_2Ns_OnePercent, c(0.5))
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
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
# for (i in 4:20){
# counts <- cbind(counts,c(PartOne[i],PartTwo[i],PartFour[i]))
# }

# counts <- cbind(counts,c(1-sum(PartOne[1:20]),1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))
AllPartTwo <- c(AllPartTwo,PartTwo[1:20],1-sum(PartTwo[1:20]))
counts[1,1] <- PartOne[1]
counts[1,2] <- sum(PartOne[2:20])
counts[1,3] <- 1-sum(PartOne[1:20])
counts[2,1] <- PartTwo[1]
counts[2,2] <- PartTwo[2]
counts[2,3] <- 1-sum(PartTwo[1:2])
counts[3,1] <- PartFour[1]
counts[3,2] <- PartFour[2]
counts[3,3] <- 1-sum(PartFour[1:2])


BoykoParams <- rbind(BoykoParams,counts[1,1:3])

colnames(counts) <- c("0-5", "5-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| 1%, DFE, D)")

barplot(counts, main="D) Simulation Replicate 4", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5, bty = "n"), cex.main = 2, ylim = c(0,1.1))

legend("topleft", c(expression("Real" ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression('P'[psi] * "(" * bolditalic(s[j]) * " | "* italic(f) * ", "* italic(D) *")")), col=ViridisColors, pch=19,bty="n")


# axis (2,at=c(0,2,4,6,8,10), labels = c(0,10^-8,10^-6,10^-4,10^-2,10^0), cex.axis = 1.5, cex.lab = 1.5)


Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression4 <- expression(paste("Inferred P(",bolditalic(s[j])," | 1%, DFE, D)"))
# legend("top",c(Expression, Expression2, Expression3, Expression4),pch=19,col=ColorViridis,cex=2)

FinalMedian <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixFinalProbs[,i])
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        points((i - 1)* 4 + 2.5, Quantiles[1],col="black",pch=24, bg = "black", cex=1)
        points((i - 1)* 4 + 2.5, Quantiles[2],col="black", pch=25, bg = "black", cex=1)
        points((i - 1)* 4 + 2.5, CurrentMean,col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

points(2*4 + 2.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(2*4 + 2.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(2*4 + 2.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)

Quantiles <- quantile(CurrentSums,c(0.05,0.95))
CurrentMean <- mean(CurrentSums)

points(1*4 + 2.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(1*4 + 2.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(1*4 + 2.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:1){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 3.5, Quantiles[1],col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, Quantiles[2],col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 3.5, CurrentMean,col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(SumP_2Ns_OnePercent,c(0.05,0.95))
CurrentMean <- mean(SumP_2Ns_OnePercent)

points(2*4 + 3.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(2*4 + 3.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(2*4 + 3.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)

Quantiles <- quantile(CurrentSumsOnePercent,c(0.05,0.95))
CurrentMean <- mean(CurrentSumsOnePercent)

points(1*4 + 3.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
points(1*4 + 3.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
points(1*4 + 3.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)


dev.off()

AncPopSize <- c(784,784,784,784,1443,1166,1110,760,959,739)
SumValuesOne <- c((784 * 3920 + 26571 * 26),(784 * 3920 + 26571 * 26),(784 * 3920 + 26571 * 26),(784 * 3920 + 26571 * 26),(1443 * 7215 + 20341 * 24),(1116 * 5830 + 23992 * 27),(1110 * 5550 + 22775 * 24),(760 * 3800 + 28031 * 26),(959 * 4795 + 23563 * 27),(739 * 3695 + 27679 * 27))
MutNumber <- c((784 * 3920 + 26571 * 26),(784 * 3920 + 26571 * 26),(784 * 3920 + 26571 * 26),(784 * 3920 + 26571 * 26),(10000 * 7215 + 10000 * 24 * 20341/1443),(10000 * 5830 + 10000 * 27 * 23992/1166),(10000 * 5550 + 10000 * 24 * 22775 / 1110),(10000 * 3800 + 10000 * 26 * 28031/760),(10000 * 4795 + 10000 * 27 * 23563/959),(10000 * 3695 + 10000 * 27 * 27679/739))

PlotTitle <- c("E) Simulation Replicate 5", "E) Simulation Replicate 5", "E) Simulation Replicate 5", "E) Simulation Replicate 5", "E) Simulation Replicate 5", "F) Simulation Replicate 6", "G) Simulation Replicate 7", "H) Simulation Replicate 8", "I) Simulation Replicate 9", "J) Simulation Replicate 10")

pdf("../Figures/SuppFigure26_DFEf_toDFESLiMThreeBins_10Sims.pdf",width=10,height = 14 + 14 * 2/6)
par(mar=c(4.1,5.1,2.6,2.1))
par(mfrow = c(6,1))


for (k in 5:10){

    ColorViridis <- viridis(3)
    ViridisColors <- viridis(3)

    Alpha = 0.184
    Beta = 319.8626 * 10 * (AncPopSize[k]/2)/10000 * 5

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
    File <- paste("../Results/ExitSValues/ExitOnePercentSValuesTestBoyko_",k,".txt", sep ="")
    SelectionCoefficientListBoyko <- read.table(File)

    ### P (allele is at 1%)
    ## Ns sites = 3350065
    ## Reps = 160
    ## Total = 3350065 * 160 * 2 / 3 = 1.491016e-05

    P_allele_at_OnePercent = 5328/(196.1504 * SumValuesOne[k]) # Original
    Alpha = 0.11
    Beta = 8636364 * 0.01 * (AncPopSize[k]/2)/10000 * 5

    # P_Allele_Is_2Ns <- c()
    NumberOfAllelesAt2Ns <- c()
    RealProbs <- c()
    # P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
    for (i in 1:200){
        # print (i)
        Prob <- pgamma(i*2.5 - 0.25,Alpha,scale=Beta) - pgamma(max((i-1)*2.5 - 0.25,0),Alpha,scale=Beta)
        #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
        NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(400 * MutNumber[k])) # Original Test
        #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
    }

    SelectionCoefficientList <- read.table(File)

    TwoNsValues <- SelectionCoefficientList$V2*AncPopSize[k]

    Breaks <- c(0,2.5*0:200 + 2.25)

    Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
    Counts_At_OnePercent_Given2Ns <- Check$counts

    Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ (NumberOfAllelesAt2Ns[1:50])


    DFEParsOne <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

    DFEParsTwo <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")

    DFEPars <- rbind(DFEParsOne, DFEParsTwo)
    
    File <- paste("../Results/MLEDFEs/SelectionPopExpansionSLiMPopExpansionChangedRecRateBoykoDFE_",k,".txt", sep ="")
    MLE <- read.table(File)

    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1

    DFEParameterNumber <- (Column[1]-1)*70 + Row[1]


    P_Allele_Is_2Ns_given_OnePercent <- c()
    # MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(nrow=1,ncol=50)

    FourNs <- SelectionCoefficientListBoyko$V2 * AncPopSize[k] * 2

    for (j in 1:100){
    Row <- ( MLE$V1 ) %% 70 + 1
    Column <- floor(( MLE$V1 ) / 70) + 1
    DFEParameterNumber <- MLE$V1[j] + 1
    P_Allele_Is_2Ns_given_OnePercent <- c()
    for (i in 1:Divisions){
        UpperBound <- i*5 + 2
        LowerBound <- (i-1)*5 + 3
        CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent[1:Divisions] * P_allele_at_OnePercent
    ProbsMouse <- ProbsMouse[1:Divisions] / Probabilities_At_One_Percent_Given_2NsMouse[1:Divisions]
    if (sum (ProbsMouse[1:Divisions]) < 1.0 ){
    ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
    }else {
        ProbsMouse <- ProbsMouse[1:Divisions] / sum(ProbsMouse[1:Divisions])
        ProbsMouse[DivisionsPlusOne] <- 1 - sum (ProbsMouse[1:Divisions])
    }
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
    LastAlleleNumber <- (1-pgamma(GammaLimit,Alpha,scale=Beta))* ((400 * MutNumber[k]))

    Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:Divisions],sum(Counts_At_OnePercent_Given2Ns[DivisionsPlusOne:200]))/ c((NumberOfAllelesAt2Ns[1:Divisions]),LastAlleleNumber )


    for (j in 1:100){
        Row <- ( MLE$V1 ) %% 70 + 1
        Column <- floor(( MLE$V1 ) / 70) + 1
        DFEParameterNumber <- (Column[j]-1)*70 + Row[j]
        P_Allele_Is_2Ns_given_OnePercent <- c()
        for (i in 1:Divisions){
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

    # pdf("../Figures/SuppFigureSX12_DFEf_toDFESLiM.pdf",width=10,height = 14)
    # par(mar=c(4.1,5.1,2.6,2.1))
    # par(mfrow = c(4,1))


    PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

    # plot(1:DivisionsPlusOne,c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions])), col=ColorViridis[1], ylim=c(0,1.0), xaxt="n", ylab="Probability", xlab="4Ns",lwd=5,cex.lab=2,cex.axis=2,cex.lab=2, main = "A) Constant size - Human DFE",cex.main = 2)

    FinalMedian <- c()
    for (i in 1:1){
        Quantiles <- quantile(MatrixFinalProbs[,1],c(0.05,0.95))
        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
        #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
        Quantiles <- quantile(MatrixFinalProbs[,1],c(0.5))
        FinalMedian <- c(FinalMedian,Quantiles[1])
    }

    CurrentSums <- c()
    for (i in 1:100){
        CurrentSums <- c(CurrentSums, sum(MatrixFinalProbs[i,2:20]))
    }

    Quantiles <- quantile(CurrentSums,c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
    #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(CurrentSums,c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])

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
    for (i in 1:1){
        Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.05,0.95))
        #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
        #    points(i,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
        #    points(i,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
        Quantiles <- quantile(OtherMatrixFinalProbs[,i],c(0.5))
        FinalMedian <- c(FinalMedian,Quantiles[1])
    }

    # CurrentSums <- c()
    # for (i in 1:100){
    #     CurrentSums <- c(CurrentSums, sum(OtherMatrixFinalProbs[i,2:20]))
    # }

    Quantiles <- quantile(CurrentSums,c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
    #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(CurrentSums,c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])


    Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
    #segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[3], lwd = 3, lty=2)
    #points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[3],pch=25, bg = ColorViridis[3],cex=1.5)
    #points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[3],pch=24, bg = ColorViridis[3],cex=1.5)
    Quantiles <- quantile(OtherMatrixFinalProbs[,DivisionsPlusOne],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])


    PartThree <- FinalMedian
    # lines(1:DivisionsPlusOne,FinalMedian,col=ColorViridis[3],lwd=2)

    FinalMedian <- c()
    for (i in 1:1){
        Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
        #    segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
        #    points(i,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
        #    points(i,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
        Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
        FinalMedian <- c(FinalMedian,Quantiles[1])
    }

    CurrentSumsOnePercent <- c()
    SumP_2Ns_OnePercent <- c()
    for (i in 1:100){
        CurrentSumsOnePercent <- c(CurrentSumsOnePercent, sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,2:20]))
        SumP_2Ns_OnePercent <- c(SumP_2Ns_OnePercent, 1 - sum (MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20] ))
    }

    Quantiles <- quantile(CurrentSumsOnePercent,c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points(i,Quantiles[1],col=ColorViridis[2],pch=25, bg = ColorViridis[2],cex=2)
    #    points(i,Quantiles[2],col=ColorViridis[2],pch=24, bg = ColorViridis[2],cex=2)
    Quantiles <- quantile(CurrentSumsOnePercent,c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])

    Quantiles <- quantile(SumP_2Ns_OnePercent,c(0.05,0.95))
    # segments (31, Quantiles[1],x1=31,y1=Quantiles[2],col=ColorViridis[4], lwd = 3, lty=2)
    #points(DivisionsPlusOne,Quantiles[1],col=ColorViridis[4],pch=25, bg = ColorViridis[4])
    #points(DivisionsPlusOne,Quantiles[2],col=ColorViridis[4],pch=24, bg = ColorViridis[4])
    Quantiles <- quantile(SumP_2Ns_OnePercent, c(0.5))
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
    # counts <- rbind(counts,c(1,2,3))
    # counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
    # for (i in 4:20){
    # counts <- cbind(counts,c(PartOne[i],PartTwo[i],PartFour[i]))
    # }

    # counts <- cbind(counts,c(1-sum(PartOne[1:20]),1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))
    AllPartTwo <- c(AllPartTwo,PartTwo[1:20],1-sum(PartTwo[1:20]))
    counts[1,1] <- PartOne[1]
    counts[1,2] <- sum(PartOne[2:20])
    counts[1,3] <- 1-sum(PartOne[1:20])
    counts[2,1] <- PartTwo[1]
    counts[2,2] <- PartTwo[2]
    counts[2,3] <- 1-sum(PartTwo[1:2])
    counts[3,1] <- PartFour[1]
    counts[3,2] <- PartFour[2]
    counts[3,3] <- 1-sum(PartFour[1:2])


    BoykoParams <- rbind(BoykoParams,counts[1,1:3])

    colnames(counts) <- c("0-5", "5-100", ">100")
    rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| 1%, DFE, D)")

    barplot(counts, main=PlotTitle[k], ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5, bty = "n"), cex.main = 2, ylim = c(0,1.1))

    legend("topleft", c(expression("Real" ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression('P'[psi] * "(" * bolditalic(s[j]) * " | "* italic(f) * ", "* italic(D) *")")), col=ViridisColors, pch=19,bty="n")


    # axis (2,at=c(0,2,4,6,8,10), labels = c(0,10^-8,10^-6,10^-4,10^-2,10^0), cex.axis = 1.5, cex.lab = 1.5)


    Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
    Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
    Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
    Expression4 <- expression(paste("Inferred P(",bolditalic(s[j])," | 1%, DFE, D)"))
    # legend("top",c(Expression, Expression2, Expression3, Expression4),pch=19,col=ColorViridis,cex=2)

    FinalMedian <- c()
    for (i in 1:1){
        Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
        CurrentMean <- mean(MatrixFinalProbs[,i])
        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
            points((i - 1)* 4 + 2.5, Quantiles[1],col="black",pch=24, bg = "black", cex=1)
            points((i - 1)* 4 + 2.5, Quantiles[2],col="black", pch=25, bg = "black", cex=1)
            points((i - 1)* 4 + 2.5, CurrentMean,col="black", pch=8, bg = "black", cex=1)
        Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
        FinalMedian <- c(FinalMedian,Quantiles[1])
    }

    Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
    CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

    points(2*4 + 2.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
    points(2*4 + 2.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
    points(2*4 + 2.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)

    Quantiles <- quantile(CurrentSums,c(0.05,0.95))
    CurrentMean <- mean(CurrentSums)

    points(1*4 + 2.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
    points(1*4 + 2.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
    points(1*4 + 2.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)


    FinalMedian <- c()
    TotalDifference <- c()
    for (i in 1:1){
        Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
        CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        points((i - 1)* 4 + 3.5, Quantiles[1],col="black",pch=24, bg = "black", cex=1)
        points((i - 1)* 4 + 3.5, Quantiles[2],col="black", pch=25, bg = "black", cex=1)
        points((i - 1)* 4 + 3.5, CurrentMean,col="black", pch=8, bg = "black", cex=1)
        Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
        FinalMedian <- c(FinalMedian,Quantiles[1])
        TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
    }

    Quantiles <- quantile(SumP_2Ns_OnePercent,c(0.05,0.95))
    CurrentMean <- mean(SumP_2Ns_OnePercent)

    points(2*4 + 3.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
    points(2*4 + 3.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
    points(2*4 + 3.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)

    Quantiles <- quantile(CurrentSumsOnePercent,c(0.05,0.95))
    CurrentMean <- mean(CurrentSumsOnePercent)

    points(1*4 + 3.5, Quantiles[1], col="black", pch=24, bg = "black", cex=1)
    points(1*4 + 3.5, Quantiles[2], col="black", pch=25, bg = "black", cex=1)
    points(1*4 + 3.5, CurrentMean, col="black", pch=8, bg = "black", cex=1)
}

dev.off()

############################################################################### Full data  #################################################################################

TotalDifferences <- matrix(nrow=1000,ncol=21)
for (i in 1:1000){
    j=1
        Integer <- floor ( (i - 1 ) / 100) + 1
        TotalDifferences[i,j] <- DifferenceMatrix[i,j] - BoykoParams[Integer,j]
        j=1
        Integer <- floor ( (i - 1 ) / 100) + 1
        TotalDifferences[i,2] <- sum(DifferenceMatrix[i,2:20]) - sum(BoykoParams[Integer,2])
    j=1
        Integer <- floor ( (i - 1 ) / 100) + 1
        TotalDifferences[i,3] <- DifferenceMatrix[i,21] - BoykoParams[Integer,3]
}

expression("Real" ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")" * " - Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")")

pdf("../Figures/SuppFigure27_BeanplotDifferencesThreeBins.pdf",width=10,height = 14)
par(mar=c(5.1,6.1,2.6,2.1))
beanplot(TotalDifferences[,1], TotalDifferences[,2], TotalDifferences[,3], ylab= expression("Inferred " ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")" * " - Real "  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")") ,xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), cex.axis=2.2,cex.lab=2.5,cex.main=2,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), border = "#CAB2D6", names=colnames(counts),  maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5)
abline(h=0, lty = 2)
dev.off()

Vector <- seq(from = 1, to = 100, by = 1)

for (i in 1:1000){
    Vector[i] <- sum(TotalDifferences[i,2:20])
}
