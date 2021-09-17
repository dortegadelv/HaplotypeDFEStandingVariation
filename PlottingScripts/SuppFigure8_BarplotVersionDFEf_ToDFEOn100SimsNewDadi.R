library(here)
library(viridis)
library(beanplot)

Divisions <- 20
DivisionsPlusOne <- Divisions + 1

################################################### Two plots on same place ############################

ColorViridis <- viridis(5)
ViridisColors <- viridis(5)

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

##################################

BetaListFile <- read.table("../Results/dadiInferences/ConstantPopSizeBoykoAlpha.txt")
AlphaListFile <- read.table("../Results/dadiInferences/ConstantPopSizeBoykoBeta.txt")

P_Allele_Is_2NsDadi <- matrix(nrow=100, ncol=200)
#NumberOfAllelesAt2Ns <- c()
# RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (j in 1:100){
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j]) - pgamma((i-1)*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j])
    P_Allele_Is_2NsDadi[j,i] <- Prob
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

    Prob <- 1 - sum(P_Allele_Is_2NsDadi[j,1:20])
    P_Allele_Is_2NsDadi[j,21] <- Prob
}

Partdadi <- c()
UpQuantile <- c()
LowQuantile <- c()
Meandadi <- c()
for (i in 1:21){
    # print (i)
    Prob <- median(P_Allele_Is_2NsDadi[1:100,i])
    Quantile <- quantile(P_Allele_Is_2NsDadi[1:100,i], probs = c(0.05, 0.95))
    Partdadi <- c(Partdadi, Prob)
    UpQuantile <- c(UpQuantile, Quantile[1])
    LowQuantile <- c(LowQuantile, Quantile[2])
    Meandadi <- c(Meandadi, mean(P_Allele_Is_2NsDadi[1:100,i]))
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

# PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

BetaListFile <- read.table("../Results/dadiInferences/ConstantPopSizeBoykoSmallAlpha.txt")
AlphaListFile <- read.table("../Results/dadiInferences/ConstantPopSizeBoykoSmallBeta.txt")

P_Allele_Is_2NsDadiSmall <- matrix(nrow=100, ncol=200)
#NumberOfAllelesAt2Ns <- c()
# RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (j in 1:100){
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j]) - pgamma((i-1)*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j])
    P_Allele_Is_2NsDadiSmall[j,i] <- Prob
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

    Prob <- 1 - sum(P_Allele_Is_2NsDadiSmall[j,1:20])
    P_Allele_Is_2NsDadiSmall[j,21] <- Prob
}

Partdadismall <- c()
UpQuantileSmall <- c()
LowQuantileSmall <- c()
MeandadiSmall <- c()
for (i in 1:21){
    # print (i)
    Prob <- median(P_Allele_Is_2NsDadiSmall[1:100,i])
    Quantile <- quantile(P_Allele_Is_2NsDadiSmall[1:100,i], probs = c(0.05, 0.95))
    Partdadismall <- c(Partdadismall, Prob)
    UpQuantileSmall <- c(UpQuantileSmall, Quantile[1])
    LowQuantileSmall <- c(LowQuantileSmall, Quantile[2])
    MeandadiSmall <- c(MeandadiSmall, mean(P_Allele_Is_2NsDadiSmall[1:100,i]))
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

# PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))


##################################


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

pdf("../Figures/SuppFigure8_DFEf_toDFEOn100Simsdadi.pdf",width=10,height = 14)
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
counts <- rbind(counts,c(1,2,3))
counts <- rbind(counts,c(1,2,3))
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
for (i in 4:20){
counts <- cbind(counts,c(PartOne[i],Partdadi[i],Partdadismall[i],PartTwo[i],PartFour[i]))
}

counts <- cbind(counts,c(1-sum(PartOne[1:20]),Partdadi[21],Partdadismall[21],1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))

counts[1,1] <- PartOne[1]
counts[1,2] <- PartOne[2]
counts[1,3] <- PartOne[3]
counts[4,1] <- PartTwo[1]
counts[4,2] <- PartTwo[2]
counts[4,3] <- PartTwo[3]
counts[5,1] <- PartFour[1]
counts[5,2] <- PartFour[2]
counts[5,3] <- PartFour[3]
counts[2,1] <- Partdadi[1]
counts[2,2] <- Partdadi[2]
counts[2,3] <- Partdadi[3]
counts[3,1] <- Partdadismall[1]
counts[3,2] <- Partdadismall[2]
counts[3,3] <- Partdadismall[3]

BoykoParams <- PartOne

colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50","50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| DFE, D) with dadi. Full SFS with between 300-500 1% frequency variants", "Inferred P(4Ns| DFE, D) with dadi. Full SFS with 300-500 SNPs after taking the segregating sites with variants at all frequencies.", "Inferred P(4Ns| 1%, DFE, D)")

op <- par(cex = 0.4)

barplot(log10(counts) - log10(0.0000000001), main="A) Constant Size - Human DFE", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, legend = c(expression("Real" ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"),  expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ") with fitdadi. Full SFS with between 300-500 1% frequency variants"),  expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ") with fitdadi. Full SFS with 300-500 SNPs after taking the segregating sites with variants at all frequencies"), expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ") with our method using data from 300 1% frequency variants"), expression('P'[psi] * "(" * bolditalic(s[j]) * " | "* italic(f) * ", "* italic(D) *") with our method using data from 300 1% frequency variants")), beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5, bty = "n"), cex.main = 2, ylim = c(0,12), yaxt="n",cex = 0.5)

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
        points((i - 1)* 6 + 4.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
        points((i - 1)* 6 + 4.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
        points((i - 1)* 6 + 4.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

points(Divisions*6 + 4.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 4.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 4.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 5.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 5.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 5.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 5.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 5.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 5.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 2.5, log10(UpQuantile[i]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 2.5, log10(LowQuantile[i]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 2.5, log10(Meandadi[i]) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 2.5, log10(UpQuantile[21]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 2.5, log10(LowQuantile[21]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 2.5, log10(Meandadi[21]) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)

FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 3.5, log10(UpQuantileSmall[i]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 3.5, log10(LowQuantileSmall[i]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 3.5, log10(MeandadiSmall[i]) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 3.5, log10(UpQuantileSmall[21]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 3.5, log10(LowQuantileSmall[21]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 3.5, log10(MeandadiSmall[21]) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)




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


##################################

BetaListFile <- read.table("../Results/dadiInferences/ConstantPopSizeMouseAlpha.txt")
AlphaListFile <- read.table("../Results/dadiInferences/ConstantPopSizeMouseBeta.txt")

P_Allele_Is_2NsDadi <- matrix(nrow=100, ncol=200)
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (j in 1:100){
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j]) - pgamma((i-1)*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j])
    P_Allele_Is_2NsDadi[j,i] <- Prob
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

    Prob <- 1 - sum(P_Allele_Is_2NsDadi[j,1:20])
    P_Allele_Is_2NsDadi[j,21] <- Prob
}

Partdadi <- c()
UpQuantile <- c()
LowQuantile <- c()
Meandadi <- c()
for (i in 1:21){
    # print (i)
    Prob <- median(P_Allele_Is_2NsDadi[1:100,i])
    Quantile <- quantile(P_Allele_Is_2NsDadi[1:100,i], probs = c(0.05, 0.95))
    Partdadi <- c(Partdadi, Prob)
    UpQuantile <- c(UpQuantile, Quantile[1])
    LowQuantile <- c(LowQuantile, Quantile[2])
    Meandadi <- c(Meandadi, mean(P_Allele_Is_2NsDadi[1:100,i]))
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

# PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

BetaListFile <- read.table("../Results/dadiInferences/ConstantPopSizeMouseSmallAlpha.txt")
AlphaListFile <- read.table("../Results/dadiInferences/ConstantPopSizeMouseSmallBeta.txt")

P_Allele_Is_2NsDadiSmall <- matrix(nrow=100, ncol=200)
#NumberOfAllelesAt2Ns <- c()
# RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (j in 1:100){
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j]) - pgamma((i-1)*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j])
    P_Allele_Is_2NsDadiSmall[j,i] <- Prob
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

    Prob <- 1 - sum(P_Allele_Is_2NsDadiSmall[j,1:20])
    P_Allele_Is_2NsDadiSmall[j,21] <- Prob
}

Partdadismall <- c()
UpQuantileSmall <- c()
LowQuantileSmall <- c()
MeandadiSmall <- c()
for (i in 1:21){
    # print (i)
    Prob <- median(P_Allele_Is_2NsDadiSmall[1:100,i])
    Quantile <- quantile(P_Allele_Is_2NsDadiSmall[1:100,i], probs = c(0.05, 0.95))
    Partdadismall <- c(Partdadismall, Prob)
    UpQuantileSmall <- c(UpQuantileSmall, Quantile[1])
    LowQuantileSmall <- c(LowQuantileSmall, Quantile[2])
    MeandadiSmall <- c(MeandadiSmall, mean(P_Allele_Is_2NsDadiSmall[1:100,i]))
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

# PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))



##################################



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
counts <- rbind(counts,c(1,2,3))
counts <- rbind(counts,c(1,2,3))
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
for (i in 4:20){
counts <- cbind(counts,c(PartOne[i],Partdadi[i],Partdadismall[i],PartTwo[i],PartFour[i]))
}

counts <- cbind(counts,c(1-sum(PartOne[1:20]),Partdadi[21],Partdadismall[21],1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))

counts[1,1] <- PartOne[1]
counts[1,2] <- PartOne[2]
counts[1,3] <- PartOne[3]
counts[4,1] <- PartTwo[1]
counts[4,2] <- PartTwo[2]
counts[4,3] <- PartTwo[3]
counts[5,1] <- PartFour[1]
counts[5,2] <- PartFour[2]
counts[5,3] <- PartFour[3]
counts[2,1] <- Partdadi[1]
counts[2,2] <- Partdadi[2]
counts[2,3] <- Partdadi[3]
counts[3,1] <- Partdadismall[1]
counts[3,2] <- Partdadismall[2]
counts[3,3] <- Partdadismall[3]

BoykoParams <- PartOne


colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50","50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| DFE, D) with dadi. Full SFS with between 300-500 1% frequency variants", "Inferred P(4Ns| DFE, D) with dadi. Full SFS with 300-500 SNPs after taking the segregating sites with variants at all frequencies.", "Inferred P(4Ns| 1%, DFE, D)")

op <- par(cex = 0.5)

colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50","50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| DFE, D) dadi", "Inferred P(4Ns| 1%, DFE, D)")


barplot(log10(counts) - log10(0.0000000001), main="B) Constant Size - Mouse DFE", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5), cex.main = 2, ylim = c(0,10), yaxt="n")

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
        points((i - 1)* 6 + 4.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
        points((i - 1)* 6 + 4.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
        points((i - 1)* 6 + 4.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

points(Divisions*6 + 4.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 4.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 4.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 5.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 5.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 5.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 5.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 5.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 5.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 2.5, log10(UpQuantile[i]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 2.5, log10(LowQuantile[i]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 2.5, log10(Meandadi[i]) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 2.5, log10(UpQuantile[21]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 2.5, log10(LowQuantile[21]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 2.5, log10(Meandadi[21]) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)

FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 3.5, log10(UpQuantileSmall[i]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 3.5, log10(LowQuantileSmall[i]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 3.5, log10(MeandadiSmall[i]) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 3.5, log10(UpQuantileSmall[21]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 3.5, log10(LowQuantileSmall[21]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 3.5, log10(MeandadiSmall[21]) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)





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


##################################

BetaListFile <- read.table("../Results/dadiInferences/PopExpansionBoykoAlpha.txt")
AlphaListFile <- read.table("../Results/dadiInferences/PopExpansionBoykoBeta.txt")

P_Allele_Is_2NsDadi <- matrix(nrow=100, ncol=200)
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (j in 1:100){
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j]) - pgamma((i-1)*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j])
    P_Allele_Is_2NsDadi[j,i] <- Prob
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

    Prob <- 1 - sum(P_Allele_Is_2NsDadi[j,1:20])
    P_Allele_Is_2NsDadi[j,21] <- Prob
}

Partdadi <- c()
UpQuantile <- c()
LowQuantile <- c()
Meandadi <- c()
for (i in 1:21){
    # print (i)
    Prob <- median(P_Allele_Is_2NsDadi[1:100,i])
    Quantile <- quantile(P_Allele_Is_2NsDadi[1:100,i], probs = c(0.05, 0.95))
    Partdadi <- c(Partdadi, Prob)
    UpQuantile <- c(UpQuantile, Quantile[1])
    LowQuantile <- c(LowQuantile, Quantile[2])
    Meandadi <- c(Meandadi, mean(P_Allele_Is_2NsDadi[1:100,i]))
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

# PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

BetaListFile <- read.table("../Results/dadiInferences/PopExpansionBoykoSmallAlpha.txt")
AlphaListFile <- read.table("../Results/dadiInferences/PopExpansionBoykoSmallBeta.txt")

P_Allele_Is_2NsDadiSmall <- matrix(nrow=100, ncol=200)
#NumberOfAllelesAt2Ns <- c()
# RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (j in 1:100){
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j]) - pgamma((i-1)*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j])
    P_Allele_Is_2NsDadiSmall[j,i] <- Prob
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

    Prob <- 1 - sum(P_Allele_Is_2NsDadiSmall[j,1:20])
    P_Allele_Is_2NsDadiSmall[j,21] <- Prob
}

Partdadismall <- c()
UpQuantileSmall <- c()
LowQuantileSmall <- c()
MeandadiSmall <- c()
for (i in 1:21){
    # print (i)
    Prob <- median(P_Allele_Is_2NsDadiSmall[1:100,i])
    Quantile <- quantile(P_Allele_Is_2NsDadiSmall[1:100,i], probs = c(0.05, 0.95))
    Partdadismall <- c(Partdadismall, Prob)
    UpQuantileSmall <- c(UpQuantileSmall, Quantile[1])
    LowQuantileSmall <- c(LowQuantileSmall, Quantile[2])
    MeandadiSmall <- c(MeandadiSmall, mean(P_Allele_Is_2NsDadiSmall[1:100,i]))
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

# PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))



##################################


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
counts <- rbind(counts,c(1,2,3))
counts <- rbind(counts,c(1,2,3))
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
for (i in 4:20){
counts <- cbind(counts,c(PartOne[i],Partdadi[i],Partdadismall[i],PartTwo[i],PartFour[i]))
}

counts <- cbind(counts,c(1-sum(PartOne[1:20]),Partdadi[21],Partdadismall[21],1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))

counts[1,1] <- PartOne[1]
counts[1,2] <- PartOne[2]
counts[1,3] <- PartOne[3]
counts[4,1] <- PartTwo[1]
counts[4,2] <- PartTwo[2]
counts[4,3] <- PartTwo[3]
counts[5,1] <- PartFour[1]
counts[5,2] <- PartFour[2]
counts[5,3] <- PartFour[3]
counts[2,1] <- Partdadi[1]
counts[2,2] <- Partdadi[2]
counts[2,3] <- Partdadi[3]
counts[3,1] <- Partdadismall[1]
counts[3,2] <- Partdadismall[2]
counts[3,3] <- Partdadismall[3]

BoykoParams <- PartOne



colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50","50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| DFE, D) with dadi. Full SFS with between 300-500 1% frequency variants", "Inferred P(4Ns| DFE, D) with dadi. Full SFS with 300-500 SNPs after taking the segregating sites with variants at all frequencies.", "Inferred P(4Ns| 1%, DFE, D)")

op <- par(cex = 0.5)

colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50","50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| 1%, DFE, D)")

barplot(log10(counts) - log10(0.0000000001), main="C) Population expansion - Human DFE", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5), cex.main = 2, ylim = c(0,10), yaxt="n")


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
        points((i - 1)* 6 + 4.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
        points((i - 1)* 6 + 4.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
        points((i - 1)* 6 + 4.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

points(Divisions*6 + 4.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 4.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 4.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 5.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 5.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 5.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 5.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 5.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 5.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 2.5, log10(UpQuantile[i]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 2.5, log10(LowQuantile[i]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 2.5, log10(Meandadi[i]) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 2.5, log10(UpQuantile[21]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 2.5, log10(LowQuantile[21]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 2.5, log10(Meandadi[21]) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)

FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 3.5, log10(UpQuantileSmall[i]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 3.5, log10(LowQuantileSmall[i]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 3.5, log10(MeandadiSmall[i]) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 3.5, log10(UpQuantileSmall[21]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 3.5, log10(LowQuantileSmall[21]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 3.5, log10(MeandadiSmall[21]) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)



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


##################################

BetaListFile <- read.table("../Results/dadiInferences/PopExpansionMouseAlpha.txt")
AlphaListFile <- read.table("../Results/dadiInferences/PopExpansionMouseBeta.txt")

P_Allele_Is_2NsDadi <- matrix(nrow=100, ncol=200)
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (j in 1:100){
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j]) - pgamma((i-1)*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j])
    P_Allele_Is_2NsDadi[j,i] <- Prob
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

    Prob <- 1 - sum(P_Allele_Is_2NsDadi[j,1:20])
    P_Allele_Is_2NsDadi[j,21] <- Prob
}

Partdadi <- c()
UpQuantile <- c()
LowQuantile <- c()
Meandadi <- c()
for (i in 1:21){
    # print (i)
    Prob <- median(P_Allele_Is_2NsDadi[1:100,i])
    Quantile <- quantile(P_Allele_Is_2NsDadi[1:100,i], probs = c(0.05, 0.95))
    Partdadi <- c(Partdadi, Prob)
    UpQuantile <- c(UpQuantile, Quantile[1])
    LowQuantile <- c(LowQuantile, Quantile[2])
    Meandadi <- c(Meandadi, mean(P_Allele_Is_2NsDadi[1:100,i]))
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

# PartOne <- c(P_Allele_Is_2Ns[1:Divisions], 1 - sum(P_Allele_Is_2Ns[1:Divisions]))

BetaListFile <- read.table("../Results/dadiInferences/PopExpansionMouseSmallAlpha.txt")
AlphaListFile <- read.table("../Results/dadiInferences/PopExpansionMouseSmallBeta.txt")

P_Allele_Is_2NsDadiSmall <- matrix(nrow=100, ncol=200)
#NumberOfAllelesAt2Ns <- c()
# RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (j in 1:100){
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j]) - pgamma((i-1)*2.5,AlphaListFile$V1[j],scale=BetaListFile$V1[j])
    P_Allele_Is_2NsDadiSmall[j,i] <- Prob
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

    Prob <- 1 - sum(P_Allele_Is_2NsDadiSmall[j,1:20])
    P_Allele_Is_2NsDadiSmall[j,21] <- Prob
}

Partdadismall <- c()
UpQuantileSmall <- c()
LowQuantileSmall <- c()
MeandadiSmall <- c()
for (i in 1:21){
    # print (i)
    Prob <- median(P_Allele_Is_2NsDadiSmall[1:100,i])
    Quantile <- quantile(P_Allele_Is_2NsDadiSmall[1:100,i], probs = c(0.05, 0.95))
    Partdadismall <- c(Partdadismall, Prob)
    UpQuantileSmall <- c(UpQuantileSmall, Quantile[1])
    LowQuantileSmall <- c(LowQuantileSmall, Quantile[2])
    MeandadiSmall <- c(MeandadiSmall, mean(P_Allele_Is_2NsDadiSmall[1:100,i]))
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}


##################################


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

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionBoyko.txt")

TwoNsValues <- SelectionCoefficientList$V2*10000

Breaks <- c(0,2.5*0:300 + 2.25)

Check <- hist(TwoNsValues, breaks= Breaks, plot = FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns[1:50]/ (NumberOfAllelesAt2Ns[1:50])

DFEParsOne <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilities.txt")

DFEParsTwo <- read.table ("../Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims/AnotherExtraTableOfProbabilitiesSmall.txt")

DFEPars <- rbind(DFEParsOne, DFEParsTwo)

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
counts <- rbind(counts,c(1,2,3))
counts <- rbind(counts,c(1,2,3))
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
for (i in 4:20){
counts <- cbind(counts,c(PartOne[i],Partdadi[i],Partdadismall[i],PartTwo[i],PartFour[i]))
}

counts <- cbind(counts,c(1-sum(PartOne[1:20]),Partdadi[21],Partdadismall[21],1-sum(PartTwo[1:20]),1-sum(PartFour[1:20])))

counts[1,1] <- PartOne[1]
counts[1,2] <- PartOne[2]
counts[1,3] <- PartOne[3]
counts[4,1] <- PartTwo[1]
counts[4,2] <- PartTwo[2]
counts[4,3] <- PartTwo[3]
counts[5,1] <- PartFour[1]
counts[5,2] <- PartFour[2]
counts[5,3] <- PartFour[3]
counts[2,1] <- Partdadi[1]
counts[2,2] <- Partdadi[2]
counts[2,3] <- Partdadi[3]
counts[3,1] <- Partdadismall[1]
counts[3,2] <- Partdadismall[2]
counts[3,3] <- Partdadismall[3]

BoykoParams <- PartOne



colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50","50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| DFE, D) with dadi. Full SFS with between 300-500 1% frequency variants", "Inferred P(4Ns| DFE, D) with dadi. Full SFS with 300-500 SNPs after taking the segregating sites with variants at all frequencies.", "Inferred P(4Ns| 1%, DFE, D)")

op <- par(cex = 0.5)

colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50","50-55", "55-60", "60-65", "65-70", "70-75", "75-80", "80-85", "85-90", "90-95", "95-100", ">100")
rownames(counts) <- c("Real P(4Ns | DFE, D)", "Inferred P(4Ns| DFE, D)", "Inferred P(4Ns| 1%, DFE, D)")

barplot(log10(counts) - log10(0.0000000001), main="D) Population expansion - Mouse DFE", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors, beside=TRUE, cex.lab=2, cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=1.5), cex.main = 2, ylim = c(0,10), yaxt="n")

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
        points((i - 1)* 6 + 4.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
        points((i - 1)* 6 + 4.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
        points((i - 1)* 6 + 4.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
}

Quantiles <- quantile(MatrixFinalProbs[,DivisionsPlusOne],c(0.05,0.95))
CurrentMean <- mean(MatrixFinalProbs[,DivisionsPlusOne])

points(Divisions*6 + 4.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 4.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 4.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 5.5, log10(Quantiles[1]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 5.5, log10(Quantiles[2]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 5.5, log10(CurrentMean) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 5.5, log10(Quantiles[1]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 5.5, log10(Quantiles[2]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 5.5, log10(CurrentMean) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)


FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 2.5, log10(UpQuantile[i]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 2.5, log10(LowQuantile[i]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 2.5, log10(Meandadi[i]) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 2.5, log10(UpQuantile[21]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 2.5, log10(LowQuantile[21]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 2.5, log10(Meandadi[21]) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)

FinalMedian <- c()
TotalDifference <- c()
for (i in 1:Divisions){

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 6 + 3.5, log10(UpQuantileSmall[i]) - log10(0.0000000001),col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 6 + 3.5, log10(LowQuantileSmall[i]) - log10(0.0000000001),col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 6 + 3.5, log10(MeandadiSmall[i]) - log10(0.0000000001),col="black", pch=8, bg = "black", cex=1)
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    TotalDifference <- c(TotalDifference, 1 - sum(MatrixP_Allele_Is_2Ns_given_OnePercent[i,1:20]))
}

Quantiles <- quantile(TotalDifference,c(0.05,0.95))
CurrentMean <- mean(TotalDifference)

points(Divisions*6 + 3.5, log10(UpQuantileSmall[21]) - log10(0.0000000001), col="black", pch=24, bg = "black", cex=1)
points(Divisions*6 + 3.5, log10(LowQuantileSmall[21]) - log10(0.0000000001), col="black", pch=25, bg = "black", cex=1)
points(Divisions*6 + 3.5, log10(MeandadiSmall[21]) - log10(0.0000000001), col="black", pch=8, bg = "black", cex=1)




dev.off()


############################################################################### Full data  #################################################################################
