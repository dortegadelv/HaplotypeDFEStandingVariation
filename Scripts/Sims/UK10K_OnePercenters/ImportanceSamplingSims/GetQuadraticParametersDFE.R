setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims")

Data <- read.table("PLGivenSTableWithRecs.txt")
DFETable <- read.table("DFETableOfProbabilities.txt")

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

write.table(FullDataTable, file = "PLGivenSTableWithRecsFirstDFE.txt",row.names= FALSE,col.names = FALSE)


