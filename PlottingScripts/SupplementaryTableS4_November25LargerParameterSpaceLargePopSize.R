library(here)
library(viridis)

FinalTable <- matrix(,ncol=4,nrow=5)
rownames(FinalTable) <- c("Inferred P(4Ns | DFE)","Boyko et al 2008 P(4Ns | DFE)", "Kim et al 2017 P(4Ns | DFE)", "Inferred P(4Ns | DFE) lower 90% bootstrap", "Inferred P(4Ns | DFE) upper 90% bootstrap")
colnames(FinalTable) <- c("4Ns < 1","1 < 4Ns < 10", "10 < 4Ns < 50", " 4Ns > 50")

DFEPars <- read.table ("../ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims/AnotherDFETableOfProbabilities.txt")

P_Allele_Is_2Ns_given_OnePercent <- c()


LowerLimit <- c()
LowerLimit <- c(LowerLimit,0)
LowerLimit <- c(LowerLimit,1)
LowerLimit <- c(LowerLimit,5)
LowerLimit <- c(LowerLimit,10)
LowerLimit <- c(LowerLimit,15)
LowerLimit <- c(LowerLimit,20)
LowerLimit <- c(LowerLimit,25)
LowerLimit <- c(LowerLimit,30)
LowerLimit <- c(LowerLimit,35)
LowerLimit <- c(LowerLimit,40)
LowerLimit <- c(LowerLimit,45)
LowerLimit <- c(LowerLimit,50)


for (i in 2:12){
    UpperBound <- LowerLimit[i] + 3
    LowerBound <- LowerLimit[(i-1)] + 3
    CurrentSum <- sum(DFEPars[1,LowerBound:UpperBound])
    # CurrentSum <-  pgamma(LowerLimit[i+1],Alpha,scale=Beta) - pgamma(LowerLimit[i],Alpha,scale=Beta)
    #    print (i)
    #    print (CurrentSum)
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
}


### P (allele is 2Ns = x | allele is at 1%)

Alpha = 0.01
Beta = 0.03

# P_Allele_Is_2Ns_given_OnePercent <- c()
CurrentLimits <- c(0, 0.5, 2.5, 5, 7.5, 10, 12.5, 15, 17.5, 20, 22.5, 25)

# P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:11){
    # print (i)
    Prob <- pgamma(CurrentLimits[i+1],Alpha,scale=Beta) - pgamma(CurrentLimits[i],Alpha,scale=Beta)
    #    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
}

Prob <- 1 - pgamma(25,Alpha,scale=Beta)
# P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)

### P (allele is at 1% | allele is 2Ns x)


Alpha = 0.184
Beta = 319.8626 * 22970/2000

P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
CurrentLimits <- c(0, 0.5, 2.5, 5, 7.5, 10, 12.5, 15, 17.5, 20, 22.5, 25)

# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:11){
    # print (i)
    Prob <- pgamma(CurrentLimits[i+1],Alpha,scale=Beta) - pgamma(CurrentLimits[i],Alpha,scale=Beta)
    P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*25387829482)
}
Prob <- 1 - pgamma(25,Alpha,scale=Beta)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*25387829482)

#### The number of alleles comes from the population expansion model (229700 + 45544 / 22970 * 6104 + 5856 / 22970 * 1760 + 7480 / 22970 * 1222 + 1131262 / 22970 * 228) * 100 * 1000

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesUK10KHighPop.txt")

TwoNsValues <- SelectionCoefficientList$V2*22970

# Check <- hist(TwoNsValues,breaks=c(0,0.2297,2.297,7.297,12.297,17.297,22.97,2297000000))
Check <- hist(TwoNsValues,breaks=c(0,0.5,2.5,5,7.5,10,12.5,15,17.5,20,22.5,25,100000000))

Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2Ns= Counts_At_OnePercent_Given2Ns/ NumberOfAllelesAt2Ns

###### The whole stuff

Probs <- P_Allele_Is_2Ns_given_OnePercent

## This is the over the number of NonCpG sites where a nonsynonymous mutation can take place that are far away from centromeres and telomeres
NumberOfNonCpGSites <- 26368474
MutationRate <- 1.5e-8
SitesDemography <- (22970 * 229700 + 45544 * 6104 + 5856 * 1760 + 7480 * 1222 + 1131262 * 228) * NumberOfNonCpGSites * MutationRate
Prob_One_Percent <- 273 / SitesDemography

Probs <- Probs[1:11] * Prob_One_Percent / Probabilities_At_One_Percent_Given_2Ns[1:11]

if (sum(Probs) > 1.0){
    Probs[12] = 0
    Probs[1:11] <- Probs[1:11] / sum(Probs[1:11])
}else{
    Probs[12] <- 1 - sum (Probs[1:11])
}

FinalTable[1,1] <- Probs[1]
FinalTable[1,2] <- sum(Probs[2:3])
FinalTable[1,3] <- sum(Probs[4:11])
FinalTable[1,4] <- Probs[12]

# Probs <- Probs[1:11] / sum (Probs[1:11] )


Labels <- c()
for (i in 1:10){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}

Label <- paste(">",50,sep="")
Labels <- c(Labels,Label)

pdf("../Figures/Figure14_UK10KDFE_StandingNewSOrders.pdf",width=19)
par(mar=c(5.1,5.1,4.1,2.1))

plot(1:11, Probs[1:11], col="blue", ylim=c(0,0.9), xaxt="n", ylab="Probability", xlab="4Ns", lwd=3, cex.lab=2, cex.axis=2, lty=1, type = "o")
# lines(1:15,Probs[1:15],col="blue",lwd=3)
lines(1:11,P_Allele_Is_2Ns_given_OnePercent[1:11],col="green",lwd=3, type = "o")
legend("topright",c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns| DFE)"),pch=19,col=c("blue","green"),cex=2)
axis(1, at=c(1:11), labels=Labels,cex.axis=2)
dev.off()


## Other limits
OtherLimit <- c()
OtherLimit <- c(OtherLimit,0)
OtherLimit <- c(OtherLimit,1)
OtherLimit <- c(OtherLimit,10)
OtherLimit <- c(OtherLimit,50)


Alpha = 0.184
Beta = 319.8626 * 22970/2000

ProbsBoyko <- c()
for (i in 2:4){
    Prob <- pgamma(OtherLimit[i] *.5,Alpha,scale=Beta) - pgamma(OtherLimit[(i-1)] *.5,Alpha,scale=Beta)
    ProbsBoyko <- c(ProbsBoyko, Prob)
}
Prob <- 1 - pgamma(50 *.5,Alpha,scale=Beta)
ProbsBoyko <- c(ProbsBoyko, Prob)

FinalTable[2,1] <- ProbsBoyko[1]
FinalTable[2,2] <- ProbsBoyko[2]
FinalTable[2,3] <- ProbsBoyko[3]
FinalTable[2,4] <- ProbsBoyko[4]

Alpha = 0.169
Beta = 1327.4 * 22970/(2*11261)

ProbsKim <- c()
for (i in 2:4){
    Prob <- pgamma(OtherLimit[i] *.5,Alpha,scale=Beta) - pgamma(OtherLimit[(i-1)] *.5,Alpha,scale=Beta)
    ProbsKim <- c(ProbsKim, Prob)
}
Prob <- 1 - pgamma(50 *.5,Alpha,scale=Beta)
ProbsKim <- c(ProbsKim, Prob)

FinalTable[3,1] <- ProbsKim[1]
FinalTable[3,2] <- ProbsKim[2]
FinalTable[3,3] <- ProbsKim[3]
FinalTable[3,4] <- ProbsKim[4]


counts <- table(mtcars$vs, mtcars$gear)
counts <- rbind(counts,c(1,2,3))
counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[4],Probs[4],ProbsBoyko[4],ProbsKim[4]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[5],Probs[5],ProbsBoyko[5],ProbsKim[5]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[6],Probs[6],ProbsBoyko[6],ProbsKim[6]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[7],Probs[7],ProbsBoyko[7],ProbsKim[7]))
counts[1,1] <- P_Allele_Is_2Ns_given_OnePercent[1]
counts[1,2] <- P_Allele_Is_2Ns_given_OnePercent[2]
counts[1,3] <- P_Allele_Is_2Ns_given_OnePercent[3]
counts[2,1] <- Probs[1]
counts[2,2] <- Probs[2]
counts[2,3] <- Probs[3]
counts[3,1] <- ProbsBoyko[1]
counts[3,2] <- ProbsBoyko[2]
counts[3,3] <- ProbsBoyko[3]
counts[4,1] <- ProbsKim[1]
counts[4,2] <- ProbsKim[2]
counts[4,3] <- ProbsKim[3]
colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50", ">50")
rownames(counts) <- c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns | DFE)","Boyko et al 2008 P(4Ns | DFE)", "Kim et al 2017 P(4Ns | DFE)")
ViridisColors <- viridis(4, alpha = 0.7)
pdf("../Figures/Figure14_UK10KDFE_StandingNewSOrders.pdf",width=19)
par(mar=c(5.1,5.1,4.1,2.1))
barplot(log10(counts)-log10(0.001), main="", ylab="Probability", xlab="4Ns", col=ViridisColors,
legend = rownames(counts), ylim = c(0, 3.1), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=2), yaxt="n")

axis (2,at=c(0,1,2,3), labels = c(0,10^-2,10^-1,10^0))
# counts <- table(Probs[1:11], P_Allele_Is_2Ns_given_OnePercent[1:11])
# plot(1:11, Probs[1:11], col="blue", ylim=c(0,0.9), xaxt="n", ylab="Probability", xlab="4Ns", lwd=3, cex.lab=2, cex.axis=2, lty=1, type = "o")
# lines(1:15,Probs[1:15],col="blue",lwd=3)
# lines(1:11,P_Allele_Is_2Ns_given_OnePercent[1:11],col="green",lwd=3, type = "o")
# legend("topright",c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns| DFE)"),pch=19,col=c("blue","green"),cex=2)
# axis(1, at=c(1:11), labels=Labels,cex.axis=2)

#################################################################################### Upper and lower 5% quantile

DFESelection <- read.table("../Results/ResultsSelectionInferred/SelectionLargerSpaceBootstrapUK10KDFETest.txt")
DFEPars <- read.table ("../ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims/AnotherDFETableOfProbabilities.txt")

MatrixProbs <- c()
MatrixP_Allele_Is_2Ns_given_OnePercent <- c()
# LowerLimit <- c()
# LowerLimit <- c(LowerLimit,0)
# LowerLimit <- c(LowerLimit,2.5)
# LowerLimit <- c(LowerLimit,5)
# LowerLimit <- c(LowerLimit,7.5)
# LowerLimit <- c(LowerLimit,10)
# LowerLimit <- c(LowerLimit,12.5)
# LowerLimit <- c(LowerLimit,15)
# LowerLimit <- c(LowerLimit,17.5)
# LowerLimit <- c(LowerLimit,20)
# LowerLimit <- c(LowerLimit,22.5)
# LowerLimit <- c(LowerLimit,25)

# Check <- hist(TwoNsValues,breaks=c(0,0.5,2.5,5,7.5,10,12.5,15,17.5,20,22.5,25,100000000))

LowerLimit <- c()
LowerLimit <- c(LowerLimit,0)
LowerLimit <- c(LowerLimit,1)
LowerLimit <- c(LowerLimit,5)
LowerLimit <- c(LowerLimit,10)
LowerLimit <- c(LowerLimit,15)
LowerLimit <- c(LowerLimit,20)
LowerLimit <- c(LowerLimit,25)
LowerLimit <- c(LowerLimit,30)
LowerLimit <- c(LowerLimit,35)
LowerLimit <- c(LowerLimit,40)
LowerLimit <- c(LowerLimit,45)
LowerLimit <- c(LowerLimit,50)
# LowerLimit <- c(LowerLimit,12.297)
# LowerLimit <- c(LowerLimit,17.297)
# LowerLimit <- c(LowerLimit,22.97)



for (j in 1:100){
    SelectionDFERow <- ((DFESelection$V2[j] %% 52 ) + 1)
    SelectionDFEColumn <- (floor(DFESelection$V2[j] / 52 ) + 1)
    print (j)
    print (SelectionDFERow)
    print (SelectionDFEColumn)
    
    DFEParameterNumber <- (SelectionDFEColumn-1)*52 + SelectionDFERow
    P_Allele_Is_2Ns_given_OnePercent <- c()
    print (DFEParameterNumber)
    Alpha = 0.01 * SelectionDFEColumn
    if (SelectionDFERow == 1){
        Beta = 0.03
    }
    if (SelectionDFERow == 2){
        Beta = 3
    }
    if (SelectionDFERow > 2){
        Beta = 1500 * (SelectionDFERow - 2)
    }
    
    #    Beta = 30 * (SelectionDFERow)
    
    for (i in 2:12){
        UpperBound <- LowerLimit[i] + 3
        LowerBound <- LowerLimit[(i-1)] + 3
        CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
        # CurrentSum <-  pgamma(LowerLimit[i+1],Alpha,scale=Beta) - pgamma(LowerLimit[i],Alpha,scale=Beta)
        #    print (i)
        #    print (CurrentSum)
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    Probs <- P_Allele_Is_2Ns_given_OnePercent[1:11] * Prob_One_Percent
    
    # print (Probs)
    Probs <- Probs[1:11] / Probabilities_At_One_Percent_Given_2Ns[1:11]
    # print (Probs)
    if (sum(Probs) > 1.0){
        Probs[12] = 0
        Probs[1:11] <- Probs[1:11] / sum(Probs[1:11])
    }else{
        Probs[12] <- 1 - sum (Probs[1:11])
    }
    Probs[13] <- sum(Probs[2:3])
    Probs[14] <- sum(Probs[4:11])
    # print (Probs)
    if (j==1){
        MatrixFinalProbs <- matrix(Probs,nrow=1)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
    }else{
        MatrixFinalProbs <- rbind ( MatrixFinalProbs,Probs)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
    }
}

FinalMedian <- c()
for (i in 1:14){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05, 0.5 ,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 5 + 2.5, max(log10(Quantiles[1]) - log10(0.001), 0), col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 5 + 2.5, max(log10(Quantiles[2]) - log10(0.001), 0), col="black", pch=25, bg = "black", cex=1)
    
    print ("MinMax")
    print (i)
    print (Quantiles[1])
    print (Quantiles[2])
    print (Quantiles[3])
    
    if (i == 1){
    FinalTable[4,1] <- Quantiles[1]
    FinalTable[5,1] <- Quantiles[3]
    }
    if (i == 13){
        FinalTable[4,2] <- Quantiles[1]
        FinalTable[5,2] <- Quantiles[3]
    }
    if (i == 14){
        FinalTable[4,3] <- Quantiles[1]
        FinalTable[5,3] <- Quantiles[3]
    }
    if (i == 12){
        FinalTable[4,4] <- Quantiles[1]
        FinalTable[5,4] <- Quantiles[3]
    }

    # print(max(log10(Quantiles[1]) - log10(0.001)), 0)
    # print(max(log10(Quantiles[2]) - log10(0.001)), 0)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    
    #    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 5 + 1.5, max(log10(Quantiles[1]) - log10(0.001), 0), col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 5 + 1.5, max(log10(Quantiles[2]) - log10(0.001), 0), col="black", pch=25, bg = "black", cex=1)
    
}

####################################################################################
dev.off()


write.table(FinalTable, file = "../Figures/TableS4.txt", sep = "\t")


