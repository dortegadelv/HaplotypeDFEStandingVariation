library(here)

FileNames <- c("../Results/RecMaps/LeftBpRecRatePerVariantNoCpGPrintMap269.txt", "../Results/RecMaps/RightBpRecRatePerVariantNoCpGPrintMap269.txt", "../Results/RecMaps/LeftBpRecRatePerVariantSynonymousNoCpGPrintMap143.txt", "../Results/RecMaps/RightBpRecRatePerVariantSynonymousNoCpGPrintMap143.txt")

for (j in 1:2){

Table <- read.table(FileNames[j])

# Table <- as.numeric(Table)

RecMap <- rep(0,250001)

ColumnToCheck <- Table$V2[1]
StartingPosition <- Table$V3[1]
EndingPosition <- Table$V4[1]

NumberOfVariants <- 0
CurrentPosition <- 0

BoxplotAbsDiff <- c()

CurrentRecRate <- rep(0,250001)

for (i in 1:nrow(Table)){
    if (Table$V2[i] != ColumnToCheck ){
        CurrentPosition <- 0
        StartingPosition <- Table$V3[i]
        EndingPosition <- Table$V4[i]
        NumberOfVariants <- NumberOfVariants + 1
        ColumnToCheck <- Table$V2[i]
        #        break
        CurSum <- c()
        CurSum <- c(CurSum,mean(CurrentRecRate[1:50000]))
        CurSum <- c(CurSum,mean(CurrentRecRate[50001:100000]))
        CurSum <- c(CurSum,mean(CurrentRecRate[100000:150000]))
        CurSum <- c(CurSum,mean(CurrentRecRate[150001:200000]))
        CurSum <- c(CurSum,mean(CurrentRecRate[200001:250000]))
        
        TotalMean <- mean(CurrentRecRate)
        
        AbsDifference <- 0
        for (ind_i in 1:5){
                AbsDifference <- AbsDifference + abs (CurSum[ind_i] - TotalMean)
        }
         AbsDifference <- AbsDifference / 5
         if (AbsDifference == "NaN"){
         AbsDifference <- 0
         }
        BoxplotAbsDiff <- c(BoxplotAbsDiff,sd(CurSum))
        CurrentRecRate <- rep(0,250001)
    }
    
    if (i %% 1000 == 0){
    print (i)
    }
    
    ToAdd <- Table$V3[i] - StartingPosition + 1
    TheEnd <- Table$V4[i] - StartingPosition
    #    print (ToAdd)
    #    print (TheEnd)
    #    break
    RecMap[ToAdd:TheEnd] <- RecMap[ToAdd:TheEnd] + Table$V5[i]
    CurrentRecRate[ToAdd:TheEnd] <- Table$V5[i]
}

if (j == 1){
jpeg(filename = "../Figures/SuppFigure21_RecMapPlotsNS_Sites.jpeg", width = 960, quality = 90)
RecMapNS <- RecMap[1:250000]/(27300)
plot(1:250000,RecMap[1:250000]/(27300), xlim = c(0,500002),xlab = "Position",ylab = "Recombination rate",xaxt="n", ylim = c(0, 1.65e-7), pch = 19)
axis(1,c(1,50001,100001,150001,200001,250001,300001,350001,400001,450001,500002),c("-250 kb","-200 kb","-150 kb","-100 kb", "-50 kb", "NS Variant","50 kb","100 kb","150kb", "200 kb", "250 kb"))
Sums <- c()
Sums <- c(Sums, sum(RecMap[1:50000]))
Sums <- c(Sums, sum(RecMap[50001:100000]))
Sums <- c(Sums, sum(RecMap[100001:150000]))
Sums <- c(Sums, sum(RecMap[150001:200000]))
Sums <- c(Sums, sum(RecMap[200001:250000]))

NumbersToPrint <- formatC( Sums/(50000*27300),format = "e", digits = 2)
text(25001,1.65e-7,NumbersToPrint[1])
text(75001,1.65e-7,NumbersToPrint[2])
text(125001,1.65e-7,NumbersToPrint[3])
text(175001,1.65e-7,NumbersToPrint[4])
text(225001,1.65e-7,NumbersToPrint[5])

} else {
points(250001:500000,RecMap[1:250000]/(27300), pch = 19)
RecMapNS <- c(RecMapNS,RecMap[1:250000]/(27300))
Sums <- c()
Sums <- c(Sums, sum(RecMap[1:50000]))
Sums <- c(Sums, sum(RecMap[50001:100000]))
Sums <- c(Sums, sum(RecMap[100001:150000]))
Sums <- c(Sums, sum(RecMap[150001:200000]))
Sums <- c(Sums, sum(RecMap[200001:250000]))

NumbersToPrint <- formatC( Sums/(50000*27300),format = "e", digits = 2)
text(275001,1.65e-7,NumbersToPrint[1])
text(325001,1.65e-7,NumbersToPrint[2])
text(375001,1.65e-7,NumbersToPrint[3])
text(425001,1.65e-7,NumbersToPrint[4])
text(475001,1.65e-7,NumbersToPrint[5])

}
}

dev.off()

CurSum <- c()
CurSum <- c(CurSum,mean(CurrentRecRate[1:50000]))
CurSum <- c(CurSum,mean(CurrentRecRate[50001:100000]))
CurSum <- c(CurSum,mean(CurrentRecRate[100000:150000]))
CurSum <- c(CurSum,mean(CurrentRecRate[150001:200000]))
CurSum <- c(CurSum,mean(CurrentRecRate[200001:250000]))


AbsDifference <- 0
TotalMean <- mean(CurrentRecRate)

for (ind_i in 1:5){
    AbsDifference <- AbsDifference + abs (CurSum[ind_i] - TotalMean)
}
AbsDifference <- AbsDifference / 5

if (AbsDifference == "NaN"){
    AbsDifference <- 0
}


BoxplotAbsDiff <- c(BoxplotAbsDiff,sd(CurSum))

FirstDataBoxPlots <- BoxplotAbsDiff

# boxplot(BoxplotAbsDiff)

for (j in 3:4){
    
    Table <- read.table(FileNames[j])
    
    RecMap <- rep(0,250001)
    
    ColumnToCheck <- Table$V2[1]
    StartingPosition <- Table$V3[1]
    EndingPosition <- Table$V4[1]
    
    NumberOfVariants <- 0
    CurrentPosition <- 0
    
    BoxplotAbsDiff <- c()
    
    CurrentRecRate <- rep(0,250001)

    for (i in 1:nrow(Table)){
        if (Table$V2[i] != ColumnToCheck ){
            CurrentPosition <- 0
            StartingPosition <- Table$V3[i]
            EndingPosition <- Table$V4[i]
            NumberOfVariants <- NumberOfVariants + 1
            ColumnToCheck <- Table$V2[i]
            CurSum <- c()
            CurSum <- c(CurSum,mean(CurrentRecRate[1:50000]))
            CurSum <- c(CurSum,mean(CurrentRecRate[50001:100000]))
            CurSum <- c(CurSum,mean(CurrentRecRate[100000:150000]))
            CurSum <- c(CurSum,mean(CurrentRecRate[150001:200000]))
            CurSum <- c(CurSum,mean(CurrentRecRate[200001:250000]))
            
            TotalMean <- mean(CurrentRecRate)
            

            AbsDifference <- 0
            for (ind_i in 1:5){
                AbsDifference <- AbsDifference + abs (CurSum[ind_i] - TotalMean)
            }
            AbsDifference <- AbsDifference / 5
            
            if (AbsDifference == "NaN"){
                AbsDifference <- 0
            }

            BoxplotAbsDiff <- c(BoxplotAbsDiff,sd(CurSum))
            CurrentRecRate <- rep(0,250001)

            #        break
        }
        
        if (i %% 1000 == 0){
            print (i)
        }
        
        ToAdd <- Table$V3[i] - StartingPosition + 1
        TheEnd <- Table$V4[i] - StartingPosition
        #    print (ToAdd)
        #    print (TheEnd)
        #    break
        RecMap[ToAdd:TheEnd] <- RecMap[ToAdd:TheEnd] + Table$V5[i]
        CurrentRecRate[ToAdd:TheEnd] <- Table$V5[i]

    }
    
    if (j == 3){
        jpeg(filename = "../Figures/SuppFigure21_RecMapPlotsSyn_Sites.jpeg", width = 960, quality = 90)
        RecMapSyn <- RecMap[1:250000]/(27300)
        plot(1:250000,RecMap[1:250000]/(15100), xlim = c(0,500002),xlab = "Position",ylab = "Recombination rate",xaxt="n", ylim = c(0, 1.65e-7), pch = 19)
        axis(1,c(1,50001,100001,150001,200001,250001,300001,350001,400001,450001,500002),c("-250 kb","-200 kb","-150 kb","-100 kb", "-50 kb", "Syn Variant","50 kb","100 kb","150kb", "200 kb", "250 kb"))
        Sums <- c()
        Sums <- c(Sums, sum(RecMap[1:50000]))
        Sums <- c(Sums, sum(RecMap[50001:100000]))
        Sums <- c(Sums, sum(RecMap[100001:150000]))
        Sums <- c(Sums, sum(RecMap[150001:200000]))
        Sums <- c(Sums, sum(RecMap[200001:250000]))
        
        NumbersToPrint <- formatC( Sums/(50000*15100),format = "e", digits = 2)
        text(25001,1.65e-7,NumbersToPrint[1])
        text(75001,1.65e-7,NumbersToPrint[2])
        text(125001,1.65e-7,NumbersToPrint[3])
        text(175001,1.65e-7,NumbersToPrint[4])
        text(225001,1.65e-7,NumbersToPrint[5])

    } else {
        points(250001:500000,RecMap[1:250000]/(15100), pch = 19)
        RecMapSyn <- c(RecMapSyn,RecMap[1:250000]/(27300))
        Sums <- c()
        Sums <- c(Sums, sum(RecMap[1:50000]))
        Sums <- c(Sums, sum(RecMap[50001:100000]))
        Sums <- c(Sums, sum(RecMap[100001:150000]))
        Sums <- c(Sums, sum(RecMap[150001:200000]))
        Sums <- c(Sums, sum(RecMap[200001:250000]))
        
        NumbersToPrint <- formatC( Sums/(50000*15100),format = "e", digits = 2)
        text(275001,1.65e-7,NumbersToPrint[1])
        text(325001,1.65e-7,NumbersToPrint[2])
        text(375001,1.65e-7,NumbersToPrint[3])
        text(425001,1.65e-7,NumbersToPrint[4])
        text(475001,1.65e-7,NumbersToPrint[5])

        
    }
}

dev.off()

CurSum <- c()
CurSum <- c(CurSum,mean(CurrentRecRate[1:50000]))
CurSum <- c(CurSum,mean(CurrentRecRate[50001:100000]))
CurSum <- c(CurSum,mean(CurrentRecRate[100000:150000]))
CurSum <- c(CurSum,mean(CurrentRecRate[150001:200000]))
CurSum <- c(CurSum,mean(CurrentRecRate[200001:250000]))

TotalMean <- mean(CurrentRecRate[1:250000])

AbsDifference <- 0
for (ind_i in 1:5){
    AbsDifference <- AbsDifference + abs (CurSum[ind_i] - TotalMean)
}
AbsDifference <- AbsDifference / 5

if (AbsDifference == "NaN"){
    AbsDifference <- 0
}


BoxplotAbsDiff <- c(BoxplotAbsDiff,sd(CurSum))

pdf("../Figures/SuppFigure21_BoxPlots.pdf")
par(mar=c(5.1,6.1,4.1,2.1))
boxplot(FirstDataBoxPlots/100, BoxplotAbsDiff/100, names = c("Non synonymous","Synonomous"), ylab = expression( plain("sd (") ~ R[s[j]] ~ plain(")") ))

dev.off()

DataLeftSyn <- read.table("../Data/LeftBpRecRatePerVariantSynonymous.txt")
DataRightSyn <- read.table("../Data/RightBpRecRatePerVariantSynonymous.txt")

DataSyn <- rbind(DataLeftSyn,DataRightSyn)

DataLeft <- read.table("../Data/LeftBpRecRatePerVariant.txt")
DataRight <- read.table("../Data/RightBpRecRatePerVariant.txt")

Data <- rbind(DataLeft,DataRight)

mean(DataSyn$V1)
mean(Data$V1)

wilcox.test(DataSyn$V1,Data$V1)


DataLeftSyn <- read.table("../Data/LeftBpRecRatePerVariantNoCpGSynonymous.txt")
DataRightSyn <- read.table("../Data/RightBpRecRatePerVariantNoCpGSynonymous.txt")

DataSyn <- rbind(DataLeftSyn,DataRightSyn)

DataLeft <- read.table("../Data/LeftBpRecRatePerVariantNoCpG.txt")
DataRight <- read.table("../Data/RightBpRecRatePerVariantNoCpG.txt")

Data <- rbind(DataLeft,DataRight)

mean(DataSyn$V1)
mean(Data$V1)

wilcox.test(DataSyn$V1,Data$V1)
