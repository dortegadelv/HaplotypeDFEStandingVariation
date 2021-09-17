
library(viridis)
library(here)

################################################### Two plots on same place ############################

ColorViridis <- viridis(3)
ViridisColors <- viridis(3)


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
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((120000 + (100000/10000)*100)*2500*1000)) # Original Test
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}



SelectionCoefficientListBoyko <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionBoykoLongerBurnIn.txt")



### P (allele is at 1%)

P_allele_at_OnePercent = nrow(SelectionCoefficientListBoyko)/((120000 + (100000/10000)*100)*2500*1000) # Original
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
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*((120000 + (100000/10000)*100)*2500*1000)) # Original Test
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


SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouseLongerBurnIn.txt")

TwoNsValues <- SelectionCoefficientList$V2*10000

Check <- hist(TwoNsValues,breaks=c(2.5*0:200))
Counts_At_OnePercent_Given2Ns <- Check$counts

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns/ (NumberOfAllelesAt2Ns)


###### The whole stuff

ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent * P_allele_at_OnePercent

ProbsMouse <- ProbsMouse[1:20] / Probabilities_At_One_Percent_Given_2NsMouse[1:20]

Labels <- c()
for (i in 1:20){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}
Label <- paste(">","100",sep="")
Labels <- c("0-5","50-55",Label)

pdf("../Figures/SuppFigure6_DFEStandingToNewVariationBarPlotAltLongerBurnIn.pdf",width=10,height = 3.5)
par(mar=c(4.1,5.1,0.6,2.1))
par(mfrow = c(1,1))

# plot(1:51,c(P_Allele_Is_2Ns[1:50], 1 - sum(P_Allele_Is_2Ns[1:50])),col=ColorViridis[1],ylim=c(0,0.67),xaxt="n",ylab="Probability",xlab="4Ns",lwd=3,cex.lab=2,cex.axis=2,cex.lab=2, main = "",cex.main = 2,pch=19)
# lines(1:51,c(ProbsMouse[1:50], 1 - sum(ProbsMouse[1:50])),col=ColorViridis[2],lwd=3)
# lines(1:51,c(P_Allele_Is_2Ns_given_OnePercent[1:50],  1 - sum(P_Allele_Is_2Ns_given_OnePercent[1:50])),col=ColorViridis[4],lwd=3)
Expression <- expression(paste("Real P(",bolditalic(s[j])," | DFE, D)"))
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 4"))
Expression3 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression4 <- expression(paste("P(",bolditalic(s[j])," | 1%, DFE, D)"))
# legend("top",c(Expression, Expression2, Expression3, Expression4),pch=19,col=ColorViridis,cex=1)
# axis(1, at=c(1:51), labels=FALSE,cex.lab=1,cex=1,cex.axis=1)
# axis(1, at=c(1,11,21,31,41,51), labels=Labels,cex.lab=1,cex=1,cex.axis=1,col.ticks="red")
#dev.off()
FirstProbsMouse <- ProbsMouse
##################################### Another try on the mouse #####################################


SelectionCoefficientList <- read.table("../Results/CalculateDFEOfNewMutations/ExitOnePercentSValuesPopExpansionMouseLongerBurnIn.txt")

TotalAlleleNumber <- ((120000 + (100000/10000)*100)*2500*1000)

TwoNsValues <- SelectionCoefficientList$V2*10000

Check <- hist(TwoNsValues,breaks=c(2.5*0:200),plot=FALSE)
Counts_At_OnePercent_Given2Ns <- Check$counts

Alpha = 0.11
Beta = 8636364 * 0.005

LastAlleleNumber <- (1-pgamma(50,Alpha,scale=Beta))* ((120000 + (100000/10000)*100)*2500*1000)

Probabilities_At_One_Percent_Given_2NsMouse= c(Counts_At_OnePercent_Given2Ns[1:20],sum(Counts_At_OnePercent_Given2Ns[21:200]))/ c((NumberOfAllelesAt2Ns[1:20]),LastAlleleNumber )


###### The whole stuff

ProbsMouse <- c(P_Allele_Is_2Ns_given_OnePercent[1:20],1-sum(P_Allele_Is_2Ns_given_OnePercent[1:20]))
#ProbsMouse <- c(P_Allele_Is_2Ns_given_OnePercent[1:20])

ProbsMouse <- ProbsMouse[1:21] / Probabilities_At_One_Percent_Given_2NsMouse[1:21]

ProbsMouse <- ProbsMouse[1:21] / sum (ProbsMouse[1:21] )

Labels <- c()
for (i in 1:37){
    Label <- paste((i-1)*5,"-",i*5,sep="")
    Labels <- c(Labels,Label)
}
Label <- paste(">","100",sep="")
Labels <- c(Labels,Label)


counts <- table(mtcars$vs, mtcars$gear)
counts <- rbind(counts,c(1,2,3))
# counts <- rbind(counts,c(1,2,3))
for (i in 4:20){
    counts <- cbind(counts,c(P_Allele_Is_2Ns[i], FirstProbsMouse[i], P_Allele_Is_2Ns_given_OnePercent[i]))
}
counts[1,1] <- P_Allele_Is_2Ns[1]
counts[1,2] <- P_Allele_Is_2Ns[2]
counts[1,3] <- P_Allele_Is_2Ns[3]
counts[2,1] <- FirstProbsMouse[1]
counts[2,2] <- FirstProbsMouse[2]
counts[2,3] <- FirstProbsMouse[3]
# counts[3,1] <- ProbsMouse[1]
# counts[3,2] <- ProbsMouse[2]
# counts[3,3] <- ProbsMouse[3]
counts[3,1] <- P_Allele_Is_2Ns_given_OnePercent[1]
counts[3,2] <- P_Allele_Is_2Ns_given_OnePercent[2]
counts[3,3] <- P_Allele_Is_2Ns_given_OnePercent[3]


counts <- cbind(counts,c(1-sum(P_Allele_Is_2Ns[1:20]), 1 - sum(FirstProbsMouse[1:20]), 1 - sum(P_Allele_Is_2Ns_given_OnePercent[1:20])))

for ( i in 1:3){
    for (j in 1:21){
        if (counts[i,j] <= 1e-8){
            counts[i,j] = 1e-5
        }
    }
}

# rownames(counts) <- c(expression("Real P("*bolditalic(s[j])*" | DFE, D)"), expression("Inferred P("*bolditalic(s[j])*" | DFE, D)  Equation 4"),expression("Inferred P("*bolditalic(s[j])*" | DFE, D)  Equation 5"), expression("P("*bolditalic(s[j])*" | 1%, DFE, D)"))

Label <- paste(">","100",sep="")
Labels <- c("0-5","50-55",Label)


barplot(log10(counts)-log10(0.00001), main="", ylab="Probability", xlab=expression(bolditalic(s[j]) * " (4Ns intervals)"), col=ViridisColors,
legend = c(expression("Real" ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression('P'[psi]* "("* bolditalic(s[j])*" | "* italic(f) * ", "* italic(D) *")")), ylim = c(0, 5), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex= 0.95), yaxt="n", xaxt = "n", space = c(0, 2))

axis (2,at=c(0,1,2,3,4,5), labels = c(0,10^-4,10^-3,10^-2,10^-1,10^0), cex.axis = 0.8)

axis(1, at=c(3.5, 53.5, 103.5), labels=Labels,cex.lab=1,cex=1,cex.axis=1,col.ticks="red")


#pdf("DifferencesActualDistMouseNew.pdf",width=14)
# par(mar=c(4.1,5.1,2.6,2.1))

#plot(1:21,c(P_Allele_Is_2Ns[1:20], 1 - sum(P_Allele_Is_2Ns[1:20])),col=ColorViridis[1],ylim=c(0,0.8),xaxt="n",ylab="Probability",xlab="4Ns",lwd=3,cex.lab=2,cex.axis=2,cex.lab=2, main = "B)",cex.main = 2,pch=19)
#lines(1:51,c(ProbsMouse[1:50],1-sum(ProbsMouse[1:50])),col=ColorViridis[3],lwd=3, lty=2)
#lines(1:21,c(P_Allele_Is_2Ns_given_OnePercent[1:20], 1 - sum(P_Allele_Is_2Ns_given_OnePercent[1:20])) ,col=ColorViridis[3],lwd=3)
Expression <- expression("Real " ~ 'P'[psi] ~ "(bolditalic(s[j]), | DFE, D)")
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression3 <- expression(paste("P(",bolditalic(s[j])," | 1%, DFE, D)"))
#legend("top",c(Expression, Expression2, Expression3),pch=19,col=ColorViridis,cex=1)
#axis(1, at=c(1:21), labels=Labels,cex.lab=1,cex=1,cex.axis=1)
dev.off()

ResultsConcatenated <- c(P_allele_at_OnePercent,Probabilities_At_One_Percent_Given_2NsMouse[1:21], P_allele_at_OnePercent /Probabilities_At_One_Percent_Given_2NsMouse[1:21] )

write.table(ResultsConcatenated, file = "../Figures/FiguresTableS3LongerBurnIn.txt",row.names = FALSE)


