library(viridis)
library(here)

### P (allele is 2Ns = x | allele is at 1%)
## This comes from running Results/
args = commandArgs(trailingOnly=TRUE)
print(args)

###Example

MaxLLParameters = "../Results/MaxLLEstimatesDFE.txt"
print (MaxLLParameters)
LLFile = read.table(MaxLLParameters)
print (MaxLLParameters)
Alpha = LLFile$V1
Gamma = LLFile$V2
P_allele_at_OnePercent = 3.08e-07
AllelesWithSelectionCoefficientFile = "ExitOnePercentSValuesPopExpansionBoyko.txt"
NumberOfChromosomesInMostAncestralEpoch = 10000
NumberAllelesSimulatedInDemHistory = 2.025e+11
IntervalLength <- as.double(5)
IntervalNumber <- as.double(30)
AlphaPReFerSim <- 0.184
ScalePReFerSim <- 1599.313



MaxLLParameters = args[1]
print (MaxLLParameters)
LLFile = read.table(MaxLLParameters)
print (MaxLLParameters)
Alpha = LLFile$V1
Gamma = LLFile$V2
P_allele_at_OnePercent = as.double(args[2])
AllelesWithSelectionCoefficientFile = args[3]
NumberOfChromosomesInMostAncestralEpoch = as.double(args[4])
NumberAllelesSimulatedInDemHistory = as.double(args[5])
IntervalLength <- as.double(args[6])
IntervalNumber <- as.double(args[7])

AlphaPReFerSim <- as.double(args[8])
ScalePReFerSim <- as.double(args[9])

print ("Parameters read")
print (Alpha)
print (Gamma)
print (P_allele_at_OnePercent)
print (AllelesWithSelectionCoefficientFile)
print (NumberOfChromosomesInMostAncestralEpoch)
print (NumberAllelesSimulatedInDemHistory)
print (IntervalLength)
print (IntervalNumber)


P_Allele_Is_2Ns_given_OnePercent <- c()

# P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,pgamma(0.5,Alpha,scale=Gamma))
for (i in 1:IntervalNumber){
    # print (i)
    Prob <- pgamma(i*IntervalLength/2,Alpha,scale=Gamma) - pgamma((i-1)*IntervalLength/2,Alpha,scale=Gamma)
    P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent,Prob)
}

#### Number of alleles

Alpha = AlphaPReFerSim
Beta = ScalePReFerSim

P_Allele_Is_2Ns <- c()
NumberOfAllelesAt2Ns <- c()
RealProbs <- c()
# P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,pgamma(0.5,Alpha,scale=Beta))
for (i in 1:IntervalNumber){
    # print (i)
    Prob <- pgamma(i*IntervalLength/2,Alpha,scale=Beta) - pgamma((i-1)*IntervalLength/2,Alpha,scale=Beta)
    P_Allele_Is_2Ns <- c(P_Allele_Is_2Ns,Prob)
    NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(NumberAllelesSimulatedInDemHistory)) # Original Test
    # NumberOfAllelesAt2Ns <- c(NumberOfAllelesAt2Ns,Prob*(1))
}



################################################### Two plots on same place ############################

ColorViridis <- viridis(2)
ViridisColors <- viridis(2)

SelectionCoefficientList <- read.table(AllelesWithSelectionCoefficientFile)

TwoNsValues <- SelectionCoefficientList$V2*NumberOfChromosomesInMostAncestralEpoch


Check <- hist(TwoNsValues,breaks=c((IntervalLength/2)*0:IntervalNumber,1e+100))
Counts_At_OnePercent_Given2Ns <- Check$counts[1:IntervalNumber]

Probabilities_At_One_Percent_Given_2NsMouse= Counts_At_OnePercent_Given2Ns/ (NumberOfAllelesAt2Ns)


###### The whole stuff

ProbsMouse <- P_Allele_Is_2Ns_given_OnePercent[1:IntervalNumber] * P_allele_at_OnePercent

ProbsMouse <- ProbsMouse[1:IntervalNumber] / Probabilities_At_One_Percent_Given_2NsMouse[1:IntervalNumber]

for (i in 1:length(ProbsMouse)){
    if (is.infinite(ProbsMouse[i])){
        ProbsMouse[i] = 0.0
    }
}

Labels <- c()
for (i in 1:IntervalNumber){
    Label <- paste((i-1)*IntervalLength,"-",i*IntervalLength,sep="")
    Labels <- c(Labels,Label)
}
Label <- paste(">","250",sep="")
Labels <- c("0-5","50-55","100-150","150-155","200-205",Label)

pdf("../Results/DFEf_to_DFE.pdf",width=10,height = 3.5)
par(mar=c(4.1,5.1,0.6,2.1))
par(mfrow = c(1,1))

FirstProbsMouse <- ProbsMouse

###### The whole stuff
if (sum(ProbsMouse) > 1.0){
#ProbsMouse <- c(P_Allele_Is_2Ns_given_OnePercent[1:30],1-sum(P_Allele_Is_2Ns_given_OnePercent[1:30]))
#ProbsMouse <- c(P_Allele_Is_2Ns_given_OnePercent[1:20])

ProbsMouse <- ProbsMouse[1:IntervalNumber] / sum (ProbsMouse[1:IntervalNumber] )
ProbsMouse <- c(ProbsMouse,0)

}else {
    
ProbsMouse <- c(ProbsMouse[1:IntervalNumber],1-sum(ProbsMouse[1:IntervalNumber]))
}

# ProbsMouse <- c(1 - sum(ProbsMouse[1:IntervalNumber]),1-sum(P_Allele_Is_2Ns_given_OnePercent[1:IntervalNumber]))
P_Allele_Is_2Ns_given_OnePercent <- c(P_Allele_Is_2Ns_given_OnePercent[1:IntervalNumber], 1 - sum(P_Allele_Is_2Ns_given_OnePercent[1:IntervalNumber]))
Labels <- c()
for (i in 1:IntervalNumber){
    Label <- paste((i-1)*IntervalLength,"-",i*IntervalLength,sep="")
    Labels <- c(Labels,Label)
}
Label <- paste(">","250",sep="")
Labels <- c(Labels,Label)


counts <- table(mtcars$vs, mtcars$gear)
# counts <- rbind(counts,c(1,2,3))
# counts <- rbind(counts,c(1,2,3))
for (i in 4:(IntervalNumber+1)){
    counts <- cbind(counts,c(ProbsMouse[i], P_Allele_Is_2Ns_given_OnePercent[i]))
}
# counts[1,1] <- P_Allele_Is_2Ns[1]
# counts[1,2] <- P_Allele_Is_2Ns[2]
# counts[1,3] <- P_Allele_Is_2Ns[3]
counts[1,1] <- ProbsMouse[1]
counts[1,2] <- ProbsMouse[2]
counts[1,3] <- ProbsMouse[3]
# counts[3,1] <- ProbsMouse[1]
# counts[3,2] <- ProbsMouse[2]
# counts[3,3] <- ProbsMouse[3]
counts[2,1] <- P_Allele_Is_2Ns_given_OnePercent[1]
counts[2,2] <- P_Allele_Is_2Ns_given_OnePercent[2]
counts[2,3] <- P_Allele_Is_2Ns_given_OnePercent[3]

# counts <- cbind(counts,c( 1 - sum(ProbsMouse[1:IntervalNumber]), 1 - sum(P_Allele_Is_2Ns_given_OnePercent[1:IntervalNumber])))

for ( i in 1:2){
    for (j in 1:(IntervalNumber+1)){
        if (counts[i,j] <= 1e-8){
            counts[i,j] = 1e-8
        }
    }
}


# rownames(counts) <- c(expression("Real P("*bolditalic(s[j])*" | DFE, D)"), expression("Inferred P("*bolditalic(s[j])*" | DFE, D)  Equation 4"),expression("Inferred P("*bolditalic(s[j])*" | DFE, D)  Equation 5"), expression("P("*bolditalic(s[j])*" | 1%, DFE, D)"))

Labels <- c()
Position <- c()
for (i in 1:(IntervalNumber-5)){
    ThisLabel <- paste((i-1)*5,"-",i*5, sep = "")
    Labels <- c(Labels,ThisLabel)
    Number <- (i-1) * 4 + 3
    Position <- c(Position, Number)
}
OtherLabels <- c()
OtherPosition <- c()
for (i in (IntervalNumber-5):IntervalNumber){
    ThisLabel <- paste("", sep = "")
    OtherLabels <- c(OtherLabels,ThisLabel)
    Number <- (i-1) * 4 + 3
    OtherPosition <- c(OtherPosition, Number)
}


Number <- (IntervalNumber) * 4 + 3
Position <- c(Position, Number)

ThisLabel <- paste(">",i*5, sep = "")
Labels <- c(Labels,ThisLabel)

# Label <- paste(">","150",sep="")
# Labels <- c("0-5","50-55","100-105",Label)

barplot(log10(counts)-log10(0.00000001), main="", ylab="Probability", xlab="4Ns", col=ViridisColors,
legend = c(expression( expression("Inferred"  ~ 'P'[psi] * "(" * bolditalic(s[j]) * ")"), expression('P'[psi]* "("* bolditalic(s[j])*" | "* italic(f) * ", "* italic(D) *")"))), ylim = c(0, 8), beside=TRUE,cex.lab=2,cex.axis=2,cex.names=2, args.legend = list(x = "top",cex= 0.95), yaxt="n", xaxt = "n", space = c(0, 2))

axis (2,at=c(0,2,4,6,8), labels = c("< 10^-8",10^-6,10^-4,10^-2,10^0), cex.axis = 0.8)

axis(1, at=Position, labels=Labels,cex.lab=1,cex=1,cex.axis=1,col.ticks="red")
axis(1, at=OtherPosition, labels=OtherLabels,cex.lab=1,cex=1,cex.axis=1,col.ticks="red")


#Expression <- expression("Real " ~ 'P'[psi] ~ "(bolditalic(s[j]), | DFE, D)")
Expression2 <- expression(paste("Inferred P(",bolditalic(s[j])," | DFE, D)  Equation 5"))
Expression3 <- expression(paste("P(",bolditalic(s[j])," | 1%, DFE, D)"))
dev.off()

DataTable = data.frame(
  P_sj_given_DemHistory_Frequency = P_Allele_Is_2Ns_given_OnePercent[1:(IntervalNumber+1)],
  P_sj = ProbsMouse[1:(IntervalNumber+1)]
)

value <- c()
for (i in 1:IntervalNumber){
    
    Multiplier <- paste((i-1)*IntervalLength,"-",i*IntervalLength,sep="")
    value <- c(value,Multiplier)
    
}
Multiplier <- paste(">",IntervalNumber*IntervalLength,sep="")
value <- c(value,Multiplier)

row.names(DataTable) <- value

write.table(DataTable,file="../Results/Probabilities.txt",col.names=NA, sep = "\t")

