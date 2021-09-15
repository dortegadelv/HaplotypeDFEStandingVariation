
Data <- read.table("FullTable.txt")
RecombinationQuantiles <- read.table("QuantilesRecombination.txt")

RecValuesOne <- read.table("../ForwardSims/RecRateSynonymousOnePercentLeftNoCpG.txt")
RecValuesTwo <- read.table("../ForwardSims/RecRateSynonymousOnePercentRightNoCpG.txt")
RecValues <- rbind(RecValuesOne,RecValuesTwo)

for (i in 1:546){
    
    
}


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

# par(mfrow=c(2,3))

TotalErrors <- c()
i <- 1
ConcatenateTestValues <- c()
PolyNum <- 5
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
Error <- sum(abs(Points-Test))
TotalErrors <- c(TotalErrors,Error)

# Test <- lm.out1$coefficients[1] + lm.out1$coefficients[2] * RecombinationQuantiles$V1 + lm.out1$coefficients[3]* RecombinationQuantiles$V1* RecombinationQuantiles$V1 + lm.out1$coefficients[4]* RecombinationQuantiles$V1* RecombinationQuantiles$V1 * RecombinationQuantiles$V1 + lm.out1$coefficients[5]* RecombinationQuantiles$V1* RecombinationQuantiles$V1 * RecombinationQuantiles$V1* RecombinationQuantiles$V1

# + lm.out1$coefficients[5]* RecombinationQuantiles$V1* RecombinationQuantiles$V1 * RecombinationQuantiles$V1* RecombinationQuantiles$V1 + lm.out1$coefficients[6]* RecombinationQuantiles$V1* RecombinationQuantiles$V1 * RecombinationQuantiles$V1* RecombinationQuantiles$V1 * RecombinationQuantiles$V1
# lines(Comparison$V1,Test, col = "red")
# points(t(RecValues), t(SingleTest), col = "blue")
# SingleTest <- lm.out1$coefficients[1] + lm.out1$coefficients[2] * RecValues + lm.out1$coefficients[3]* RecValues * RecValues + lm.out1$coefficients[4]* RecValues * RecValues * RecValues + lm.out1$coefficients[5]* RecValues * RecValues * RecValues * RecValues
# + lm.out1$coefficients[5]* RecValues * RecValues * RecValues * RecValues + lm.out1$coefficients[6]* RecValues * RecValues * RecValues * RecValues  * RecValues
ConcatenateTestValues <- rbind(ConcatenateTestValues, t(SingleTest))
}

print(Test)



# FirstElement <- rbind(FirstElement, Test)
# FirstPoint <- rbind(FirstPoint, Points)
}

#### AdditionalStep

for (i in 1:284){
    if (RecValues$V1[i] >= RecombinationQuantiles$V1[20]){
        ConcatenateTestValues[,i] <- rep.int(1, 403*6)
        print(i)
    }
}

write.table(ConcatenateTestValues, file = "PLGivenSTableWithRecsSyn.txt",row.names= FALSE,col.names = FALSE)

Stuff <- c()
for (i in 1:403){
Stuff <- rbind(Stuff,c( ConcatenateTestValues[ i * 6 + 1:6,545] ))
}
Stuff
write.table(Stuff,"AyCaon.txt",sep="\t")


pdf("../../../../Figures/SuppFigureSX15_PRLinePopExpansionSims.pdf",width=14,height = 10)
par(mar=c(4.1,5.1,2.6,2.1))
par(mfrow = c(2,3))

OrderedVector <- ConcatenateTestValues[1219,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues,OrderedVector,type="o",main=expression(w[1]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,2]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
#abline(v=RecombinationQuantiles$V1[20],lty=2)

OrderedVector <- ConcatenateTestValues[1220,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues,OrderedVector,type="o",main=expression(w[2]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,3]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
#abline(v=RecombinationQuantiles$V1[20],lty=2)


OrderedVector <- ConcatenateTestValues[1221,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues,OrderedVector,type="o",main=expression(w[3]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,4]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
#abline(v=RecombinationQuantiles$V1[20],lty=2)


OrderedVector <- ConcatenateTestValues[1222,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues,OrderedVector,type="o",main=expression(w[4]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,5]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
# abline(v=RecombinationQuantiles$V1[20],lty=2)


OrderedVector <- ConcatenateTestValues[1223,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues,OrderedVector,type="o",main=expression(w[5]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,6]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
# abline(v=RecombinationQuantiles$V1[20],lty=2)

OrderedVector <- ConcatenateTestValues[1224,order(RecValues$V1)]
SortRecValues <- sort(RecValues$V1)

plot(SortRecValues,OrderedVector,type="o",main=expression(w[6]), xlab = "Population scaled recombination rate in the region",  ylab = "Probability", cex.lab=1.7, cex.main=2, pch = 3)
Points <- Data[0:20*403 + 203,7]
points(RecombinationQuantiles$V1,Points,pch=19, col = "red")
# abline(v=RecombinationQuantiles$V1[20],lty=2)

dev.off()

