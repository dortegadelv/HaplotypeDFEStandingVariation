setwd("/Users/vicentediegoortegadelvecchyo/Documents/DissertationThesis/PurifyingSelection/Drafts/PaperResults/SimsResults/FrequencyTrajectories/")

#### Constant Pop Size

Traj_4Ns_0 <- read.table("OutMeanTrajConstantPopSize4Ns0.txt")
Traj_4Ns_50 <- read.table("OutMeanTrajConstantPopSize4Ns50.txt")
Traj_4Ns_100 <- read.table("OutMeanTrajConstantPopSize4Ns100.txt")
Traj_4Ns_Minus50 <- read.table("OutMeanTrajConstantPopSize4Ns-50.txt")
Traj_4Ns_Minus100 <- read.table("OutMeanTrajConstantPopSize4Ns-100.txt")

SE_0 <- (Traj_4Ns_0$V2 - Traj_4Ns_0$V3)*100
SE_50 <- (Traj_4Ns_0$V2 - Traj_4Ns_0$V3)*100
SE_100 <- (Traj_4Ns_0$V2 - Traj_4Ns_0$V3)*100
SE_Minus50 <- (Traj_4Ns_0$V2 - Traj_4Ns_0$V3)*100
SE_Minus100 <- (Traj_4Ns_0$V2 - Traj_4Ns_0$V3)*100

T_Test_50 <-  (Traj_4Ns_50$V2 - Traj_4Ns_Minus50$V2)/(((SE_50*SE_50)/10000 + (SE_Minus50*SE_Minus50)/10000 )^(1/2))
T_Test_100 <-  (Traj_4Ns_100$V2 - Traj_4Ns_Minus100$V2)/(((SE_100*SE_100)/10000 + (SE_Minus100*SE_Minus100)/10000 )^(1/2))

Degrees50 <- round(((SE_50*SE_50)/10000 + (SE_Minus50*SE_Minus50)/10000)^2/((SE_50*SE_50*SE_50*SE_50)/(10000*9999) + (SE_Minus50*SE_Minus50*SE_Minus50*SE_Minus50)/(10000*9999)))
Degrees100 <- round(((SE_100*SE_100)/10000 + (SE_Minus100*SE_Minus100)/10000)^2/((SE_100*SE_100*SE_100*SE_100)/(10000*10000*9999) + (SE_Minus100*SE_Minus100*SE_Minus100*SE_Minus100)/(10000*10000*9999)))

PValues50 <- pt(T_Test_50,Degrees50)
PValues100 <- pt(T_Test_100,Degrees100)

Counts <- 0
MeanDifference <- 0
for (i in 1:10000){

	if (PValues50[i] > 0.975){
		Counts <- Counts + 1
		MeanDifference <- MeanDifference + Traj_4Ns_50$V2[i] - Traj_4Ns_Minus50$V2[i]
	}
}

Counts <- 0
MeanDifference <- 0
for (i in 1:10000){
	
	if (PValues100[i] > 0.975){
		Counts <- Counts + 1
		MeanDifference <- MeanDifference + Traj_4Ns_100$V2[i] - Traj_4Ns_Minus100$V2[i]
	}
}


#### Constant Pop Size Pop Frequency

Traj_4Ns_0 <- read.table("OutMeanTrajConstantPopSizePopFrequency4Ns0.txt")
Traj_4Ns_50 <- read.table("OutMeanTrajConstantPopSizePopFrequency4Ns50.txt")
Traj_4Ns_100 <- read.table("OutMeanTrajConstantPopSizePopFrequency4Ns100.txt")
Traj_4Ns_Minus50 <- read.table("OutMeanTrajConstantPopSizePopFrequency4Ns-50.txt")
Traj_4Ns_Minus100 <- read.table("OutMeanTrajConstantPopSizePopFrequency4Ns-100.txt")

SE_0 <- (Traj_4Ns_0$V2 - Traj_4Ns_0$V3)*100
SE_50 <- (Traj_4Ns_0$V2 - Traj_4Ns_0$V3)*100
SE_100 <- (Traj_4Ns_0$V2 - Traj_4Ns_0$V3)*100
SE_Minus50 <- (Traj_4Ns_0$V2 - Traj_4Ns_0$V3)*100
SE_Minus100 <- (Traj_4Ns_0$V2 - Traj_4Ns_0$V3)*100

T_Test_50 <-  (Traj_4Ns_50$V2 - Traj_4Ns_Minus50$V2)/(((SE_50*SE_50)/10000 + (SE_Minus50*SE_Minus50)/10000 )^(1/2))
T_Test_100 <-  (Traj_4Ns_100$V2 - Traj_4Ns_Minus100$V2)/(((SE_100*SE_100)/10000 + (SE_Minus100*SE_Minus100)/10000 )^(1/2))

Degrees50 <- round(((SE_50*SE_50)/10000 + (SE_Minus50*SE_Minus50)/10000)^2/((SE_50*SE_50*SE_50*SE_50)/(10000*9999) + (SE_Minus50*SE_Minus50*SE_Minus50*SE_Minus50)/(10000*9999)))
Degrees100 <- round(((SE_100*SE_100)/10000 + (SE_Minus100*SE_Minus100)/10000)^2/((SE_100*SE_100*SE_100*SE_100)/(10000*10000*9999) + (SE_Minus100*SE_Minus100*SE_Minus100*SE_Minus100)/(10000*10000*9999)))

PValues50 <- pt(T_Test_50,Degrees50)
PValues100 <- pt(T_Test_100,Degrees100)

Counts <- 0
MeanDifference <- 0
for (i in 1:10000){
	
	if (PValues50[i] > 0.975){
		Counts <- Counts + 1
		MeanDifference <- MeanDifference + Traj_4Ns_50$V2[i] - Traj_4Ns_Minus50$V2[i]
	}
}

