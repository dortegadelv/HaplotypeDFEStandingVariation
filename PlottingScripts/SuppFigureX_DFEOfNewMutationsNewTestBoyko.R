setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

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


Alpha = 0.184
Beta = 319.8626 * 4594/2000

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

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesUK10K.txt")

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

pdf("../Figures/Figure14_UK10KDFE_Boyko.pdf",width=19)
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

pdf("../Figures/SuppFigure14_UK10KDFE_Boyko.pdf",width=19)
par(mar=c(5.1,5.1,4.1,2.1))

barplot(log10(counts)-log10(0.001), main="", ylab="Probability", xlab="4Ns", col=ViridisColors,
legend = c(expression("Inferred P("*bolditalic(s[j])*" | 1%, "* italic(DFE) * ", "* italic(D) * ")"), expression("Inferred P("*bolditalic(s[j])*" | "* italic(DFE) * ")"), expression("Boyko et al 2008 P("*bolditalic(s[j])*" | "* italic(DFE) * ")") ) , ylim = c(0, 3.1), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=2), yaxt="n")

# rownames(counts) <- c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns | DFE)","Boyko et al 2008 P(4Ns | DFE)")

axis (2,at=c(0,1,2,3), labels = c(0,10^-2,10^-1,10^0))

FinalMedian <- c()
for (i in 1:11){
    Quantiles <- quantile(MatrixFinalProbs[,i],c(0.05,0.95))
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 2.5, max(log10(Quantiles[1]) - log10(0.001), 0), col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 2.5, max(log10(Quantiles[2]) - log10(0.001), 0), col="black", pch=25, bg = "black", cex=1)
    
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
    #segments (i,Quantiles[1],x1=i,Quantiles[2],col=ColorViridis[2], lwd = 4, lty=2)
    points((i - 1)* 4 + 1.5, max(log10(Quantiles[1]) - log10(0.001), 0), col="black",pch=24, bg = "black", cex=1)
    points((i - 1)* 4 + 1.5, max(log10(Quantiles[2]) - log10(0.001), 0), col="black", pch=25, bg = "black", cex=1)
    
}


####################################################################################
dev.off()



