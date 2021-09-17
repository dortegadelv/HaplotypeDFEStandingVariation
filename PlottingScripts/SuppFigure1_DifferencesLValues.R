library(here)
library(viridis)
library(jpeg)
library(plotrix)
library(beanplot)
library(RColorBrewer)

ViridisColors <- viridis(5)

pdf("../Figures/SuppFigure1_ComparisonLDistributions.pdf")
par(mar=c(5,7,5,4)+0.1)

DemographicScenarios <- c("ConstantPopSize","PopExpansion")
FourNs <- c("4Ns_0", "4Ns_50", "4Ns_100", "4Ns_-50", "4Ns_-100")
DemographicScenariosTitle <- c("Constant Population Size","Population Expansion")
FourNsTitle  <- c("4Ns = 0", "4Ns = 50", "4Ns = 100", "4Ns = -50", "4Ns = -100")

DataTableOne <- read.table ("../Results/ConstantPopSize/ImportanceSamplingSims/TableToTest.txt")
DataTableTwo <- read.table ("../Results/PopExpansion/ImportanceSamplingSims/TableToTest.txt")

Differences <- c()
Pchs <- c(3, 4, 8, 9, 19)

InitialValue <- c(103, 153, 203, 253, 303)
# InitialValue <- c(103)
for (Num in 1:5){
    Val <- InitialValue[Num]
    FirstPos <- 3
    LastPos <- 403
    Differences <- c()
for (i in FirstPos:LastPos){
    
    print(i)
    CurDifferences <- 0
    for (j in 2:7){
        CurDifferences <- CurDifferences + abs(DataTableOne[i,j] - DataTableOne[Val,j])
    }
    Differences <- c(Differences, CurDifferences)
}

DifferencesTableTwo <- c()

for (i in FirstPos:LastPos){
    
    print(i)
    CurDifferences <- 0
    for (j in 2:7){
        CurDifferences <- CurDifferences + abs(DataTableTwo[i,j] - DataTableTwo[Val,j])
    }
    DifferencesTableTwo <- c(DifferencesTableTwo, CurDifferences)
}
if (Val == 103){
    
    plot(DifferencesTableTwo, col=ViridisColors[Num], type = "b", lty= "dotdash", ylim = c(0,0.25), pch = Pchs[Num], ylab = "Absolute difference between probability distributions of L\n using 4Ns = J vs 4Ns = K", xaxt = "n", xlab = "Compared 4Ns value \'K\'")
}else{
    lines(DifferencesTableTwo, col = ViridisColors[Num], type = "b", lty= "dotdash", pch = Pchs[Num])
}
}

axis(1, at = c(1,101,201,301,401), labels = c("-200","-100", "0", "100", "200") )
legend("top", c("-100","-50","0","50","100"), col = ViridisColors , pch = c(3, 4, 8, 9, 19), title = "Focal 4Ns value \'J\'")

dev.off()

