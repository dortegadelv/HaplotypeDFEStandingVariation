setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")
Data <- read.table("../Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims/FullTable.txt")
RecombinationQuantiles <- read.table("../Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims/QuantilesRecombination.txt")

RecValuesOne <- read.table("../Scripts/Sims/UK10K_OnePercenters/ForwardSims/RecRateMissenseOnePercentLeftNoCpG.txt")
RecValuesTwo <- read.table("../Scripts/Sims/UK10K_OnePercenters/ForwardSims/RecRateMissenseOnePercentRightNoCpG.txt")
RecValues <- rbind(RecValuesOne,RecValuesTwo)

ErrorVector <- c()

for (i in 1:546){
    
    
}

VariantsWeirdValues <- c(0,0,0,0,0,0,0,0,0)

AllCoefficients <- c()

for (i in 1:403){
    
    Points <- Data[0:20*403 + i,2]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out1 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)
    
    Points <- Data[0:20*403 + i,3]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out2 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)

    Points <- Data[0:20*403 + i,4]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out3 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)
    
    Points <- Data[0:20*403 + i,5]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out4 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)
    
    Points <- Data[0:20*403 + i,6]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out5 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)
    
    Points <- Data[0:20*403 + i,7]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out6 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)

    Row <- c(lm.out1$coefficients, lm.out2$coefficients, lm.out3$coefficients, lm.out4$coefficients, lm.out5$coefficients, lm.out6$coefficients )
    AllCoefficients <- rbind(AllCoefficients,Row)
}

write.table(AllCoefficients, file = "AllRegressionCoefficients.txt",row.names= FALSE,col.names = FALSE)

NeutralVector <- c()
# par(mfrow=c(2,3))

SignificantPValueNumber <- 0
TotalErrors <- c()
ConcatenateErrorValues <- c()

for (PolyNum in 5:5){
    TotalErrors <- c()

i <- 1
ConcatenateTestValues <- c()
# PolyNum <- 6
for (FourNs in 1:403){
    print (FourNs)
    FirstElement <- c()
    FirstPoint <- c()
    RecTestValue <- 4000
    AllComparisons <- c(t(RecombinationQuantiles))
    for (i in 2:7){
    Points <- Data[0:20*403 + FourNs,i]
    Comparison <- cbind(RecombinationQuantiles,Points)
    AllComparisons <- cbind(AllComparisons, Points)
    lm.out1 = lm(Points ~ poly(V1,PolyNum,raw=TRUE),Comparison)
    # plot(Comparison$V1,Comparison$Points)

    for (k in 1:(PolyNum+1)){
        if (summary(lm.out1)$coefficients[k,4] > 0.05){
            SignificantPValueNumber <- SignificantPValueNumber + 1
            ConcatenateErrorValues <- c(ConcatenateErrorValues,rbind(i,k,FourNs))
        }
        
    }


Test <- 0
SingleTest <- 0
for (Nums in 1:(PolyNum+1)){

CurrentMultiplication <- lm.out1$coefficients[Nums]
SingleMult <- lm.out1$coefficients[Nums]
if (Nums > 1){
    for (MulNum in 1:(Nums - 1) ){
    CurrentMultiplication <- CurrentMultiplication * RecombinationQuantiles$V1
    SingleMult <- SingleMult * RecValues
    }
}
Test <- Test + CurrentMultiplication
SingleTest <- SingleTest + SingleMult
}
Error <- sum(abs(Points[1:20]-Test[1:20]))
TotalErrors <- c(TotalErrors,Error)

ConcatenateTestValues <- rbind(ConcatenateTestValues, t(SingleTest))
}

print(Test)



# FirstElement <- rbind(FirstElement, Test)
# FirstPoint <- rbind(FirstPoint, Points)
}

ErrorVector <- c(ErrorVector, round (sum(TotalErrors), digits=4) / length(TotalErrors))
print (SignificantPValueNumber)
# NeutralVector <- rbind(NeutralVector, ConcatenateTestValues[203*6+1:6,545])


#### AdditionalStep

for (i in 1:550){
    if (RecValues$V1[i] >= RecombinationQuantiles$V1[20]){
        VariantsWeirdValues[PolyNum]=VariantsWeirdValues[PolyNum] + 1
#    ConcatenateTestValues[,i] <- rep.int(1, 403*6)
        print(i)
    }
}


#### AdditionalStep
FileName = paste ("PLGivenSTableWithRecs", PolyNum,".txt", sep = "")
write.table(ConcatenateTestValues, file = FileName,row.names= FALSE,col.names = FALSE)
}

ImprovementVector <- c()
for (i in 2:9){
    ImprovementVector <- c(ImprovementVector, (ErrorVector[i-1]-ErrorVector[i])/ErrorVector[i-1])
}

write.table(ConcatenateTestValues, file = "PLGivenSTableWithRecs.txt",row.names= FALSE,col.names = FALSE)

Stuff <- c()
for (i in 1:403){
Stuff <- rbind(Stuff,c( ConcatenateTestValues[ i * 6 + 1:6,545] ))
}
Stuff
write.table(Stuff,"AyCaon.txt",sep="\t")


pdf("../Figures/SuppFigure46_PRLine.pdf",width=14,height = 10)
par(mar=c(4.1,5.1,2.6,2.1))
par(mfrow = c(2,3))

OrderedVector <- ConcatenateTestValues[1213,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues[1:522],OrderedVector[1:522],type="l",main=expression(w[1]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,2]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
#abline(v=RecombinationQuantiles$V1[20],lty=2)

OrderedVector <- ConcatenateTestValues[1214,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues[1:522],OrderedVector[1:522],type="l",main=expression(w[2]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,3]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
#abline(v=RecombinationQuantiles$V1[20],lty=2)


OrderedVector <- ConcatenateTestValues[1215,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues[1:522],OrderedVector[1:522],type="l",main=expression(w[3]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,4]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
#abline(v=RecombinationQuantiles$V1[20],lty=2)


OrderedVector <- ConcatenateTestValues[1216,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues[1:522],OrderedVector[1:522],type="l",main=expression(w[4]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,5]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
# abline(v=RecombinationQuantiles$V1[20],lty=2)


OrderedVector <- ConcatenateTestValues[1217,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues[1:522],OrderedVector[1:522],type="l",main=expression(w[5]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,6]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
# abline(v=RecombinationQuantiles$V1[20],lty=2)

OrderedVector <- ConcatenateTestValues[1218,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues[1:522],OrderedVector[1:522],type="l",main=expression(w[6]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,7]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
# abline(v=RecombinationQuantiles$V1[20],lty=2)

dev.off()

