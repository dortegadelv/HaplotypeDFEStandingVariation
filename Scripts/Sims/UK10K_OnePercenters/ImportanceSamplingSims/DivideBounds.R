setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims/")

DataOne <- read.table("~/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RecRateMissenseOnePercentRightNoCpG.txt")
DataTwo <- read.table("~/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ForwardSims/RecRateMissenseOnePercentLeftNoCpG.txt")
Data <- rbind(DataOne,DataTwo)

Bounds <- quantile(Data$V1, probs = seq(0, 1, 0.05))
QuantileToPrint <- rep.int(0,546)

for (i in 1:length(Data$V1) ) {
    if (Data$V1[i] < Bounds[2]){
        QuantileToPrint[i] <- 1
        
    }
}

for (i in 1:length(Data$V1) ) {
    if (Data$V1[i] > Bounds[40]){
        QuantileToPrint[i] <- 21
    }
}

for (j in 2:20){
    for (i in 1:length(Data$V1) ) {
        if ((Data$V1[i] >= Bounds[(j-1)*2]) && (Data$V1[i] <= Bounds[(j)*2])){
            QuantileToPrint[i] <- j
        }
    }
}

write.table(QuantileToPrint,file="QuantileToPrint.txt",row.names=FALSE,col.names=FALSE)
