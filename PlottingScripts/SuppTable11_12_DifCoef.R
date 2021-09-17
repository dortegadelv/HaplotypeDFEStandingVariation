setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

FourNs<- array()
FourNs[1]="4Ns_0"
FourNs[2]="4Ns_50"
FourNs[3]="4Ns_100"
FourNs[4]="4Ns_-50"
FourNs[5]="4Ns_-100"

Values <- array()
Values[1]=0
Values[2]=50
Values[3]=100
Values[4]=-50
Values[5]=-100

Medians <- c()
RMSE <- c()
for (i in 1:5){

    for (j in 1:9){
    print (i)
    File= paste("../Results/ResultsSelectionInferred/SelectionPopExpansionDifRecRate",FourNs[i],"CoefNum",j,".txt",sep="")
    Data = read.table(File)
    Medians <- c(Medians,median(Data$V1) - Values[i])
    RMSE <- c(RMSE, (sum(((Data$V1-Values[i])^2)/100))^(1/2) )
}
}

mean(abs(Medians[0:4*9+1]))
mean(abs(Medians[0:4*9+2]))
mean(abs(Medians[0:4*9+3]))
mean(abs(Medians[0:4*9+4]))
mean(abs(Medians[0:4*9+5]))
mean(abs(Medians[0:4*9+6]))
mean(abs(Medians[0:4*9+7]))
mean(abs(Medians[0:4*9+8]))
mean(abs(Medians[0:4*9+9]))

mean(RMSE[0:4*9+1])
mean(RMSE[0:4*9+2])
mean(RMSE[0:4*9+3])
mean(RMSE[0:4*9+4])
mean(RMSE[0:4*9+5])
mean(RMSE[0:4*9+6])
mean(RMSE[0:4*9+7])
mean(RMSE[0:4*9+8])
mean(RMSE[0:4*9+9])


setwd("/Users/vicentediegoortegadelvecchyo/Dropbox (Personal)/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

FourNs<- array()
FourNs[1]="4Ns_0"
FourNs[2]="4Ns_25"
FourNs[3]="4Ns_50"
FourNs[4]="4Ns_-25"
FourNs[5]="4Ns_-50"

Values <- array()
Values[1]=0
Values[2]=25
Values[3]=50
Values[4]=-25
Values[5]=-50

Coefs <- array()
Coefs[1]=1
Coefs[2]=3
Coefs[3]=4
Coefs[4]=5
Coefs[5]=6
Coefs[6]=7
Coefs[7]=8
Coefs[8]=9

Medians <- c()
RMSE <- c()
for (i in 1:5){

    for (j in 1:8){
    print (i)
    File= paste("../Results/ResultsSelectionInferred/SelectionUK10K",FourNs[i],"CoefNum",Coefs[j],".txt",sep="")
    Data = read.table(File)
    Medians <- c(Medians,median(Data$V1) - Values[i])
    RMSE <- c(RMSE, (sum(((Data$V1-Values[i])^2)/100))^(1/2) )
}
}

mean(abs(Medians[0:4*8+1]))
mean(abs(Medians[0:4*8+2]))
mean(abs(Medians[0:4*8+3]))
mean(abs(Medians[0:4*8+4]))
mean(abs(Medians[0:4*8+5]))
mean(abs(Medians[0:4*8+6]))
mean(abs(Medians[0:4*8+7]))
mean(abs(Medians[0:4*8+8]))
#mean(abs(Medians[0:4*8+9]))

mean(RMSE[0:4*8+1])
mean(RMSE[0:4*8+2])
mean(RMSE[0:4*8+3])
mean(RMSE[0:4*8+4])
mean(RMSE[0:4*8+5])
mean(RMSE[0:4*8+6])
mean(RMSE[0:4*8+7])
mean(RMSE[0:4*8+8])
# mean(RMSE[0:4*8+9])

