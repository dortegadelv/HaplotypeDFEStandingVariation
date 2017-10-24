setwd("/Users/vicentediegoortegadelvecchyo/Documents/DissertationThesis/PurifyingSelection/Drafts/PaperResults/SimsResults/FrequencyTrajectories/")

pdf("MeanTrajectoriesConstantPopSize.pdf")
par(mar=c(5,5,4,2) + 0.1)   

Data <- read.table("OutMeanTrajConstantPopSize4Ns0.txt")

Color <- col2rgb("black")
plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Generations",ylab="Mean Allele Frequency",type="l",ylim=c(0,0.015),main="Average of more than 10,000 trajectories per every 4Ns",xaxt="n",cex.lab=2,cex.main=1.3,cex.axis=1.5,lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajConstantPopSize4Ns-50.txt")

Color <- col2rgb("purple")
lines(Data$V1[5000:1],Data$V2[1:5000],col="purple",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")

#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajConstantPopSize4Ns-100.txt")

Color <- col2rgb("orange")
lines(Data$V1[5000:1],Data$V2[1:5000],col="orange",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")

#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajConstantPopSize4Ns50.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="red",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")

Data <- read.table("OutMeanTrajConstantPopSize4Ns100.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="dodgerblue",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")

legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)

#abline(v=100,lty="dashed")

dev.off()

######## Pop Expansion

pdf("MeanTrajectoriesPopExpansion.pdf")
par(mar=c(5,5,4,2) + 0.1)   

Data <- read.table("OutMeanTrajPopExpansion4Ns0.txt")

Color <- col2rgb("black")
plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Generations",ylab="Mean Allele Frequency",type="l",ylim=c(0,0.015),main="Average of more than 10,000 trajectories per every 4Ns",xaxt="n",cex.lab=2,cex.main=1.3,cex.axis=1.5,lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajPopExpansion4Ns-50.txt")

Color <- col2rgb("purple")
lines(Data$V1[5000:1],Data$V2[1:5000],col="purple",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")

#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajPopExpansion4Ns-100.txt")

Color <- col2rgb("orange")
lines(Data$V1[5000:1],Data$V2[1:5000],col="orange",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")

#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajPopExpansion4Ns50.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="red",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")

Data <- read.table("OutMeanTrajPopExpansion4Ns100.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="dodgerblue",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")

legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)

#abline(v=100,lty="dashed")

dev.off()

######### Ancient bottleneck


pdf("MeanTrajectoriesAncientBottleneck.pdf")
par(mar=c(5,5,4,2) + 0.1)   

Data <- read.table("OutMeanTrajAncientBottleneck4Ns0.txt")

Color <- col2rgb("black")
plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Generations",ylab="Mean Allele Frequency",type="l",ylim=c(0,0.015),main="Average of more than 10,000 trajectories per every 4Ns",xaxt="n",cex.lab=2,cex.main=1.3,cex.axis=1.5,lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajAncientBottleneck4Ns-50.txt")

Color <- col2rgb("purple")
lines(Data$V1[5000:1],Data$V2[1:5000],col="purple",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")

#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajAncientBottleneck4Ns-100.txt")

Color <- col2rgb("orange")
lines(Data$V1[5000:1],Data$V2[1:5000],col="orange",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")

#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajAncientBottleneck4Ns50.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="red",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")

Data <- read.table("OutMeanTrajAncientBottleneck4Ns100.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="dodgerblue",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")

legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)

#abline(v=100,lty="dashed")

dev.off()

######### Recent bottleneck


pdf("MeanTrajectoriesRecentBottleneck.pdf")
par(mar=c(5,5,4,2) + 0.1)   

Data <- read.table("OutMeanTrajRecentBottleneck4Ns0.txt")

Color <- col2rgb("black")
plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Generations",ylab="Mean Allele Frequency",type="l",ylim=c(0,0.015),main="Average of more than 10,000 trajectories per every 4Ns",xaxt="n",cex.lab=2,cex.main=1.3,cex.axis=1.5,lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajRecentBottleneck4Ns-50.txt")

Color <- col2rgb("purple")
lines(Data$V1[5000:1],Data$V2[1:5000],col="purple",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")

#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajRecentBottleneck4Ns-100.txt")

Color <- col2rgb("orange")
lines(Data$V1[5000:1],Data$V2[1:5000],col="orange",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")

#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajRecentBottleneck4Ns50.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="red",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")

Data <- read.table("OutMeanTrajRecentBottleneck4Ns100.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="dodgerblue",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")

legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)

#abline(v=100,lty="dashed")

dev.off()

######### Medium bottleneck


pdf("MeanTrajectoriesMediumBottleneck.pdf")
par(mar=c(5,5,4,2) + 0.1)   

Data <- read.table("OutMeanTrajMediumBottleneck4Ns0.txt")

Color <- col2rgb("black")
plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Generations",ylab="Mean Allele Frequency",type="l",ylim=c(0,0.015),main="Average of more than 10,000 trajectories per every 4Ns",xaxt="n",cex.lab=2,cex.main=1.3,cex.axis=1.5,lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajMediumBottleneck4Ns-50.txt")

Color <- col2rgb("purple")
lines(Data$V1[5000:1],Data$V2[1:5000],col="purple",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")

#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajMediumBottleneck4Ns-100.txt")

Color <- col2rgb("orange")
lines(Data$V1[5000:1],Data$V2[1:5000],col="orange",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")

#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajMediumBottleneck4Ns50.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="red",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")

Data <- read.table("OutMeanTrajMediumBottleneck4Ns100.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="dodgerblue",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")

legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)

#abline(v=100,lty="dashed")

dev.off()

############################################################# Point five percent ################################################################################


pdf("MeanTrajectoriesConstantPopSizePointFivePercent.pdf")
par(mar=c(5,5,4,2) + 0.1)   

Data <- read.table("OutMeanTrajConstantPopSizePointFivePercent4Ns0.txt")

Color <- col2rgb("black")
plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Generations",ylab="Mean Allele Frequency",type="l",ylim=c(0,0.01),main="Average of more than 10,000 trajectories per every 4Ns",xaxt="n",cex.lab=2,cex.main=1.3,cex.axis=1.5,lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajConstantPopSizePointFivePercent4Ns-50.txt")

Color <- col2rgb("purple")
lines(Data$V1[5000:1],Data$V2[1:5000],col="purple",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")

#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajConstantPopSizePointFivePercent4Ns-100.txt")

Color <- col2rgb("orange")
lines(Data$V1[5000:1],Data$V2[1:5000],col="orange",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")

#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajConstantPopSizePointFivePercent4Ns50.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="red",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")

Data <- read.table("OutMeanTrajConstantPopSizePointFivePercent4Ns100.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="dodgerblue",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")

legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)

#abline(v=100,lty="dashed")

dev.off()

######## Pop Expansion

pdf("MeanTrajectoriesPopExpansionPointFivePercent.pdf")
par(mar=c(5,5,4,2) + 0.1)   

Data <- read.table("OutMeanTrajPopExpansionPointFivePercent4Ns0.txt")

Color <- col2rgb("black")
plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Generations",ylab="Mean Allele Frequency",type="l",ylim=c(0,0.01),main="Average of more than 10,000 trajectories per every 4Ns",xaxt="n",cex.lab=2,cex.main=1.3,cex.axis=1.5,lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajPopExpansionPointFivePercent4Ns-50.txt")

Color <- col2rgb("purple")
lines(Data$V1[5000:1],Data$V2[1:5000],col="purple",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")

#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajPopExpansionPointFivePercent4Ns-100.txt")

Color <- col2rgb("orange")
lines(Data$V1[5000:1],Data$V2[1:5000],col="orange",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")

#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajPopExpansionPointFivePercent4Ns50.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="red",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")

Data <- read.table("OutMeanTrajPopExpansionPointFivePercent4Ns100.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="dodgerblue",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")

legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)

#abline(v=100,lty="dashed")

dev.off()

######### Ancient bottleneck


pdf("MeanTrajectoriesAncientBottleneckPointFivePercent.pdf")
par(mar=c(5,5,4,2) + 0.1)   

Data <- read.table("OutMeanTrajAncientBottleneckPointFivePercent4Ns0.txt")

Color <- col2rgb("black")
plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Generations",ylab="Mean Allele Frequency",type="l",ylim=c(0,0.01),main="Average of more than 10,000 trajectories per every 4Ns",xaxt="n",cex.lab=2,cex.main=1.3,cex.axis=1.5,lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajAncientBottleneckPointFivePercent4Ns-50.txt")

Color <- col2rgb("purple")
lines(Data$V1[5000:1],Data$V2[1:5000],col="purple",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")

#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajAncientBottleneckPointFivePercent4Ns-100.txt")

Color <- col2rgb("orange")
lines(Data$V1[5000:1],Data$V2[1:5000],col="orange",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")

#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajAncientBottleneckPointFivePercent4Ns50.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="red",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")

Data <- read.table("OutMeanTrajAncientBottleneckPointFivePercent4Ns100.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="dodgerblue",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")

legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)

#abline(v=100,lty="dashed")

dev.off()

######### Recent bottleneck


pdf("MeanTrajectoriesRecentBottleneckPointFivePercent.pdf")
par(mar=c(5,5,4,2) + 0.1)   

Data <- read.table("OutMeanTrajRecentBottleneckPointFivePercent4Ns0.txt")

Color <- col2rgb("black")
plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Generations",ylab="Mean Allele Frequency",type="l",ylim=c(0,0.01),main="Average of more than 10,000 trajectories per every 4Ns",xaxt="n",cex.lab=2,cex.main=1.3,cex.axis=1.5,lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajRecentBottleneckPointFivePercent4Ns-50.txt")

Color <- col2rgb("purple")
lines(Data$V1[5000:1],Data$V2[1:5000],col="purple",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")

#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajRecentBottleneckPointFivePercent4Ns-100.txt")

Color <- col2rgb("orange")
lines(Data$V1[5000:1],Data$V2[1:5000],col="orange",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")

#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajRecentBottleneckPointFivePercent4Ns50.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="red",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")

Data <- read.table("OutMeanTrajRecentBottleneckPointFivePercent4Ns100.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="dodgerblue",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")

legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)

#abline(v=100,lty="dashed")

dev.off()

######### Medium bottleneck


pdf("MeanTrajectoriesMediumBottleneckPointFivePercent.pdf")
par(mar=c(5,5,4,2) + 0.1)   

Data <- read.table("OutMeanTrajMediumBottleneckPointFivePercent4Ns0.txt")

Color <- col2rgb("black")
plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Generations",ylab="Mean Allele Frequency",type="l",ylim=c(0,0.01),main="Average of more than 10,000 trajectories per every 4Ns",xaxt="n",cex.lab=2,cex.main=1.3,cex.axis=1.5,lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajMediumBottleneckPointFivePercent4Ns-50.txt")

Color <- col2rgb("purple")
lines(Data$V1[5000:1],Data$V2[1:5000],col="purple",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")

#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajMediumBottleneckPointFivePercent4Ns-100.txt")

Color <- col2rgb("orange")
lines(Data$V1[5000:1],Data$V2[1:5000],col="orange",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")

#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))

Data <- read.table("OutMeanTrajMediumBottleneckPointFivePercent4Ns50.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="red",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")

Data <- read.table("OutMeanTrajMediumBottleneckPointFivePercent4Ns100.txt")

lines(Data$V1[5000:1],Data$V2[1:5000],col="dodgerblue",lty="dashed",lwd=3)
lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")

legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)

#abline(v=100,lty="dashed")

dev.off()





########### Sardinia demographic history


pdf("SardiniaPopHistory.pdf",width=9)
par(mar=c(5,5,4,2) + 0.1)

plot(c(0,160000,160100,164000,164100,164371,164471,164720),c(20000/2,378/2,20000/2,1098/2,11266/2,6491/2,35492/2,35492/2),type="s",ylim=c(0,20000),xlim=c(159900,164720),ylab="Effective Population Size",xlab="Generations before the present",main="Sardinia Population history",xaxt='n',yaxt='n',cex.main=2,cex.lab=2,col="red",lwd=2)

axis(1,at=c(164720,164720-1000,164720-2000,164720-3000,164720-4000),labels = c("Present","1000","2000","3000","4000"),cex.axis=2)
axis(2,at=c(0,5000,10000,15000,20000),labels = c("0","5000","10000","15000","20000"),cex.axis=1.9)

dev.off()


pdf("SardiniaEarlyPopHistory.pdf",width=9)
par(mar=c(5,5,4,2) + 0.1)

plot(c(0,160000,160100,164000,164100,164371,164471,164720),c(20000/2,378/2,20000/2,1098/2,11266/2,6491/2,35492/2,35492/2),type="s",ylim=c(0,20000),xlim=c(164720-300,164720),ylab="Effective Population Size",xlab="Generations before the present",main="Sardinia Recent Population Growth",xaxt='n',yaxt='n',cex.main=2,cex.lab=2,col="red",lwd=2)

axis(1,at=c(164720,164720-100,164720-200,164720-300,164720-400),labels = c("Present","100","200","300","400"),cex.axis=2)
axis(2,at=c(0,5000,10000,15000,20000),labels = c("0","5000","10000","15000","20000"),cex.axis=1.9)

dev.off()


