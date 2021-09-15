
Data <- read.table("PLGivenSTableWithRecs.txt")
DFETable <- read.table("DFETableOfProbabilities.txt")

RecValuesOne <- read.table("ResampledBpRecRatePerVariantNoCpG.txt")
RecValuesTwo <- read.table("ResampledBpRecRatePerVariantNoCpG.txt")
RecValues <- rbind(RecValuesOne,RecValuesTwo)

FullDataTable <- matrix(nrow = nrow(DFETable)*6+12, ncol = 600)

TotalCount <- 1
for (i in 1:2){
    print (i)
    Subset <- DFETable[i,3:ncol(DFETable)]
for (Element in 1:6){
    FullDataTable[TotalCount,] <- 0
    Test <- c()
    for (RecRate in 1:600){
        Test <- rbind(Test, Data[(203-3:ncol(DFETable))*6 + Element + 12,RecRate])
    }
    Row <- Test %*% t(Subset)
    FullDataTable[TotalCount,] <- t(Row)
        TotalCount <- TotalCount + 1
}
}

for (i in 1:nrow(DFETable)){
    print (i)
    Subset <- DFETable[i,3:ncol(DFETable)]
for (Element in 1:6){
    FullDataTable[TotalCount,] <- 0
    Test <- c()
    for (RecRate in 1:600){
        Test <- rbind(Test, Data[(203-3:ncol(DFETable))*6 + Element + 12,RecRate])
    }
    Row <- Test %*% t(Subset)
    FullDataTable[TotalCount,] <- t(Row)
        TotalCount <- TotalCount + 1
}
}

write.table(FullDataTable, file = "PLGivenSTableWithRecsFirstDFE.txt",row.names= FALSE,col.names = FALSE)


