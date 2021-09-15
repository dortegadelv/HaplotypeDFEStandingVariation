setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts/Sims/PopExpansion/ForwardSims")
Data <- read.table("ResampledBpRecRatePerVariantNoCpG.txt")

RecQuantiles <- quantile(Data$V1, probs = c(0.05*0:20)) / 2

write.table(round(RecQuantiles, digits =3), file = "QuantilesRecombination.txt", row.names = FALSE, col.names = FALSE)
