Data <- read.table("DifRecRate/FullTable.txt")
RecombinationQuantiles <- read.table("DifRecRate/QuantilesRecombination.txt")
RecombinationQuantiles <- RecombinationQuantiles

RecValuesOne <- read.table("DifRecRate/ResampledBpRecRatePerVariantNoCpGLeft.txt")
RecValuesTwo <- read.table("DifRecRate/ResampledBpRecRatePerVariantNoCpGRight.txt")
RecValues <- rbind(RecValuesOne,RecValuesTwo)

VariantsWeirdValues <- c(0,0,0,0,0,0,0,0,0)
ErrorVector <- c()


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

for (PolyNum in 1:9){
i <- 1
ConcatenateTestValues <- c()
TotalErrors <- c()

# PolyNum <- 5
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
#     if (summary(lm.out1)$coefficients[k,4] > 0.05){
#        SignificantPValueNumber <- SignificantPValueNumber + 1
#        ConcatenateErrorValues <- c(ConcatenateErrorValues,rbind(i,k,FourNs))
#    }
    
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

print(round (sum(TotalErrors), digits=4) / length(TotalErrors))

ErrorVector <- c(ErrorVector, round (sum(TotalErrors), digits=4) / length(TotalErrors))
print (SignificantPValueNumber)
NeutralVector <- rbind(NeutralVector, ConcatenateTestValues[203*6+1:6,545])


for (i in 1:nrow(RecValues)){
    if (sum(ifelse(ConcatenateTestValues[,i] <= 0,1,0)) > 0){
        VariantsWeirdValues[PolyNum]=VariantsWeirdValues[PolyNum] + 1
#     ConcatenateTestValues[,i] <- rep.int(1, 403*6)
        print(i)
    }
}

#### AdditionalStep
FileName = paste ("DifRecRate/PLGivenSTableWithRecs", PolyNum,".txt", sep = "")
write.table(ConcatenateTestValues, file = FileName,row.names= FALSE,col.names = FALSE)
}
