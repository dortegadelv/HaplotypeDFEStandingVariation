setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts/Sims/ConstantPopSizeBoyko/ImportanceSamplingSims")

#### Another table of probabilities

AlphaGrid <- 0.03*1:30
BetaGrid <- 30*1:70 + 210

TwoNsValues <- 0:200*.5 + .25

Table <- matrix(ncol=203,nrow=0)

for (j in AlphaGrid){
    for (k in BetaGrid){
		Probability <- 0
		Row <- c(j,k)
		for (i in TwoNsValues){
			
			if ( i == 0.25){
				Probability <- pgamma(0.25,j,1/k)
				Row <- c(Row,Probability)
			}else if (i==100.25){
				Probability <- ( 1 - pgamma(i-0.5,j,1/k) )
				Row <- c(Row,Probability)
			}else{
				Probability <-(pgamma(i,j,1/k) - pgamma(i-0.5,j,1/k))
				Row <- c(Row,Probability)
			}
			
		}
		Table <- rbind(Table,Row)
#print (Probability)
    }
}

write.table(Table,file="AnotherExtraTableOfProbabilitiesSmall.txt",row.names=FALSE,col.names=FALSE,sep="\t")

for (k in 1:2100){
    print(sum(Table[k,3:203]))
}

