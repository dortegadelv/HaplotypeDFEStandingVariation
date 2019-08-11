library(here)
library(viridis)

### P (allele is 2Ns = x | allele is at 1%)

Alpha = 0.01
Beta = 0.03

P_Allele_Is_2Ns_given_OnePercent <- c()

# P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:10){
# print (i)
	Prob <- pgamma(i*2.5,Alpha,scale=Beta) - pgamma((i-1)*2.5,Alpha,scale=Beta)
	P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
}

Prob <- 1 - pgamma(25,Alpha,scale=Beta)
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)

### P (allele is at 1% | allele is 2Ns x)


Alpha = 0.11
Beta = 8636364 * 4594/2000000

P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:10){
# print (i)
	Prob <- pgamma(i*2.5,Alpha,scale=Beta) - pgamma((i-1)*2.5,Alpha,scale=Beta)
	P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
	NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*34783323629)
}
Prob <- 1 - pgamma(25,Alpha,scale=Beta)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*34783323629)

#### The number of alleles comes from the population expansion model (22971 + 9109 / 4594 * 1221 + 1171 / 4594 * 352 + 1496 / 4594 * 244 + 226252 / 4594 * 46) * 1000 * 1250

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesUK10KMouse.txt")

TwoNsValues <- SelectionCoefficientList$V2*4594

Check <- hist(TwoNsValues,breaks=c(0,2.5,5,7.5,10,12.5,15,17.5,20,22.5,25,100000000))
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2Ns= Counts_At_OnePercent_Given2Ns/ NumberOfAllelesAt2Ns

###### The whole stuff

Probs <- P_Allele_Is_2Ns_given_OnePercent

## This is the over the number of NonCpG sites where a nonsynonymous mutation can take place that are far away from centromeres and telomeres
NumberOfNonCpGSites <- 26368474
MutationRate <- 1.5e-8
SitesDemography <- (22971 + 9109 / 4594 * 1221 + 1171 / 4594 * 352 + 1496 / 4594 * 244 + 226252 / 4594 * 46) * 1000 * 1250
Prob_One_Percent <- 61813 / SitesDemography

Probs <- Probs[1:11] * Prob_One_Percent / Probabilities_At_One_Percent_Given_2Ns[1:11]

if (sum(Probs) > 1.0){
    Probs[11] = 0
    Probs[1:10] <- Probs[1:10] / sum(Probs[1:10])
}else{
    Probs[11] <- 1 - sum (Probs[1:10])
}


# Probs <- Probs[1:11] / sum (Probs[1:11] )


Labels <- c()
for (i in 1:10){
Label <- paste((i-1)*5,"-",i*5,sep="")
	Labels <- c(Labels,Label)
}

Label <- paste(">",50,sep="")
Labels <- c(Labels,Label)

pdf("../Figures/SuppFigureX_UK10KDFE_Boyko.pdf",width=19)
par(mar=c(5.1,5.1,4.1,2.1))

plot(1:11, Probs[1:11], col="blue", ylim=c(0,0.9), xaxt="n", ylab="Probability", xlab="4Ns", lwd=3, cex.lab=2, cex.axis=2, lty=1, type = "o")
# lines(1:15,Probs[1:15],col="blue",lwd=3)
lines(1:11,P_Allele_Is_2Ns_given_OnePercent[1:11],col="green",lwd=3, type = "o")
legend("topright",c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns| DFE)"),pch=19,col=c("blue","green"),cex=2)
axis(1, at=c(1:11), labels=Labels,cex.axis=2)
dev.off()

Alpha = 0.184
Beta = 319.8626 * 4594/2000

ProbsBoyko <- c()
for (i in 1:10){
Prob <- pgamma(5*i *.5,Alpha,scale=Beta) - pgamma(5*(i-1) *.5,Alpha,scale=Beta)
ProbsBoyko <- c(ProbsBoyko, Prob)
}
Prob <- 1 - pgamma(50 *.5,Alpha,scale=Beta)
ProbsBoyko <- c(ProbsBoyko, Prob)

Alpha = 0.169
Beta = 1327.4 * 4594/(2*11261)

ProbsKim <- c()
for (i in 1:10){
    Prob <- pgamma(5*i *.5,Alpha,scale=Beta) - pgamma(5*(i-1) *.5,Alpha,scale=Beta)
    ProbsKim <- c(ProbsKim, Prob)
}
Prob <- 1 - pgamma(50 *.5,Alpha,scale=Beta)
ProbsKim <- c(ProbsKim, Prob)


counts <- table(mtcars$vs, mtcars$gear)
counts <- rbind(counts,c(1,2,3))
# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[4],Probs[4],ProbsBoyko[4]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[5],Probs[5],ProbsBoyko[5]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[6],Probs[6],ProbsBoyko[6]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[7],Probs[7],ProbsBoyko[7]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[8],Probs[8],ProbsBoyko[8]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[9],Probs[9],ProbsBoyko[9]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[10],Probs[10],ProbsBoyko[10]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[11],Probs[11],ProbsBoyko[11]))
counts[1,1] <- P_Allele_Is_2Ns_given_OnePercent[1]
counts[1,2] <- P_Allele_Is_2Ns_given_OnePercent[2]
counts[1,3] <- P_Allele_Is_2Ns_given_OnePercent[3]
counts[2,1] <- Probs[1]
counts[2,2] <- Probs[2]
counts[2,3] <- Probs[3]
counts[3,1] <- ProbsBoyko[1]
counts[3,2] <- ProbsBoyko[2]
counts[3,3] <- ProbsBoyko[3]
colnames(counts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50", ">50")
rownames(counts) <- c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns | DFE)","Boyko et al 2008 P(4Ns | DFE)")
ViridisColors <- viridis(3, alpha = 0.7)
# barplot(log10(counts)-log10(0.001), main="", ylab="Probability", xlab="4Ns", col=ViridisColors,
#   	legend = rownames(counts), ylim = c(0, 3.1), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=2), yaxt="n")

# axis (2,at=c(0,1,2,3), labels = c(0,10^-2,10^-1,10^0))
# counts <- table(Probs[1:11], P_Allele_Is_2Ns_given_OnePercent[1:11])
# plot(1:11, Probs[1:11], col="blue", ylim=c(0,0.9), xaxt="n", ylab="Probability", xlab="4Ns", lwd=3, cex.lab=2, cex.axis=2, lty=1, type = "o")
# lines(1:15,Probs[1:15],col="blue",lwd=3)
# lines(1:11,P_Allele_Is_2Ns_given_OnePercent[1:11],col="green",lwd=3, type = "o")
# legend("topright",c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns| DFE)"),pch=19,col=c("blue","green"),cex=2)
# axis(1, at=c(1:11), labels=Labels,cex.axis=2)

#################################################################################### Upper and lower 5% quantile

DFESelection <- read.table("../Results/ResultsSelectionInferred/SelectionLargerSpaceUK10KDFETest.txt")
DFEPars <- read.table ("../ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims/AnotherDFETableOfProbabilities.txt")
DFEParsTwo <- read.table ("../ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims/DFETableOfProbabilities.txt")

MatrixProbs <- c()
MatrixP_Allele_Is_2Ns_given_OnePercent <- c()
for (j in 1:100){
    if (DFESelection$V1[j] == 0){
SelectionDFERow <- ((DFESelection$V2[j] %% 52 ) + 1)
SelectionDFEColumn <- (floor(DFESelection$V2[j] / 52 ) + 1)
print (j)
print (SelectionDFERow)
print (SelectionDFEColumn)

DFEParameterNumber <- (SelectionDFEColumn-1)*52 + SelectionDFERow
P_Allele_Is_2Ns_given_OnePercent <- c()
print (DFEParameterNumber)


for (i in 1:10){
    UpperBound <- i*5 + 2
    LowerBound <- (i-1)*5 + 3
    CurrentSum <- sum(DFEPars[DFEParameterNumber,LowerBound:UpperBound])
    #    print (i)
    #    print (CurrentSum)
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
}
Probs <- P_Allele_Is_2Ns_given_OnePercent[1:10] * Prob_One_Percent

# print (Probs)
Probs <- Probs[1:10] / Probabilities_At_One_Percent_Given_2Ns[1:10]
# print (Probs)
if (sum(Probs) > 1.0){
Probs[11] = 0
Probs[1:10] <- Probs[1:10] / sum(Probs[1:10])
}else{
Probs[11] <- 1 - sum (Probs[1:10])
}
P_Allele_Is_2Ns_given_OnePercent[11] <- 1 - sum(P_Allele_Is_2Ns_given_OnePercent)
# print (Probs)
if (j==1){
    MatrixFinalProbs <- matrix(Probs,nrow=1)
    MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
}else{
    MatrixFinalProbs <- rbind ( MatrixFinalProbs,Probs)
    MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
}
    }else{
    
    SelectionDFERow <- ((DFESelection$V2[j] %% 50 ) + 1)
    SelectionDFEColumn <- (floor(DFESelection$V2[j] / 50 ) + 1)
    print (j)
    print (SelectionDFERow)
    print (SelectionDFEColumn)
    
    DFEParameterNumber <- (SelectionDFEColumn-1)*50 + SelectionDFERow
    P_Allele_Is_2Ns_given_OnePercent <- c()
    print (DFEParameterNumber)
    
    
    for (i in 1:10){
        UpperBound <- i*5 + 2
        LowerBound <- (i-1)*5 + 3
        CurrentSum <- sum(DFEParsTwo[DFEParameterNumber,LowerBound:UpperBound])
        #    print (i)
        #    print (CurrentSum)
        P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
    }
    Probs <- P_Allele_Is_2Ns_given_OnePercent[1:10] * Prob_One_Percent
    
    # print (Probs)
    Probs <- Probs[1:10] / Probabilities_At_One_Percent_Given_2Ns[1:10]
    # print (Probs)
    if (sum(Probs) > 1.0){
        Probs[11] = 0
        Probs[1:10] <- Probs[1:10] / sum(Probs[1:10])
    }else{
        Probs[11] <- 1 - sum (Probs[1:10])
    }
    P_Allele_Is_2Ns_given_OnePercent[11] <- 1 - sum(P_Allele_Is_2Ns_given_OnePercent)
    # print (Probs)
    if (j==1){
        MatrixFinalProbs <- matrix(Probs,nrow=1)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- matrix(P_Allele_Is_2Ns_given_OnePercent,nrow=1)
    }else{
        MatrixFinalProbs <- rbind ( MatrixFinalProbs,Probs)
        MatrixP_Allele_Is_2Ns_given_OnePercent <- rbind(MatrixP_Allele_Is_2Ns_given_OnePercent,P_Allele_Is_2Ns_given_OnePercent)
    }
    }
}

FinalMedian <- c()
for (i in 1:11){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 5 + 2.5, max(log10(Quantiles[1]) - log10(0.001), 0), col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 5 + 2.5, max(log10(Quantiles[2]) - log10(0.001), 0), col="black", pch=25, bg = "black", cex=1)
    
    print ("MinMax")
    print (i)
    print (Quantiles[1])
    print (Quantiles[2])

    # print(max(log10(Quantiles[1]) - log10(0.001)), 0)
    # print(max(log10(Quantiles[2]) - log10(0.001)), 0)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    counts[2,i] <- Quantiles[1]

    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.5))
    counts[1,i] <- Quantiles[1]

    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    #    points((i - 1)* 5 + 1.5, max(log10(Quantiles[1]) - log10(0.001), 0), col="black",pch=24, bg = "black", cex=1)
    #    points((i - 1)* 5 + 1.5, max(log10(Quantiles[2]) - log10(0.001), 0), col="black", pch=25, bg = "black", cex=1)

}

################# Create log-table

logcounts <- table(mtcars$vs, mtcars$gear)
logcounts <- rbind(logcounts,c(1,2,3))
#logcounts <- rbind(logcounts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
logcounts <- cbind(logcounts,c(max(log10(P_Allele_Is_2Ns_given_OnePercent[4]) -log10(0.001),0), max(log10(Probs[4]) -log10(0.001),0), max(log10(ProbsBoyko[4]) -log10(0.001),0)))
logcounts <- cbind(logcounts,c(max(log10(P_Allele_Is_2Ns_given_OnePercent[5]) -log10(0.001),0), max(log10(Probs[5]) -log10(0.001),0), max(log10(ProbsBoyko[5]) -log10(0.001),0)))
logcounts <- cbind(logcounts,c(max(log10(P_Allele_Is_2Ns_given_OnePercent[6]) -log10(0.001),0), max(log10(Probs[6]) -log10(0.001),0), max(log10(ProbsBoyko[6]) -log10(0.001),0)))
logcounts <- cbind(logcounts,c(max(log10(P_Allele_Is_2Ns_given_OnePercent[7]) -log10(0.001),0), max(log10(Probs[7]) -log10(0.001),0), max(log10(ProbsBoyko[7]) -log10(0.001),0)))
logcounts <- cbind(logcounts,c(max(log10(P_Allele_Is_2Ns_given_OnePercent[8]) -log10(0.001),0), max(log10(Probs[8]) -log10(0.001),0), max(log10(ProbsBoyko[8]) -log10(0.001),0)))
logcounts <- cbind(logcounts,c(max(log10(P_Allele_Is_2Ns_given_OnePercent[9]) -log10(0.001),0), max(log10(Probs[9]) -log10(0.001),0), max(log10(ProbsBoyko[9]) -log10(0.001),0)))
logcounts <- cbind(logcounts,c(max(log10(P_Allele_Is_2Ns_given_OnePercent[10]) -log10(0.001),0), max(log10(Probs[10]) -log10(0.001),0), max(log10(ProbsBoyko[10]) -log10(0.001),0)))
logcounts <- cbind(logcounts,c(max(log10(P_Allele_Is_2Ns_given_OnePercent[11]) -log10(0.001),0), max(log10(Probs[11]) -log10(0.001),0), max(log10(ProbsBoyko[11]) -log10(0.001),0)))
logcounts[1,1] <- max(log10(P_Allele_Is_2Ns_given_OnePercent[1]) -log10(0.001),0)
logcounts[1,2] <- max(log10(P_Allele_Is_2Ns_given_OnePercent[2]) -log10(0.001),0)
logcounts[1,3] <- max(log10(P_Allele_Is_2Ns_given_OnePercent[3]) -log10(0.001),0)
logcounts[2,1] <- max(log10(Probs[1]) -log10(0.001),0)
logcounts[2,2] <- max(log10(Probs[2]) -log10(0.001),0)
logcounts[2,3] <- max(log10(Probs[3]) -log10(0.001),0)
logcounts[3,1] <- max(log10(ProbsBoyko[1]) -log10(0.001),0)
logcounts[3,2] <- max(log10(ProbsBoyko[2]) -log10(0.001),0)
logcounts[3,3] <- max(log10(ProbsBoyko[3]) -log10(0.001),0)
#logcounts[4,1] <- max(log10(ProbsKim[1]) -log10(0.001),0)
#logcounts[4,2] <- max(log10(ProbsKim[2]) -log10(0.001),0)
#logcounts[4,3] <- max(log10(ProbsKim[3]) -log10(0.001),0)
colnames(logcounts) <- c("0-5", "5-10", "10-15", "15-20", "20-25", "25-30", "30-35", "35-40", "40-45", "45-50", ">50")
rownames(logcounts) <- c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns | DFE)","Boyko et al 2008 P(4Ns | DFE)")


logcountsThree <- table(mtcars$vs, mtcars$gear)
logcountsThree <- rbind(logcountsThree,c(1,2,3))
# logcounts <- rbind(logcounts,c(1,2,3))

# counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
# counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[4],Probs[4],ProbsBoyko[4]))
# counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[5],Probs[5],ProbsBoyko[5]))
# counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[6],Probs[6],ProbsBoyko[6]))
# counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[7],Probs[7],ProbsBoyko[7]))
# counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[8],Probs[8],ProbsBoyko[8]))
# counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[9],Probs[9],ProbsBoyko[9]))
# counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[10],Probs[10],ProbsBoyko[10]))
# counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[11],Probs[11],ProbsBoyko[11]))
logcountsThree[1,1] <- P_Allele_Is_2Ns_given_OnePercent[1]
logcountsThree[1,2] <- sum(P_Allele_Is_2Ns_given_OnePercent[2:10])
logcountsThree[1,3] <- P_Allele_Is_2Ns_given_OnePercent[11]
logcountsThree[2,1] <- Probs[1]
logcountsThree[2,2] <- sum(Probs[2:10])
logcountsThree[2,3] <- Probs[11]
logcountsThree[3,1] <- ProbsBoyko[1]
logcountsThree[3,2] <- sum(ProbsBoyko[2:10])
logcountsThree[3,3] <- ProbsBoyko[11]

colnames(logcountsThree) <- c("0-5", "5-50", ">50")
rownames(logcountsThree) <- c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns | DFE)","Boyko et al 2008 P(4Ns | DFE)")




################# End of log-table


pdf("../Figures/SuppFigure10_UK10KDFE_Boyko.pdf",width=19)
par(mar=c(5.1,5.1,4.1,2.1))

barplot(logcounts + 0.01, main="", ylab="Probability", xlab="4Ns", col=ViridisColors,
legend = c(expression("Inferred "* P[psi]* "("* bolditalic(s[j])*" | 1%" * ", "* italic(D) * ")"), expression("Inferred "* P[psi]* "("* bolditalic(s[j])* ")"), expression("Boyko et al 2008 "* P[psi]* "("* bolditalic(s[j])* ")") ) , ylim = c(0, 3.3), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=2), yaxt="n")

# rownames(counts) <- c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns | DFE)","Boyko et al 2008 P(4Ns | DFE)")

axis (2,at=c(0 + 0.01, 1 + 0.01, 2 + 0.01, 3 + 0.01), labels = c(0,10^-2,10^-1,10^0))

FinalMedian <- c()
for (i in 1:11){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixFinalProbs[,i])
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 2.5, max(log10(Quantiles[1]) - log10(0.001), 0) + 0.01, col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 2.5, max(log10(Quantiles[2]) - log10(0.001), 0) + 0.01, col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 2.5, max(log10(CurrentMean) - log10(0.001), 0) + 0.01, col="black", pch=8, bg = "black", cex=1)


    print ("MinMax")
    print (i)
    print (Quantiles[1])
    print (Quantiles[2])
    
    # print(max(log10(Quantiles[1]) - log10(0.001)), 0)
    # print(max(log10(Quantiles[2]) - log10(0.001)), 0)
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    counts[2,i] <- Quantiles[1]
    
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,i])

    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 1.5, max(log10(Quantiles[1]) - log10(0.001), 0) + 0.01, col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 1.5, max(log10(Quantiles[2]) - log10(0.001), 0) + 0.01, col="black", pch=25, bg = "black", cex=1)
    points((i - 1)* 4 + 1.5, max(log10(CurrentMean) - log10(0.001), 0) + 0.01, col="black", pch=8, bg = "black", cex=1)


}


####################################################################################
dev.off()

#################################################################################### Put lines Supp Fig S9



pdf("../Figures/SuppFigureX_UK10KDFE_Boyko_Lines.pdf",width=19)
par(mar=c(5.1,5.1,4.1,2.1))

# barplot(log10(counts)-log10(0.001) + 0.1, main="", ylab="Probability", xlab="4Ns", col=ViridisColors,
# legend = c(expression("Inferred P("*bolditalic(s[j])*" | 1%, "* italic(DFE) * ", "* italic(D) * ")"), expression("Inferred P("*bolditalic(s[j])*" | "* italic(DFE) * ")"), expression("Boyko et al 2008 P("*bolditalic(s[j])*" | "* italic(DFE) * ")") ) , ylim = c(0, 3.3), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=2), yaxt="n")

# rownames(counts) <- c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns | DFE)","Boyko et al 2008 P(4Ns | DFE)")

# axis (2,at=c(0 + 0.1, 1 + 0.1, 2 + 0.1, 3 + 0.1), labels = c(0,10^-2,10^-1,10^0))

ViridisColors <- viridis(5)

ProbVector <- c()
for (j in 1:11){
ProbVector <- c(ProbVector, max(log10(MatrixFinalProbs[1,j]) - log10(0.001),0) + 0.01)
}

plot(1:11, ProbVector, lty=1, type ="o", pch = 19 , yaxt="n", ylim = c(0, 3.3), col= ViridisColors[1])
axis (2,at=c(0 + 0.01, 1 + 0.01, 2 + 0.01, 3 + 0.01), labels = c(0,10^-2,10^-1,10^0))

ProbVector <- c()
for (j in 1:11){
    ProbVector <- c(ProbVector, max(log10(MatrixFinalProbs[2,j]) - log10(0.001),0) + 0.01)
}

lines(1:11, ProbVector, lty=1, type ="o", pch = 19, col= ViridisColors[2])


ProbVector <- c()
for (j in 1:11){
    ProbVector <- c(ProbVector, max(log10(MatrixFinalProbs[3,j]) - log10(0.001),0) + 0.01)
}

lines(1:11, ProbVector, lty=1, type ="o", pch = 19, col= ViridisColors[3])


ProbVector <- c()
for (j in 1:11){
    ProbVector <- c(ProbVector, max(log10(MatrixFinalProbs[4,j]) - log10(0.001),0) + 0.01)
}

lines(1:11, ProbVector, lty=1, type ="o", pch = 19, col= ViridisColors[4])


ProbVector <- c()
for (j in 1:11){
    ProbVector <- c(ProbVector, max(log10(MatrixFinalProbs[5,j]) - log10(0.001),0) + 0.01)
}

lines(1:11, ProbVector, lty=1, type ="o", pch = 19, col= ViridisColors[5])



####################################################################################
dev.off()


#################################################################################### Create table of confidence intervals ###################################################


Probs <- c(0.75, 0.9, 0.95, 0.975)

Table <- matrix(nrow=8, ncol= 11)

for (i in 1:11){
    for (j in 1:4){
        Quantiles <- quantile(MatrixFinalProbs[,i],c(1-Probs[j], Probs[j]))
        Table[(j*2 - 1), i] <- Quantiles[1]
        Table[(j*2), i] <- Quantiles[2]
    }
}

write.table(Table, file ="../Figures/ConfidenceIntervalsFinalProbsTableS2.txt", sep = "\t", row.names = FALSE, col.names = FALSE)

Probs <- c(0.75, 0.9, 0.95, 0.975)

Table <- matrix(nrow=8, ncol= 11)

for (i in 1:11){
    for (j in 1:4){
        Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,i],c(1-Probs[j], Probs[j]))
        Table[(j*2 - 1), i] <- Quantiles[1]
        Table[(j*2), i] <- Quantiles[2]
    }
}

write.table(Table, file ="../Figures/ConfidenceIntervalsP2NsOnePercentTableS2.txt", sep = "\t", row.names = FALSE, col.names = FALSE)



########### Do plot with only three bins

ViridisColors <- viridis(3, alpha = 0.7)
pdf("../Figures/SuppFigure10_BarPlot_UK10KDFE_StandingNew_OnlyThreeBins_NaturalScale.pdf",width=19)
par(mar=c(5.1,5.1,4.1,2.1))
barplot(logcountsThree + 0.01, main="", ylab="Probability", xlab="4Ns", col=ViridisColors,
legend = c(expression("Inferred " ~ 'P'[psi] * "(" * bolditalic(s[j])*" | 1%, "* italic(D) * ")"), expression("Inferred " * 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression("Boyko et al 2008 " * 'P'[psi] * "(" * bolditalic(s[j]) * ")") ), ylim = c(0, 1.2), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=2), yaxt="n")

axis (2,at=c(0+0.01, 0.25+0.01, 0.5+0.01, 0.75 + 0.01, 1+0.01), labels = c(0, 0.25, 0.5, 0.75, 1.0),cex.axis=2, cex.lab = 2)

FinalMedian <- c()
for (i in 1:3){
    
    if (i == 1){
    NumberToCheck <- 1
    }
    if (i == 3){
        NumberToCheck <- 11
    }
    if (i == 2){
        Sums <- c()
        for (CurNumber in 1:100){
            Sums <- c(Sums,sum(MatrixFinalProbs[CurNumber,2:10]))
            }

        Quantiles <- quantile(Sums,c(0.05,0.95))
        CurrentMean <- mean(Sums)

        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        points((i - 1)* 4 + 2.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        points((i - 1)* 4 + 2.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        points((i - 1)* 4 + 2.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)

        print ("MinMax")
        print (i)
        print (Quantiles[1])
        print (Quantiles[2])
        
        # print(max(log10(Quantiles[1]) - log10(0.001)), 0)
        # print(max(log10(Quantiles[2]) - log10(0.001)), 0)
        Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.5))
        #        CurrentMean <- mean(Sums)
        FinalMedian <- c(FinalMedian,Quantiles[1])
        counts[2,i] <- Quantiles[1]

        Sums <- c()
        for (CurNumber in 1:100){
            Sums <- c(Sums,sum(MatrixP_Allele_Is_2Ns_given_OnePercent[CurNumber,2:10]))
        }

        #        Quantiles <- quantile(sum(MatrixP_Allele_Is_2Ns_given_OnePercent[,2:10]),c(0.05,0.95))
        Quantiles <- quantile(Sums,c(0.05,0.95))
        CurrentMean <- mean(Sums)

        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        points((i - 1)* 4 + 1.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        points((i - 1)* 4 + 1.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        points((i - 1)* 4 + 1.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)


    } else {
    
    Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.05,0.95))
    CurrentMean <- mean(MatrixFinalProbs[,NumberToCheck])
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 2.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
    points((i - 1)* 4 + 2.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
    points((i - 1)* 4 + 2.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
    
    print ("MinMax")
    print (i)
    print (Quantiles[1])
    print (Quantiles[2])
    
    # print(max(log10(Quantiles[1]) - log10(0.001)), 0)
    # print(max(log10(Quantiles[2]) - log10(0.001)), 0)
    Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.5))
    FinalMedian <- c(FinalMedian,Quantiles[1])
    counts[2,i] <- Quantiles[1]
    
    Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,NumberToCheck],c(0.05,0.95))
    CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,NumberToCheck])
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 1.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
    points((i - 1)* 4 + 1.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
    points((i - 1)* 4 + 1.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
    }
}

dev.off()

############################### Compare with real results Density plot Stuff


ViridisColors <- viridis(3, alpha = 0.7)
pdf("../Figures/SuppFigureX_DensityPlot_UK10KDFE_StandingNew_OnlyThreeBins_NaturalScale.pdf",width=19)

Title <- c("A) Probability of having a 4Ns value < 5\n on inferences done on 100 simulations\n using the Boyko DFE", "B) Probability of having a 4Ns value between 5 and 50\n on inferences done on 100 simulations\n using the Boyko DFE", "C) Probability of having a 4Ns value > 50\n on inferences done on 100 simulations\n using the Boyko DFE")
par(mar=c(5.1,5.1,6.1,2.1))
par(mfrow=c(1,3))

ProbFromData <- c (0.3856727, 0.0, 0.6143273)
Xlabels <- c("Proportion of new mutations with a 4Ns value < 5", "Proportion of new mutations with 4Ns between 5 and 50","Proportion of new mutations with a 4Ns value > 50")
# barplot(logcountsThree + 0.01, main="", ylab="Probability", xlab="4Ns", col=ViridisColors,
# legend = c(expression("Inferred P("*bolditalic(s[j])*" | 1%, "* italic(DFE) * ", "* italic(D) * ")"), expression("Inferred P("*bolditalic(s[j])*" | "* italic(DFE) * ")"), expression("Boyko et al 2008 P("*bolditalic(s[j])*" | "* italic(DFE) * ")") ), ylim = c(0, 1.2), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=2), yaxt="n")

# axis (2,at=c(0+0.01, 0.25+0.01, 0.5+0.01, 0.75 + 0.01, 1+0.01), labels = c(0, 0.25, 0.5, 0.75, 1.0),cex.axis=2, cex.lab = 2)

FinalMedian <- c()
PValToPrint <- c("= 0.1","= 0.54","< 0.01")
for (i in 1:3){
    
    if (i == 1){
        NumberToCheck <- 1
    }
    if (i == 3){
        NumberToCheck <- 11
    }
    if (i == 2){
        Sums <- c()
        for (CurNumber in 1:100){
            Sums <- c(Sums,sum(MatrixFinalProbs[CurNumber,2:10]))
        }
        
        
        ThisDensity <- density (Sums, from = 0, to = 1)
        plot(ThisDensity, ylab="Probability", xlab= Xlabels[i], main = Title[i], cex.lab = 2, cex.main = 2, yaxt="n", xlim = c(0,1))
        abline(v = ProbFromData[i], lty = 2)
        ToPrint <- paste("p-value ",PValToPrint[i],sep="")
        legend("topright",ToPrint, bty = "n",cex=1.5)
        
        Quantiles <- quantile(Sums,c(0.05,0.95))
        CurrentMean <- mean(Sums)
        
        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #        points((i - 1)* 4 + 2.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        #        points((i - 1)* 4 + 2.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        #        points((i - 1)* 4 + 2.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
        
        print ("MinMax")
        print (i)
        print (Quantiles[1])
        print (Quantiles[2])
        
        # print(max(log10(Quantiles[1]) - log10(0.001)), 0)
        # print(max(log10(Quantiles[2]) - log10(0.001)), 0)
        Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.5))
        #        CurrentMean <- mean(Sums)
        FinalMedian <- c(FinalMedian,Quantiles[1])
        counts[2,i] <- Quantiles[1]
        
        Sums <- c()
        for (CurNumber in 1:100){
            Sums <- c(Sums,sum(MatrixP_Allele_Is_2Ns_given_OnePercent[CurNumber,2:10]))
        }
        
        #        Quantiles <- quantile(sum(MatrixP_Allele_Is_2Ns_given_OnePercent[,2:10]),c(0.05,0.95))
        Quantiles <- quantile(Sums,c(0.05,0.95))
        CurrentMean <- mean(Sums)
        
        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #        points((i - 1)* 4 + 1.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        #        points((i - 1)* 4 + 1.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        #        points((i - 1)* 4 + 1.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
        
        
    } else {
        
        Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.05,0.95))
        CurrentMean <- mean(MatrixFinalProbs[,NumberToCheck])
        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #        points((i - 1)* 4 + 2.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        #        points((i - 1)* 4 + 2.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        #        points((i - 1)* 4 + 2.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
        ThisDensity <- density (MatrixFinalProbs[,NumberToCheck], from = 0, to = 1)
        
        plot(ThisDensity, ylab="Probability", xlab= Xlabels[i], main = Title[i], cex.lab = 2, cex.main = 2, yaxt="n", xlim = c(0,1))
        abline(v = ProbFromData[i], lty = 2)
        ToPrint <- paste("p-value ",PValToPrint[i],sep="")
        legend("topright",ToPrint, bty = "n",cex=1.5)
        print ("MinMax")
        print (i)
        print (Quantiles[1])
        print (Quantiles[2])
        
        # print(max(log10(Quantiles[1]) - log10(0.001)), 0)
        # print(max(log10(Quantiles[2]) - log10(0.001)), 0)
        Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.5))
        FinalMedian <- c(FinalMedian,Quantiles[1])
        counts[2,i] <- Quantiles[1]
        
        Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,NumberToCheck],c(0.05,0.95))
        CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,NumberToCheck])
        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #        points((i - 1)* 4 + 1.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        #        points((i - 1)* 4 + 1.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        #        points((i - 1)* 4 + 1.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
    }
}

dev.off()

#################################################################### Density plot Stuff

#################################################################### P- value computations

### First bin


ViridisColors <- viridis(3, alpha = 0.7)
pdf("../Figures/SuppFigureX_DensityPlot_UK10KDFE_StandingNew_OnlyThreeBins_NaturalScale.pdf",width=19)

Title <- c("Probability of having a 4Ns value < 5\n on inferences done over 100 simulations", "Probability of having a 4Ns value between 5 and 50\n on inferences done over 100 simulations", "Probability of having a 4Ns value > 50\n on inferences done over 100 simulations")
#par(mar=c(5.1,5.1,4.1,2.1))
# par(mfrow=c(1,3))

ProbFromData <- c (0.2330944, 0.0, 0.7669056)
AllPValues <- c()
barplot(logcountsThree + 0.01, main="", ylab="Probability", xlab="4Ns", col=ViridisColors,
legend = c(expression("Inferred P("*bolditalic(s[j])*" | 1%, "* italic(DFE) * ", "* italic(D) * ")"), expression("Inferred P("*bolditalic(s[j])*" | "* italic(DFE) * ")"), expression("Boyko et al 2008 P("*bolditalic(s[j])*" | "* italic(DFE) * ")") ), ylim = c(0, 1.2), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=2), yaxt="n")

axis (2,at=c(0+0.01, 0.25+0.01, 0.5+0.01, 0.75 + 0.01, 1+0.01), labels = c(0, 0.25, 0.5, 0.75, 1.0),cex.axis=2, cex.lab = 2)

FinalMedian <- c()
for (i in 1:3){
    
    if (i == 1){
        NumberToCheck <- 1
    }
    if (i == 3){
        NumberToCheck <- 11
    }
    if (i == 2){
        Sums <- c()
        for (CurNumber in 1:100){
            Sums <- c(Sums,sum(MatrixFinalProbs[CurNumber,2:10]))
        }
        

        Quantiles <- quantile(Sums,c(0.05,0.95))
        CurrentMean <- mean(Sums)

        PValue = 0
        for (Number in 1:100){
            if (ProbFromData[i] >= Sums[Number]){
                PValue <- PValue + 1
            }
        }
        AllPValues <- c(AllPValues, PValue)

        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #        points((i - 1)* 4 + 2.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        #        points((i - 1)* 4 + 2.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        #        points((i - 1)* 4 + 2.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
        
        # print(max(log10(Quantiles[1]) - log10(0.001)), 0)
        # print(max(log10(Quantiles[2]) - log10(0.001)), 0)
        Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.5))
        #        CurrentMean <- mean(Sums)
        FinalMedian <- c(FinalMedian,Quantiles[1])
        counts[2,i] <- Quantiles[1]
        
        Sums <- c()
        for (CurNumber in 1:100){
            Sums <- c(Sums,sum(MatrixP_Allele_Is_2Ns_given_OnePercent[CurNumber,2:10]))
        }
        
        #        Quantiles <- quantile(sum(MatrixP_Allele_Is_2Ns_given_OnePercent[,2:10]),c(0.05,0.95))
        Quantiles <- quantile(Sums,c(0.05,0.95))
        CurrentMean <- mean(Sums)
        
        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #        points((i - 1)* 4 + 1.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        #        points((i - 1)* 4 + 1.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        #        points((i - 1)* 4 + 1.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
        
        
    } else if (i == 1){
        
        Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.05,0.95))
        CurrentMean <- mean(MatrixFinalProbs[,NumberToCheck])
        
        PValue = 0
        for (Number in 1:100){
            if (ProbFromData[i] < MatrixFinalProbs[Number,NumberToCheck]){
                PValue <- PValue + 1
            }
        }
        AllPValues <- c(AllPValues, PValue)
        

        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #        points((i - 1)* 4 + 2.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        #        points((i - 1)* 4 + 2.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        #        points((i - 1)* 4 + 2.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
        
        # print(max(log10(Quantiles[1]) - log10(0.001)), 0)
        # print(max(log10(Quantiles[2]) - log10(0.001)), 0)
        Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.5))
        FinalMedian <- c(FinalMedian,Quantiles[1])
        counts[2,i] <- Quantiles[1]
        
        Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,NumberToCheck],c(0.05,0.95))
        CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,NumberToCheck])
        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #        points((i - 1)* 4 + 1.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        #        points((i - 1)* 4 + 1.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        #        points((i - 1)* 4 + 1.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
    } else if (i == 3){
        
        Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.05,0.95))
        CurrentMean <- mean(MatrixFinalProbs[,NumberToCheck])
        
        PValue = 0
        for (Number in 1:100){
            if (ProbFromData[i] < MatrixFinalProbs[Number,NumberToCheck]){
                PValue <- PValue + 1
            }
        }
        AllPValues <- c(AllPValues, PValue)
        
        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #        points((i - 1)* 4 + 2.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        #        points((i - 1)* 4 + 2.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        #        points((i - 1)* 4 + 2.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
        
        # print(max(log10(Quantiles[1]) - log10(0.001)), 0)
        # print(max(log10(Quantiles[2]) - log10(0.001)), 0)
        Quantiles <- quantile(MatrixFinalProbs[,NumberToCheck],c(0.5))
        FinalMedian <- c(FinalMedian,Quantiles[1])
        counts[2,i] <- Quantiles[1]
        
        Quantiles <- quantile(MatrixP_Allele_Is_2Ns_given_OnePercent[,NumberToCheck],c(0.05,0.95))
        CurrentMean <- mean(MatrixP_Allele_Is_2Ns_given_OnePercent[,NumberToCheck])
        #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
        #        points((i - 1)* 4 + 1.5, Quantiles[1] + 0.01, col="black",pch=24, bg = "black", cex=2)
        #        points((i - 1)* 4 + 1.5, Quantiles[2] + 0.01, col="black", pch=25, bg = "black", cex=2)
        #        points((i - 1)* 4 + 1.5, CurrentMean + 0.01, col="black", pch=8, bg = "black", cex=2)
    }

}

dev.off()
