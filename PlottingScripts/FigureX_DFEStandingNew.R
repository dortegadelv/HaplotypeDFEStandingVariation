setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")



################################################### Two plots on same place ############################



Alpha = 0.184
Beta = 319.8626 * 5

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
Beta = 8636364 * 0.005

# P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,Alpha,scale=Beta) - pgamma((i-1)*2.5,Alpha,scale=Beta)
    #   P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((80000 + (100000/10000)*100)*2500*1000)) # Original Test
    #    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}


### P (allele is 2Ns = x | allele is at 1%)
## This comes from running Results/

Alpha = 0.190915110603425
Beta = 29.1767603378041

P_Allele_Is_2Ns_given_OnePercent <- c()

# P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:200){
    # print (i)
    Prob <- pgamma(i*2.5,Alpha,scale=Beta) - pgamma((i-1)*2.5,Alpha,scale=Beta)
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
}

P_Allele_Is_2Ns_given_OnePercent <- c()

FourNs <- SelectionCoefficientListBoyko$V2 * 20000
for (i in 1:200){
    UpperBound <- i*5
    LowerBound <- (i-1)*5
    CurrentSum <- (sum(FourNs < UpperBound) - sum(FourNs < LowerBound))/nrow(SelectionCoefficientListBoyko)
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,CurrentSum)
}




SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouse5000.txt")

FourNsValues <- SelectionCoefficientList$V2*10000

Check <- hist(FourNsValues,breaks=c(5*0:200))
Counts_At_OnePercent_Given4Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given4Ns/ (NumberOfAllelesAt2Ns*2)


###### The whole stuff

ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent * P_allele_at_OnePercent

ProbsMouse <- ProbsMouse[1:40] / Probabilities_At_One_Percent_Given_2NsMouse[1:40]

Labels <- c()
for (i in 1:25){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}

##################################### Another try on the mouse #####################################


SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouse5000.txt")

TotalAlleleNumber <- ((80000 + (100000/10000)*100)*2500*1000)*2

TwoNsValues <- SelectionCoefficientList$V2*10000

Check <- hist(TwoNsValues,breaks=c(2.5*0:200),plot=FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:20],sum(Counts_At_OnePercent_Given2Ns[21:200]))/ c((NumberOfAllelesAt2Ns[1:20]*2),TotalAlleleNumber - sum(NumberOfAllelesAt2Ns[1:20]*2))


###### The whole stuff

ProbsMouse <- c(P_Allele_Is_2Ns_given_OnePercent[1:20],1-sum(P_Allele_Is_2Ns_given_OnePercent[1:20]))

ProbsMouse <- ProbsMouse[1:21] / Probabilities_At_One_Percent_Given_2NsMouse[1:21]

ProbsMouse <- ProbsMouse[1:21] / sum (ProbsMouse[1:21] )

Labels <- c()
for (i in 1:20){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}
Label <- paste(">","100",sep="")
Labels <- c(Labels,Label)

pdf("../Figures/Figure7_DifferencesActualDFEMouseNew.pdf",width=14)
par(mar=c(5.1,5.1,4.1,2.1))

plot(1:21,c(P_Allele_Is_2Ns[1:20], 1 - sum(P_Allele_Is_2Ns[1:20])),col="red",ylim=c(0,0.8),xaxt="n",ylab="Probability",xlab="4Ns",lwd=3,cex.lab=2,cex.axis=2,cex.lab=2, main = "B)",cex.main = 2)
lines(1:21,ProbsMouse[1:21],col="blue",lwd=3)
lines(1:21,c(P_Allele_Is_2Ns_given_OnePercent[1:20], 1 - sum(P_Allele_Is_2Ns_given_OnePercent[1:20])) ,col="green",lwd=3)
legend("top",c("Real P(4Ns | DFE)","Inferred P(4Ns | DFE) Equation B", "P(4Ns | 1%, DFE, D)"),pch=19,col=c("red","blue","green"),cex=2)
axis(1, at=c(1:21), labels=Labels,cex.lab=1.5,cex=1.5,cex.axis=1.5)
dev.off()

