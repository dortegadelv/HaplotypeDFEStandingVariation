setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

library(viridis)

### P (allele is 2Ns = x | allele is at 1%)

Alpha = 0.01
Beta = 0.003

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
	NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*71365715607)
}
Prob <- 1 - pgamma(25,Alpha,scale=Beta)
NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*71365715607)

#### The number of alleles comes from the population expansion model ( (1000*22971) + (1000*9109/4594 * 1221) + (1000*1171/4594 * 352) + (1000*2674/4594 * 229) + ( 1000*220758/4594 * 61) ) * 2500

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesUK10K.txt")

TwoNsValues <- SelectionCoefficientList$V2*4594

Check <- hist(TwoNsValues,breaks=c(0,2.5,5,7.5,10,12.5,15,17.5,20,22.5,25,100000000))
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2Ns= Counts_At_OnePercent_Given2Ns/ NumberOfAllelesAt2Ns

###### The whole stuff

Probs <- P_Allele_Is_2Ns_given_OnePercent

## This is the over the number of NonCpG sites where a nonsynonymous mutation can take place
Prob_One_Percent <- 273 / 61209909

Probs <- Probs[1:11] * Prob_One_Percent / Probabilities_At_One_Percent_Given_2Ns[1:11]

# Probs <- Probs[1:11] / sum (Probs[1:11] )


Labels <- c()
for (i in 1:10){
Label <- paste((i-1)*5,"-",i*5,sep="")
	Labels <- c(Labels,Label)
}

Label <- paste(">",50,sep="")
Labels <- c(Labels,Label)

pdf("../Figures/Figure9_UK10KDFE_StandingNew.pdf",width=19)
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
Prob <- pgamma(5*i,Alpha,scale=Beta) - pgamma(5*(i-1),Alpha,scale=Beta)
ProbsBoyko <- c(ProbsBoyko, Prob)
}
Prob <- 1 - pgamma(50,Alpha,scale=Beta)
ProbsBoyko <- c(ProbsBoyko, Prob)

Alpha = 0.207
Beta = 1082.3 * 4594/(2*11261)

ProbsKim <- c()
for (i in 1:10){
    Prob <- pgamma(5*i,Alpha,scale=Beta) - pgamma(5*(i-1),Alpha,scale=Beta)
    ProbsKim <- c(ProbsKim, Prob)
}
Prob <- 1 - pgamma(50,Alpha,scale=Beta)
ProbsKim <- c(ProbsKim, Prob)


counts <- table(mtcars$vs, mtcars$gear)
counts <- rbind(counts,c(1,2,3))
counts <- rbind(counts,c(1,2,3))
# counts <- cbind(counts,c(Probs[3],P_Allele_Is_2Ns_given_OnePercent[3]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[4],Probs[4],ProbsBoyko[4],ProbsKim[4]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[5],Probs[5],ProbsBoyko[5],ProbsKim[5]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[6],Probs[6],ProbsBoyko[6],ProbsKim[6]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[7],Probs[7],ProbsBoyko[7],ProbsKim[7]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[8],Probs[8],ProbsBoyko[8],ProbsKim[8]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[9],Probs[9],ProbsBoyko[9],ProbsKim[9]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[10],Probs[10],ProbsBoyko[10],ProbsKim[10]))
counts <- cbind(counts,c(P_Allele_Is_2Ns_given_OnePercent[11],Probs[11],ProbsBoyko[11],ProbsKim[11]))
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
rownames(counts) <- c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns| DFE)","Boyko et al 2008 P(4Ns| DFE)", "Kim et al 2017 P(4Ns| DFE)")
ViridisColors <- viridis(4)
pdf("../Figures/Figure9_BarPlot_UK10KDFE_StandingNew.pdf",width=19)
par(mar=c(5.1,5.1,4.1,2.1))
barplot(log10(counts)-log10(0.001), main="", ylab="Probability", xlab="4Ns", col=ViridisColors,
  	legend = rownames(counts), ylim = c(0, 3), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex=2), yaxt="n")

axis (2,at=c(0,1,2,3), labels = c(10^-3,10^-2,10^-1,10^0))
# counts <- table(Probs[1:11], P_Allele_Is_2Ns_given_OnePercent[1:11])
# plot(1:11, Probs[1:11], col="blue", ylim=c(0,0.9), xaxt="n", ylab="Probability", xlab="4Ns", lwd=3, cex.lab=2, cex.axis=2, lty=1, type = "o")
# lines(1:15,Probs[1:15],col="blue",lwd=3)
# lines(1:11,P_Allele_Is_2Ns_given_OnePercent[1:11],col="green",lwd=3, type = "o")
# legend("topright",c("Inferred P(4Ns | 1%, DFE, D)", "Inferred P(4Ns| DFE)"),pch=19,col=c("blue","green"),cex=2)
# axis(1, at=c(1:11), labels=Labels,cex.axis=2)
dev.off()



