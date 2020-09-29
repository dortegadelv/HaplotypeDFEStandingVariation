setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/Scripts/Sims/UK10K_OnePercenters/ImportanceSamplingSims")

### Another extra one


AlphaGrid <- 0.03*1:30
BetaGrid <- 30*1:50

TwoNsValues <- 0:75*.5 + .25

Table <- matrix(ncol=78,nrow=0)

for (j in AlphaGrid){
    for (k in BetaGrid){
		Probability <- 0
		Row <- c(j,k)
		for (i in TwoNsValues){
			
			if ( i == 0.25){
				Probability <- pgamma(0.25,j,1/k)
				Row <- c(Row,Probability)
			}else if (i==37.75){
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

write.table(Table,file="DFETableOfProbabilities.txt",row.names=FALSE,col.names=FALSE,sep="\t")

for (k in 1:1500){
    print(sum(Table[k,3:78]))
}


setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims")

### Another extra one


AlphaGrid <- 0.00001*1:30
BetaGrid <- 0.1*1:50

TwoNsValues <- 0:75*.5 + .25

Table <- matrix(ncol=78,nrow=0)

for (j in AlphaGrid){
    for (k in BetaGrid){
        Probability <- 0
        Row <- c(j,k)
        for (i in TwoNsValues){
            
            if ( i == 0.25){
                Probability <- pgamma(0.25,j,1/k)
                Row <- c(Row,Probability)
            }else if (i==37.75){
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

write.table(Table,file="AnotherDFETableOfProbabilities.txt",row.names=FALSE,col.names=FALSE,sep="\t")

for (k in 1:1500){
    print(sum(Table[k,3:78]))
}


############## Newest DFE table

setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/ScriptsOctober22_2017/Sims/UK10K_OnePercenters/ImportanceSamplingSims")

### Another extra one


AlphaGrid <- 0.03*1:30
BetaGrid <- c(0.03,3,1500*1:50)

TwoNsValues <- 0:75*.5 + .25

Table <- matrix(ncol=78,nrow=0)

for (j in AlphaGrid){
    for (k in BetaGrid){
        Probability <- 0
        Row <- c(j,k)
        for (i in TwoNsValues){
            
            if ( i == 0.25){
                Probability <- pgamma(0.25,j,1/k)
                Row <- c(Row,Probability)
            }else if (i==37.75){
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

write.table(Table,file="AnotherDFETableOfProbabilities.txt",row.names=FALSE,col.names=FALSE,sep="\t")

for (k in 1:1500){
    print(sum(Table[k,3:78]))
}



