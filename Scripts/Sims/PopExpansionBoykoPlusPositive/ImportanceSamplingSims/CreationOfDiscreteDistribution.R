
#### Another table of probabilities

AlphaGrid <- 0.03*1:30
BetaGrid <- 3*1:70

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

write.table(Table,file="AnotherExtraTableOfProbabilities.txt",row.names=FALSE,col.names=FALSE,sep="\t")

for (k in 1:2100){
    print(sum(Table[k,3:303]))
}



############ Boyko Plus positive selection table of probabilities


AlphaGrid <- 0.03*1:30
BetaGrid <- 15*1:14
PositiveSelectionFraction <- c(0,0.05,0.1)
TwoNsValues <- 0:200*.5 + .25

Table <- matrix(ncol=204,nrow=0)

for (j in AlphaGrid){
    for (k in BetaGrid){
        for (l in PositiveSelectionFraction){
            Probability <- 0
            Row <- c(j,k)
            for (i in TwoNsValues){
                
                if ( i == 0.25){
                    Probability <- pgamma(0.25,j,1/k) * (1-l)
                    Row <- c(Row,Probability)
                }else if (i==100.25){
                    Probability <- ( 1 - pgamma(i-0.5,j,1/k) ) * (1-l)
                    Row <- c(Row,Probability)
                }else{
                    Probability <-(pgamma(i,j,1/k) - pgamma(i-0.5,j,1/k)) * (1-l)
                    Row <- c(Row,Probability)
                }
                
            }
            Row <- c(Row,l)
            Table <- rbind(Table,Row)
            #print (Probability)
        }
    }
}

write.table(Table,file="AnotherExtraTableOfProbabilitiesPosBoyko.txt",row.names=FALSE,col.names=FALSE,sep="\t")

for (k in 1:1260){
    print(sum(Table[k,3:204]))
}

#### Another table of probabilities

AlphaGrid <- 0.03*1:30
BetaGrid <- 150*1:14 + 210
PositiveSelectionFraction <- c(0,0.05,0.1)
TwoNsValues <- 0:200*.5 + .25

Table <- matrix(ncol=204,nrow=0)

for (j in AlphaGrid){
    for (k in BetaGrid){
        for (l in PositiveSelectionFraction){
            Probability <- 0
            Row <- c(j,k)
            for (i in TwoNsValues){
                
                if ( i == 0.25){
                    Probability <- pgamma(0.25,j,1/k) * (1-l)
                    Row <- c(Row,Probability)
                }else if (i==100.25){
                    Probability <- ( 1 - pgamma(i-0.5,j,1/k) ) * (1-l)
                    Row <- c(Row,Probability)
                }else{
                    Probability <-(pgamma(i,j,1/k) - pgamma(i-0.5,j,1/k)) * (1-l)
                    Row <- c(Row,Probability)
                }
                
            }
            Row <- c(Row,l)
            Table <- rbind(Table,Row)
            #print (Probability)
        }
    }
}

write.table(Table,file="AnotherExtraTableOfProbabilitiesPosBoykoSmall.txt",row.names=FALSE,col.names=FALSE,sep="\t")

for (k in 1:1260){
    print(sum(Table[k,3:204]))
}

