setwd("/Users/vicentediegoortegadelvecchyo/Documents/DissertationThesis/PurifyingSelection/Drafts/PaperResults/SimsResults/")

library(viridis)
library(jpeg)
library(plotrix)

DemScenario <- c()
DemScenario <- c(DemScenario,"AncientBottleneck")
DemScenario <- c(DemScenario,"AncientBottleneckPointFivePercent")
DemScenario <- c(DemScenario,"ConstantPopSize")
DemScenario <- c(DemScenario,"ConstantPopSizePointFivePercent")
DemScenario <- c(DemScenario,"MediumBottleneck")
DemScenario <- c(DemScenario,"MediumBottleneckPointFivePercent")
DemScenario <- c(DemScenario,"PopExpansion")
DemScenario <- c(DemScenario,"PopExpansionPointFivePercent")
DemScenario <- c(DemScenario,"RecentBottleneck")
DemScenario <- c(DemScenario,"RecentBottleneckPointFivePercent")
DemScenario <- c(DemScenario,"ConstantPopSizePopFrequency")

Selection <- c()
Selection <- c(Selection,"4Ns0")
Selection <- c(Selection,"4Ns-50")
Selection <- c(Selection,"4Ns50")
Selection <- c(Selection,"4Ns-100")
Selection <- c(Selection,"4Ns100")


SelectionTest <- c()
SelectionTest <- c(SelectionTest,"4Ns_0")
SelectionTest <- c(SelectionTest,"4Ns_-50")
SelectionTest <- c(SelectionTest,"4Ns_50")
SelectionTest <- c(SelectionTest,"4Ns_-100")
SelectionTest <- c(SelectionTest,"4Ns_100")

ListMaxFreq <- c()
ListMaxAge <- c()
ListMaxT2 <- c()

Ne <- c()
Ne[1]=10000
Ne[2]=10000
Ne[3]=20000
Ne[4]=20000
Ne[5]=10000
Ne[6]=10000
Ne[7]=100000
Ne[8]=100000
Ne[9]=10000
Ne[10]=10000
Ne[11]=20000

for (j in c(3,11)){
	for (i in 1:5){
		print (i)
	AgesFile <- paste("AlleleAges/Ages",DemScenario[j],"_",SelectionTest[i],".txt",sep="")
		Data <- read.table(AgesFile)
	print(mean(Data$V1*2*Ne[j]))
	print(sd(Data$V1*2*Ne[j]))
	}
}
