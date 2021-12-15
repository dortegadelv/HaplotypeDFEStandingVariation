setwd("/Users/vicentediegoortegadelvecchyo/Dropbox/Documents/DissertationThesis/PurifyingSelection/Drafts/HaplotypeDFEStandingVariation/PlottingScripts")

library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

### Figure 3

Selection1 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate_1.txt")
Selection2 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate_2.txt")
Selection3 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate_3.txt")
Selection4 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate_4.txt")
Selection5 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate_5.txt")
Selection6 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate_6.txt")
Selection7 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate_7.txt")
Selection8 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate_8.txt")
Selection9 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate_9.txt")
Selection10 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate_10.txt")


Plot <- paste("../Figures/SuppFigure24_PopExpansionSelInference.pdf",sep="")


pdf(Plot, width=21,height = 14)
par(mfrow = c(2,3))
par(mar=c(5,7,5,2) + 0.1)

Median <- median(c(Selection1$V1-200, Selection2$V1-200, Selection3$V1-200, Selection4$V1-200, Selection5$V1-200, Selection6$V1-200, Selection7$V1-200, Selection8$V1-200, Selection9$V1-200, Selection10$V1-200))

beanplot(Selection1$V1-200, Selection2$V1-200, Selection3$V1-200, Selection4$V1-200, Selection5$V1-200, Selection6$V1-200, Selection7$V1-200, Selection8$V1-200, Selection9$V1-200, Selection10$V1-200,names=c("1","2","3","4","5","6","7","8","9","10"),ylab="Estimated 4Ns values",xlab="Replicates", main= "A) 4Ns = 0", cex.axis=1.5,cex.lab=2,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), cutmin = -200, cutmax = 0, border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
abline(h=Median,lty=3)
# abline(h=Median,lty=3, col = "red")


### Figure 3

Selection1 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns50_1.txt")
Selection2 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns50_2.txt")
Selection3 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns50_3.txt")
Selection4 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns50_4.txt")
Selection5 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns50_5.txt")
Selection6 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns50_6.txt")
Selection7 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns50_7.txt")
Selection8 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns50_8.txt")
Selection9 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns50_9.txt")
Selection10 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns50_10.txt")

Plot <- paste("../Figures/SuppFigure15_PopExpansionSelInference4Ns50.pdf",sep="")

Median <- median(c(Selection1$V1-200, Selection2$V1-200, Selection3$V1-200, Selection4$V1-200, Selection5$V1-200, Selection6$V1-200, Selection7$V1-200, Selection8$V1-200, Selection9$V1-200, Selection10$V1-200))

beanplot(Selection1$V1-200, Selection2$V1-200, Selection3$V1-200, Selection4$V1-200, Selection5$V1-200, Selection6$V1-200, Selection7$V1-200, Selection8$V1-200, Selection9$V1-200, Selection10$V1-200,names=c("1","2","3","4","5","6","7","8","9","10"),ylab="Estimated 4Ns values",xlab="Replicates", main="B) 4Ns = -50",cex.axis=1.5,cex.lab=2,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), cutmin = -200, cutmax = 0, border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
abline(h=Median,lty=3)
# abline(h=Median,lty=3, col = "red")


Selection1 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns100_1.txt")
Selection2 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns100_2.txt")
Selection3 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns100_3.txt")
Selection4 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns100_4.txt")
Selection5 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns100_5.txt")
Selection6 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns100_6.txt")
Selection7 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns100_7.txt")
Selection8 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns100_8.txt")
Selection9 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns100_9.txt")
Selection10 <- read.table("../Results/ResultsSelectionInferred/SelectionPopExpansionSLiMPopExpansionChangedRecRate4Ns100_10.txt")


Plot <- paste("../Figures/SuppFigure15_PopExpansionSelInference4Ns100.pdf",sep="")


Median <- median(c(Selection1$V1-200, Selection2$V1-200, Selection3$V1-200, Selection4$V1-200, Selection5$V1-200, Selection6$V1-200, Selection7$V1-200, Selection8$V1-200, Selection9$V1-200, Selection10$V1-200))

beanplot(Selection1$V1-200, Selection2$V1-200, Selection3$V1-200, Selection4$V1-200, Selection5$V1-200, Selection6$V1-200, Selection7$V1-200, Selection8$V1-200, Selection9$V1-200, Selection10$V1-200,names=c("1","2","3","4","5","6","7","8","9","10"),ylab="Estimated 4Ns values",xlab="Replicates",main="C) 4Ns = -100",cex.axis=1.5,cex.lab=2,cex.main=2.5,col = c("#CAB2D6", "#33A02C", "#B2DF8A"), cutmin = -200, cutmax = 0, border = "#CAB2D6",maxstripline=0.15,beanlinewd=0.5,overall=10000,what=c(FALSE,TRUE,TRUE,TRUE),overallline = "median",ll=0.5,bw="nrd0")
abline(h=Median,lty=3)
# abline(h=Median, pch = 4, col = "red")

ViridisColors <- viridis(10)
for (k in 1:10){
    TableData <- paste("../Results/Tables_SLiM/Zero/TableToTest",k,".txt", sep = "")
DataTableOne <- read.table (TableData)
Differences <- c()
Pchs <- c(3, 4, 8, 9, 19)

InitialValue <- c(203)
# InitialValue <- c(103)
for (Num in 1:1){
    Val <- InitialValue[Num]
    FirstPos <- 3
    LastPos <- 203
    Differences <- c()
for (i in FirstPos:LastPos){
    
#    print(i)
    CurDifferences <- 0
    for (j in 2:7){
        CurDifferences <- CurDifferences + abs(DataTableOne[i,j] - DataTableOne[Val,j])
    }
    Differences <- c(Differences, CurDifferences)
}

if (k == 1){
    
    plot(Differences, col=ViridisColors[k], lty= "solid", ylim = c(0,0.1), pch = Pchs[Num], ylab = "Absolute difference between probability distributions of L\n using 4Ns = 0 vs 4Ns = K", xaxt = "n", xlab = "Compared 4Ns value \'K\'",cex.lab=2, cex.axis=2, main = "D) 4Ns = 0",cex.main=2.5, type ="l",lwd = 11 - k)
}else{
    lines(Differences, col = ViridisColors[k], lty = "solid", pch = Pchs[Num],lwd = 11 - k)
}
}
}
axis(1, at = c(1,101,201,301,401), labels = c("-200","-100", "0", "100", "200"), cex.axis = 2 )
legend("topleft", c("Demographic Scenario (Replicate)","1","2","3","4","5","6","7","8","9","10","Population Expansion Model - Expansion time = 100 Gens Ago (see S3)"), col = c("white",ViridisColors[1:10], "red") , pch = "-", title = "", cex = 1.5, bty= 'n')


DataTableOne <- read.table ("../Results/ISPopExpansionTables/TableToTestPopExpansion100GensAgo.txt")
Differences <- c()
Pchs <- c(3, 4, 8, 9, 19)

InitialValue <- c(203)
# InitialValue <- c(103)
for (Num in 1:1){
    Val <- InitialValue[Num]
    FirstPos <- 3
    LastPos <- 203
    Differences <- c()
for (i in FirstPos:LastPos){
    
#    print(i)
    CurDifferences <- 0
    for (j in 2:7){
        CurDifferences <- CurDifferences + abs(DataTableOne[i,j] - DataTableOne[Val,j])
    }
    Differences <- c(Differences, CurDifferences)
}

if (Val == 203){
    lines(Differences, col = "red", type = "l", lty= "solid", pch = Pchs[Num], lwd=3)
}
}



ViridisColors <- viridis(10)
for (k in 1:10){
    TableData <- paste("../Results/Tables_SLiM/Fifty/TableToTest",k,".txt", sep = "")
DataTableOne <- read.table (TableData)
Differences <- c()
Pchs <- c(3, 4, 8, 9, 19)

InitialValue <- c(153)
# InitialValue <- c(103)
for (Num in 1:1){
    Val <- InitialValue[Num]
    FirstPos <- 3
    LastPos <- 203
    Differences <- c()
for (i in FirstPos:LastPos){
    
#    print(i)
    CurDifferences <- 0
    for (j in 2:7){
        CurDifferences <- CurDifferences + abs(DataTableOne[i,j] - DataTableOne[Val,j])
    }
    Differences <- c(Differences, CurDifferences)
}

if (k == 1){
    
    plot(Differences, col=ViridisColors[k], lty= "solid", ylim = c(0,0.1), pch = Pchs[Num], ylab = "Absolute difference between probability distributions of L\n using 4Ns = -50 vs 4Ns = K", xaxt = "n", xlab = "Compared 4Ns value \'K\'",cex.lab=2, cex.axis=2, main = "E) 4Ns = -50",cex.main=2.5, type ="l",lwd = 11 - k)
}else{
    lines(Differences, col = ViridisColors[k], lty = "solid", pch = Pchs[Num],lwd = 11 - k)
}
}
}
axis(1, at = c(1,101,201,301,401), labels = c("-200","-100", "0", "100", "200"), cex.axis = 2 )
legend("topleft", c("Demographic Scenario (Replicate)","1","2","3","4","5","6","7","8","9","10","Population Expansion Model - Expansion time = 100 Gens Ago (see S3)"), col = c("white",ViridisColors[1:10], "red") , pch = "-", title = "", cex = 1.5, bty= 'n')



DataTableOne <- read.table ("../Results/ISPopExpansionTables/TableToTestPopExpansion100GensAgo.txt")
Differences <- c()
Pchs <- c(3, 4, 8, 9, 19)

InitialValue <- c(153)
# InitialValue <- c(103)
for (Num in 1:1){
    Val <- InitialValue[Num]
    FirstPos <- 3
    LastPos <- 203
    Differences <- c()
for (i in FirstPos:LastPos){
    
#    print(i)
    CurDifferences <- 0
    for (j in 2:7){
        CurDifferences <- CurDifferences + abs(DataTableOne[i,j] - DataTableOne[Val,j])
    }
    Differences <- c(Differences, CurDifferences)
}

if (Val == 153){
    lines(Differences, col = "red", type = "l", lty= "solid", pch = Pchs[Num], lwd=3)
}
}



ViridisColors <- viridis(10)
for (k in 1:10){
    TableData <- paste("../Results/Tables_SLiM/Hundred/TableToTest",k,".txt", sep = "")
DataTableOne <- read.table (TableData)
Differences <- c()
Pchs <- c(3, 4, 8, 9, 19)

InitialValue <- c(103)
# InitialValue <- c(103)
for (Num in 1:1){
    Val <- InitialValue[Num]
    FirstPos <- 3
    LastPos <- 203
    Differences <- c()
for (i in FirstPos:LastPos){
    
#    print(i)
    CurDifferences <- 0
    for (j in 2:7){
        CurDifferences <- CurDifferences + abs(DataTableOne[i,j] - DataTableOne[Val,j])
    }
    Differences <- c(Differences, CurDifferences)
}

if (k == 1){
    
    plot(Differences, col=ViridisColors[k], lty= "solid", ylim = c(0,0.1), pch = Pchs[Num], ylab = "Absolute difference between probability distributions of L\n using 4Ns = -100 vs 4Ns = K", xaxt = "n", xlab = "Compared 4Ns value \'K\'",cex.lab=2, cex.axis=2, main = "F) 4Ns = -100",cex.main=2.5, type ="l",lwd = 11 - k)
}else{
    lines(Differences, col = ViridisColors[k], lty = "solid", pch = Pchs[Num],lwd = 11 - k)
}
}
}
axis(1, at = c(1,101,201,301,401), labels = c("-200","-100", "0", "100", "200"), cex.axis = 2 )
legend("topleft", c("Demographic Scenario (Replicate)","1","2","3","4","5","6","7","8","9","10","Population Expansion Model - Expansion time = 100 Gens Ago (see S3)"), col = c("white",ViridisColors[1:10], "red") , pch = "-", title = "", cex = 1.5, bty= 'n')

# legend("topright", c("7","8","9","10","Pop Expansion 100 Gens Ago (see S4)"), col = c( ViridisColors[7:10], "red") , pch = "-", title = "Demographic Scenario (Replicate)", cex = 2, bty= 'n')


DataTableOne <- read.table ("../Results/ISPopExpansionTables/TableToTestPopExpansion100GensAgo.txt")
Differences <- c()
Pchs <- c(3, 4, 8, 9, 19)

InitialValue <- c(103)
# InitialValue <- c(103)
for (Num in 1:1){
    Val <- InitialValue[Num]
    FirstPos <- 3
    LastPos <- 203
    Differences <- c()
for (i in FirstPos:LastPos){
    
#    print(i)
    CurDifferences <- 0
    for (j in 2:7){
        CurDifferences <- CurDifferences + abs(DataTableOne[i,j] - DataTableOne[Val,j])
    }
    Differences <- c(Differences, CurDifferences)
}

if (Val == 103){
    lines(Differences, col = "red", type = "l", lty= "solid", pch = Pchs[Num], lwd=3)
}
}



dev.off()


