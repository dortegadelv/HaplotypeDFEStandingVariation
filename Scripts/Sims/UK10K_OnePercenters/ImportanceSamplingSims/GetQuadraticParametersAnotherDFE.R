

Data <- read.table("PLGivenSTableWithRecs.txt")
DFETable <- read.table("AnotherDFETableOfProbabilities.txt")

RecValuesOne <- read.table("~/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RecRateMissenseOnePercentRightNoCpG.txt")

RecValuesTwo <- read.table("~/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RecRateMissenseOnePercentLeftNoCpG.txt")

RecValues <- rbind(RecValuesOne,RecValuesTwo)

FullDataTable <- matrix(nrow = nrow(DFETable)*6+12, ncol = 546)

TotalCount <- 1
# for (i in 1:nrow(DFETable)){
for (i in 1:2){
    print (i)
    Subset <- DFETable[i,3:ncol(DFETable)]
for (Element in 1:6){
    #    print (Element)
    FullDataTable[TotalCount,] <- 0
    Test <- c()
    for (RecRate in 1:546){
        Test <- rbind(Test, Data[(204-3:ncol(DFETable))*6 + Element + 12,RecRate])
    }
    Row <- Test %*% t(Subset)
    FullDataTable[TotalCount,] <- t(Row)
    # Subset2 <- Data[(204-3:ncol(DFETable))*6 + Element + 12,RecRate]
    #  FullDataTable[TotalCount,RecRate] <- Subset2 %*% t(Subset)
        #        for (j in 3:ncol(DFETable)){
        #            FullDataTable[TotalCount,RecRate] <- FullDataTable[TotalCount,RecRate] + DFETable[i,j] * Data[(204-j)*6 + Element + 12,RecRate]
        #        }
        #        print (i)
        #        print (RecRate)
        TotalCount <- TotalCount + 1
}
}

for (i in 1:nrow(DFETable)){
    print (i)
    Subset <- DFETable[i,3:ncol(DFETable)]
for (Element in 1:6){
    #    print (Element)
    FullDataTable[TotalCount,] <- 0
    Test <- c()
    for (RecRate in 1:546){
        Test <- rbind(Test, Data[(204-3:ncol(DFETable))*6 + Element + 12,RecRate])
    }
    Row <- Test %*% t(Subset)
    FullDataTable[TotalCount,] <- t(Row)
    # Subset2 <- Data[(204-3:ncol(DFETable))*6 + Element + 12,RecRate]
    #  FullDataTable[TotalCount,RecRate] <- Subset2 %*% t(Subset)
        #        for (j in 3:ncol(DFETable)){
        #            FullDataTable[TotalCount,RecRate] <- FullDataTable[TotalCount,RecRate] + DFETable[i,j] * Data[(204-j)*6 + Element + 12,RecRate]
        #        }
        #        print (i)
        #        print (RecRate)
        TotalCount <- TotalCount + 1
}
}


write.table(FullDataTable, file = "PLGivenSTableWithRecsAnotherDFE.txt",row.names= FALSE,col.names = FALSE)




AllCoefficients <- c()

for (i in 1:1562){
    
    Points <- Data[0:20*1562 + i,2]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out1 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)
    
    Points <- Data[0:20*1562 + i,3]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out2 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)

    Points <- Data[0:20*1562 + i,4]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out3 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)
    
    Points <- Data[0:20*1562 + i,5]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out4 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)
    
    Points <- Data[0:20*1562 + i,6]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out5 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)
    
    Points <- Data[0:20*1562 + i,7]
    Comparison <- cbind(RecombinationQuantiles,Points)
    
    lm.out6 = lm(Points ~ poly(V1,4,raw=TRUE),Comparison)

    Row <- c(lm.out1$coefficients, lm.out2$coefficients, lm.out3$coefficients, lm.out4$coefficients, lm.out5$coefficients, lm.out6$coefficients )
    AllCoefficients <- rbind(AllCoefficients,Row)
}

write.table(AllCoefficients, file = "AllRegressionCoefficientsAnotherDFE.txt",row.names= FALSE,col.names = FALSE)

# par(mfrow=c(2,3))

TotalErrors <- c()
i <- 1
ConcatenateTestValues <- c()
PolyNum <- 5
for (FourNs in 1:1562){
print (FourNs)
FirstElement <- c()
FirstPoint <- c()
RecTestValue <- 4000
AllComparisons <- c(t(RecombinationQuantiles))
for (i in 2:7){
Points <- Data[0:20*1562 + FourNs,i]
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

for (i in 1:546){
    if (RecValues$V1[i] >= RecombinationQuantiles$V1[20]){
        ConcatenateTestValues[,i] <- rep.int(1, 1562*6)
        print(i)
    }
}

write.table(ConcatenateTestValues, file = "PLGivenSTableWithRecsAnotherDFE.txt",row.names= FALSE,col.names = FALSE)

Stuff <- c()
for (i in 1:1562){
Stuff <- rbind(Stuff,c( ConcatenateTestValues[ i * 6 + 1:6,545] ))
}
Stuff
write.table(Stuff,"AyCaonAnotherDFE.txt",sep="\t")
