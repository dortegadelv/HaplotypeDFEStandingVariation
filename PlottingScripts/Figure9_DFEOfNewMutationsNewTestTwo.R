setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")


### P (allele is 2Ns = x | allele is at 1%)

Alpha = 0.1
Beta = 250

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

Probs <- Probs[1:11] / Probabilities_At_One_Percent_Given_2Ns[1:11]

Probs <- Probs[1:11] / sum (Probs[1:11] )


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


