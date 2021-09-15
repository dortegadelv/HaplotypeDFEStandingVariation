setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims")
Data <- read.table("../../../../Data/AllBpRecRatePerVariantNoCpG.txt")

RecQuantiles <- quantile(Data$V1, probs = c(0.05*0:20)) * 4 * 250000 * 411155 / 100

write.table(round(RecQuantiles, digits =3), file = "QuantilesRecombination.txt", row.names = FALSE, col.names = FALSE)
