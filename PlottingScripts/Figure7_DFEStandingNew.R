setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

SelectionCoefficientListBoyko <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionBoyko.txt")



### P (allele is at 1%)

P_allele_at_OnePercent = nrow(SelectionCoefficientListBoyko)/((10000*80000 + 100000*100)*2500*1000) # Original Test
#P_allele_at_OnePercent = 62412/(1)


Alpha = 0.190915110603425
Beta = 29.1767603378041

P_Allele_Is_2Ns_given_OnePercent <- c()

# P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*5,Alpha,scale=Beta) - pgamma((i-1)*5,Alpha,scale=Beta)
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
}


Alpha = 0.184
Beta = 319.8626 * 5

P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*5,Alpha,scale=Beta) - pgamma((i-1)*5,Alpha,scale=Beta)
    P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((10000*80000 + 100000*100)*2500*1000)) # Original Test
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}

Alpha = 0.11
Beta = 8636364 * 0.005

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*5,Alpha,scale=Beta) - pgamma((i-1)*5,Alpha,scale=Beta)
#   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((10000*80000 + 100000*100)*2500*1000)) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}


SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouseApprox5000.txt")

TwoNsValues <- SelectionCoefficientList$V2*10000

Check <- hist(TwoNsValues,breaks=c(5*0:200))
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns/ (NumberOfAllelesAt2Ns*2)


###### The whole stuff

ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent * P_allele_at_OnePercent

ProbsMouse <- ProbsMouse[1:40] / Probabilities_At_One_Percent_Given_2NsMouse[1:40]

Labels <- c()
for (i in 1:25){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}

##################################### Another try on the mouse #####################################


SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouseApprox5000.txt")

TwoNsValues <- SelectionCoefficientList$V2*10000

Check <- hist(TwoNsValues,breaks=c(5*0:200))
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns/ (NumberOfAllelesAt2Ns*2)


###### The whole stuff

ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent

ProbsMouse <- ProbsMouse[1:28] / Probabilities_At_One_Percent_Given_2NsMouse[1:28]

ProbsMouse <- ProbsMouse[1:28] / sum (ProbsMouse[1:28] )

Labels <- c()
for (i in 1:25){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}


pdf("../Figures/Figure7_DifferencesActualDFEMouse.pdf",width=14)
par(mar=c(5.1,5.1,4.1,2.1))

plot(1:25,P_Allele_Is_2Ns[1:25],col="red",ylim=c(0,0.8),xaxt="n",ylab="Probability",xlab="2Ns",lwd=3,cex.lab=2,cex.axis=2,cex.lab=2)
lines(1:25,ProbsMouse[1:25],col="blue",lwd=3)
lines(1:25,P_Allele_Is_2Ns_given_OnePercent[1:25],col="green",lwd=3)
legend("topright",c("Real P(2Ns)","Inferred P(2Ns)", "P(2Ns| 1%, DFE, D)"),pch=19,col=c("red","blue","green"),cex=2)
axis(1, at=c(1:25), labels=Labels,cex.lab=2,cex=2,cex.axis=2)
dev.off()

