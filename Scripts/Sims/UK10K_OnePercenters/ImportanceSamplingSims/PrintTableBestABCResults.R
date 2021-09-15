setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

OrderedData <- read.table("../Results/ABCResults/ParametersAndStatisticsNotCpG50000.txt")

End <- (1)*1
print (End)
BestABCN1 <- median(OrderedData$V2[1:End])
BestABCTime <- median(OrderedData$V3[1:End])
BestABCN0 <- median(OrderedData$V4[1:End])

Matrix <- matrix(c(5,BestABCN1,BestABCTime,BestABCN0, OrderedData$V5[1]*5),ncol=5)

for (i in 1:10000){
    
    End <- (i+1)*1
#    print (End)
    BestABCN1 <- median(OrderedData$V2[1:End])
    BestABCTime <- median(OrderedData$V3[1:End])
    BestABCN0 <- median(OrderedData$V4[1:End])
    Number <- (i+1)*5
    Row <- c(Number,BestABCN1, BestABCTime, BestABCN0, OrderedData$V5[End]*5)
    Matrix <- rbind(Matrix, Row)
}

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

OrderedData <- read.table("../Results/ABCResults/ParametersAndStatisticsNotCpG50000.txt")

End <- (1)*1
print (End)
BestABCN1 <- median(OrderedData$V2[1:End])
BestABCTime <- median(OrderedData$V3[1:End])
BestABCN0 <- median(OrderedData$V4[1:End])

Matrix <- matrix(c(5,BestABCN1,BestABCTime,BestABCN0, OrderedData$V5[1]*5),ncol=5)

for (i in 1:10000){
    
    End <- (i+1)*1
#    print (End)
    BestABCN1 <- mean(OrderedData$V2[1:End])
    BestABCTime <- mean(OrderedData$V3[1:End])
    BestABCN0 <- mean(OrderedData$V4[1:End])
    Number <- (i+1)*5
    Row <- c(Number,BestABCN1, BestABCTime, BestABCN0, OrderedData$V5[End]*5)
    Matrix <- rbind(Matrix, Row)
}


setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

OrderedData <- read.table("../Results/ABCResults/ParametersAndStatisticsNotCpG50000.txt")

End <- (1)*1
print (End)
BestABCN1 <- median(OrderedData$V2[1:End])
BestABCTime <- median(OrderedData$V3[1:End])
BestABCN0 <- median(OrderedData$V4[1:End])

Matrix <- matrix(c(5,BestABCN1,BestABCTime,BestABCN0, OrderedData$V5[1]*5),ncol=5)

for (i in 1:10000){
    
    End <- (i+1)*1
#    print (End)
    d <- density(OrderedData$V2[1:End])
    BestABCN1 <- d$x[d$y==max(d$y)]
    d <- density(OrderedData$V3[1:End])
    BestABCTime <- d$x[d$y==max(d$y)]
    d <- density(OrderedData$V4[1:End])
    BestABCN0 <- d$x[d$y==max(d$y)]
    Number <- (i+1)*5
    Row <- c(Number,BestABCN1, BestABCTime, BestABCN0, OrderedData$V5[End]*5)
    Matrix <- rbind(Matrix, Row)
}




# BestABC <- OrderedData$V2[1:End]
