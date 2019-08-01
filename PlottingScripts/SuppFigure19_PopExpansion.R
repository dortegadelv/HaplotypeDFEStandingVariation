setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

Data <- read.table("../Results/AllAgeESS/FinalStatsPopExpansion.txt")

pdf("../Figures/SuppFigure19_PopExpansionESS.pdf")
plot(-200:200,Data[403:803],type="l",ylab="ESS",xlab="4Ns",cex.lab=1.4,cex.axis=1.5,lwd=2)
dev.off()
