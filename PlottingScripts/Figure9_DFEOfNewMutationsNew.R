setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

### I want to calculate:
#
# P (allele is 2Ns = x) =  ( P (allele is 2Ns = x | allele is at 1%) P (allele is at 1%) ) / P (allele at 1% | allele is 2Ns = x)
#                                  

### P (allele is at 1%)
### Number of 1%ers in data = 741 ## Or 186509
### Number of all variants = 70867 ## 58295619.05

P_allele_at_OnePercent = 741/1258700644

### P (allele is 2Ns = x | allele is at 1%)

Alpha = 0.11
Beta = 250

P_Allele_Is_2Ns_given_OnePercent <- c()

# P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
# print (i)
	Prob <- pgamma(i*5,Alpha,scale=Beta) - pgamma((i-1)*5,Alpha,scale=Beta)
	P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
}

### P (allele is at 1% | allele is 2Ns x)


Alpha = 0.184
Beta = 319.8626 * 2.297

P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
# print (i)
	Prob <- pgamma(i*5,Alpha,scale=Beta) - pgamma((i-1)*5,Alpha,scale=Beta)
	P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
	NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*71365715607)
}

#### The number of alleles comes from the population expansion model ( (1000*22971) + (1000*9109/4594 * 1221) + (1000*1171/4594 * 352) + (1000*2674/4594 * 229) + ( 1000*220758/4594 * 61) ) * 2500

SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesUK10K.txt")

TwoNsValues <- SelectionCoefficientList$V2*4594

Check <- hist(TwoNsValues,breaks=c(5*0:200))
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2Ns= Counts_At_OnePercent_Given2Ns/ NumberOfAllelesAt2Ns

###### The whole stuff

Probs <- P_Allele_Is_2Ns_given_OnePercent

Probs <- Probs[1:25] / Probabilities_At_One_Percent_Given_2Ns[1:25]

Probs <- Probs[1:25] / sum (Probs[1:25] )


Labels <- c()
for (i in 1:25){
Label <- paste((i-1)*5,"-",i*5,sep="")
	Labels <- c(Labels,Label)
}

pdf("../Figures/Figure9_UK10KDFE_StandingNew.pdf",width=15)
par(mar=c(5.1,5.1,4.1,2.1))

plot(1:25, Probs[1:25], col="blue", ylim=c(0,0.9), xaxt="n", ylab="Probability", xlab="2Ns", lwd=3, cex.lab=2, cex.axis=2, lty=1, type = "o")
# lines(1:15,Probs[1:15],col="blue",lwd=3)
lines(1:25,P_Allele_Is_2Ns_given_OnePercent[1:25],col="green",lwd=3, type = "o")
legend("topright",c("Inferred P(2Ns)", "Inferred P(2Ns| 1%)"),pch=19,col=c("blue","green"),cex=2)
axis(1, at=c(1:25), labels=Labels,cex.axis=2)
dev.off()


