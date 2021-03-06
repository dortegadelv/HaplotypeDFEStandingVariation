### Set directory to the place where you have the 'PlottingScripts' folder

library(here)
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
Selection <- c(Selection,"4Ns-100")
Selection <- c(Selection,"4Ns50")
Selection <- c(Selection,"4Ns100")


SelectionTest <- c()
SelectionTest <- c(SelectionTest,"4Ns_0")
SelectionTest <- c(SelectionTest,"4Ns_-50")
SelectionTest <- c(SelectionTest,"4Ns_-100")
SelectionTest <- c(SelectionTest,"4Ns_50")
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

XLimFigureOne <- c()
XLimFigureOne[1]=2500
XLimFigureOne[2]=2500
XLimFigureOne[3]=1000
XLimFigureOne[4]=1000
XLimFigureOne[5]=2500
XLimFigureOne[6]=2500
XLimFigureOne[7]=3500
XLimFigureOne[8]=3500
XLimFigureOne[9]=3500
XLimFigureOne[10]=3500
XLimFigureOne[11]=1000

XLimFigureTwo <- c()
XLimFigureTwo[1]=1500
XLimFigureTwo[2]=900
XLimFigureTwo[3]=3000
XLimFigureTwo[4]=2000
XLimFigureTwo[5]=1500
XLimFigureTwo[6]=900
XLimFigureTwo[7]=1750
XLimFigureTwo[8]=1000
XLimFigureTwo[9]=2000
XLimFigureTwo[10]=900
XLimFigureTwo[11]=3000

YLimFigureTwo <- c()
YLimFigureTwo[1]=0.225
YLimFigureTwo[2]=0.3
YLimFigureTwo[3]=0.125
YLimFigureTwo[4]=0.175
YLimFigureTwo[5]=0.2
YLimFigureTwo[6]=0.3
YLimFigureTwo[7]=0.275
YLimFigureTwo[8]=0.325
YLimFigureTwo[9]=0.35
YLimFigureTwo[10]=0.5
YLimFigureTwo[11]=0.125

XLimFigureThree <- c()
XLimFigureThree[1]=350
XLimFigureThree[2]=150
XLimFigureThree[3]=650
XLimFigureThree[4]=400
XLimFigureThree[5]=300
XLimFigureThree[6]=150
XLimFigureThree[7]=400
XLimFigureThree[8]=300
XLimFigureThree[9]=300
XLimFigureThree[10]=150
XLimFigureThree[11]=650

for (j in 1:11){
	print(DemScenario[j])
	MaxFreq <- 0
	for (i in 1:5){
		TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTraj",DemScenario[j],Selection[i],".txt",sep="")
		Data <- read.table(TrajectoryFile)
		MaxFreq <- max(MaxFreq,Data$V2)
		print(MaxFreq)
	}
	ListMaxFreq <- c(ListMaxFreq,MaxFreq)
	MaxAge <- 0
	TrajectoryFile <- paste("../Results/AlleleAges/Ages",DemScenario[j],"_",SelectionTest[1],".txt",sep="")
	Data <- read.table(TrajectoryFile)
	Max <- max(density(Data$V1*Ne[j]*2,from=0,to=quantile(Data$V1*Ne[j]*2,0.99))$x)
	for (i in 1:5){
		TrajectoryFile <- paste("../Results/AlleleAges/Ages",DemScenario[j],"_",SelectionTest[i],".txt",sep="")
		Data <- read.table(TrajectoryFile)
		MaxAge <- max(MaxAge,(density(Data$V1*Ne[j]*2,from=0,to=Max)$y))
		print(MaxAge)
	}
	ListMaxAge <- c(ListMaxAge,MaxAge)
	MaxT2 <- 0
	for (i in 1:5){
        if (j == 3){
            TrajectoryFile <- paste("../Results/TTwos/TPW",DemScenario[j],"_",SelectionTest[i],".txt",sep="")
        }else{
            TrajectoryFile <- paste("../Results/TTwos/",DemScenario[j],"_",SelectionTest[i],".txt",sep="")
            
        }
		Data <- read.table(TrajectoryFile)
		MaxT2 <- max(MaxT2,Data$V2)
		print(MaxT2)
	}
	ListMaxT2 <- c(ListMaxT2,MaxT2)	
}



for (j in 3:3){

Plot <- paste("../Figures/Figure2_ConstantPopFreqAgeT2.pdf",sep="")
pdf(Plot,width=28/2,height=7*2/1.55)
par(mfrow=c(2,3))
par(mar=c(5,5,5,2) + 0.1)

	
	TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTraj",DemScenario[j],Selection[1],".txt",sep="")
	Data <- read.table(TrajectoryFile)
	ColorViridis <- viridis(5)
	ColorViridisAlpha <- viridis(5,alpha=0.6)
	Color <- col2rgb("black")
	if (j==7 || j==8){
		plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Time before the present",ylab="Mean Allele Frequency",type="l",xlim=c(XLimFigureOne[j],5000),ylim=c(0,ListMaxFreq[j]*1.3),main="A) Average Frequency Trajectory",xaxt="n",cex.lab=2.5,cex.main=2,cex.axis=2,lwd=6,col=ColorViridis[3])
		
	}else{
		plot(Data$V1[5000:1],Data$V2[1:5000],xlab="Time before the present",ylab="Mean Allele Frequency",type="l",xlim=c(XLimFigureOne[j],5000),ylim=c(0,ListMaxFreq[j]),main="A) Average Frequency \nTrajectory",xaxt="n",cex.lab=2.5,cex.main=2.5,cex.axis=2,lwd=6,col=ColorViridis[3])
	}
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3)
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3)
#lines(Data$V1[10000:1],ISData$V2[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
	
	if (j==7 || j==8){
		abline(v=5000-100,lty=3,cex=3,lwd=3)
	}
	if (j==1 || j==2){
		abline(v=5000-5000,lty=3,lwd=3)
		abline(v=5000-5200,lty=3,lwd=3)
	}
	if (j==5 || j==6){
		abline(v=5000-2000,lty=3,lwd=3)
		abline(v=5000-2200,lty=3,lwd=3)
	}
	if (j==9 || j==10){
		abline(v=5000-100,lty=3,cex=3,lwd=3)
		abline(v=5000-300,lty=3,cex=3,lwd=3)
	}
	
	
	TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTraj",DemScenario[j],Selection[2],".txt",sep="")
	Data <- read.table(TrajectoryFile)
	
	Color <- col2rgb("purple")
	lines(Data$V1[5000:1],Data$V2[1:5000],lwd=6,col=ColorViridis[2])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="purple")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="purple")
	
#lines(Data$V1[10000:1],ISData$V3[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
	
	TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTraj",DemScenario[j],Selection[3],".txt",sep="")
	Data <- read.table(TrajectoryFile)
	
	Color <- col2rgb("orange")
	lines(Data$V1[5000:1],Data$V2[1:5000],lwd=6,col=ColorViridis[1])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="orange")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="orange")
	
#lines(Data$V1[10000:1],ISData$V4[1:10000],lwd=10,col=rgb(Color[1,1],Color[2,1],Color[3,1],100,maxColorValue=255))
	
	TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTraj",DemScenario[j],Selection[4],".txt",sep="")
	Data <- read.table(TrajectoryFile)
	
	lines(Data$V1[5000:1],Data$V2[1:5000],lty=5,lwd=6,col=ColorViridis[4])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="red")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="red")
	
	TrajectoryFile <- paste("../Results/FrequencyTrajectories/OutMeanTraj",DemScenario[j],Selection[5],".txt",sep="")
	Data <- read.table(TrajectoryFile)
	
	lines(Data$V1[5000:1],Data$V2[1:5000],lty=5,lwd=6,col=ColorViridis[5])
#lines(Data$V1[5000:1],Data$V3[1:5000],lty=3,col="dodgerblue")
#lines(Data$V1[5000:1],Data$V4[1:5000],lty=3,col="dodgerblue")
	if (j == 1 || j == 2 ){
		legend("center",c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N[0],'s',sep="")),bty="n")
	}else if( j == 5){
		legend(5000-1500,0.0078,c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N[0],'s',sep="")),bty="n")
	}else if( j == 6){
		legend(5000-1600,0.0035,c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N[0],'s',sep="")),bty="n")
	}else if( j == 9){
		legend(5000-1500,0.017,c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N[0],'s',sep="")),bty="n")
	}else if( j == 10){
		legend(5000-1500,0.0065,c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N[0],'s',sep="")),bty="n")
	}else if (j == 7 || j == 8 ){
		legend("topleft",c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N[0],'s',sep="")),bty="n")	
	}else if (j == 3 ||j == 4 ||j == 11){
		legend("center",c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")
	}
#legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
	axis(1,at=c(5000,4000,3000,2000,1000,0),labels=c("Present","1000","2000","3000","4000","5000"),cex.lab=2,cex.axis=2)
	
	par(mar=c(5,5,4,2) + 0.1)   
	
	AgesFile <- paste("../Results/AlleleAges/Ages",DemScenario[j],"_",SelectionTest[1],".txt",sep="")
	
	Data <- read.table(AgesFile)
	
	Color <- col2rgb("black")
	Max <- quantile(Data$V1*Ne[j]*2,0.99)
	if (j==7){
		Breaks <- seq(from=0,to=max(Data$V1*Ne[j]*2+50),by=50)
		Histogram <- hist(Data$V1*2*Ne[j],breaks=Breaks,plot=FALSE)
		XSubset <- subset(rev(density(Data$V1*Ne[j]*2,from=0,to=Max)$x),rev(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)<=XLimFigureTwo[j]*0.78 )
		Length <- length(XSubset) - 1
		MaxLength <- length(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)
		plot(rev(c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.22*(XLimFigureTwo[j]),density(Data$V1*Ne[j]*2,from=0,to=Max)$x[(MaxLength-Length):(MaxLength)])),density(Data$V1*Ne[j]*2,from=0,to=Max)$y[1:(Length+2)],xlab="Allele Age",ylab="Probability",type="l",ylim=c(-0.2*ListMaxAge[j],ListMaxAge[j]),main="B) Allele Age",xaxt="n",yaxt="n",col=ColorViridis[3],cex.lab=2,cex.main=2,cex.axis=1.5,lwd=6,xlim=c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j],max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)))
		SD <- sd(Data$V1*Ne[j]*2)
		arrows(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j]+0.1*XLimFigureTwo[j],-0.12*ListMaxAge[j],min(Max- mean(Data$V1*Ne[j]*2)+SD,Max),-0.12*ListMaxAge[j], length=0.05, angle=90, code=3,col=ColorViridis[3],lwd=6)
		
#		plot(max(Data$V1*Ne[j]*2) - 0:99*50,Histogram$counts[1:100]/sum(Histogram$counts),xlab="Allele Age",ylab="Probability",type="l",ylim=c(0,YLimFigureTwo[j]),main="B) Allele Age",xaxt="n",cex.lab=2,cex.main=2,cex.axis=1.5,lwd=6,xlim=c(max(density(Data$V1*Ne[j]*2,from=0)$x)-XLimFigureTwo[j],max(Data$V1*Ne[j]*2)))
#		abline(v=mean(Max- Data$V1*Ne[j]*2),lwd=6,col=ColorViridisAlpha[3])
		points(Max - mean(Data$V1*Ne[j]*2),-0.12*ListMaxAge[j],pch=20,col=ColorViridis[3],cex=3)
		axis(2,at=c(0,0.002,0.004,0.006,0.008,0.01,0.012,0.014,0.016,0.018,0.02),labels=c("0","0.002","0.004","0.006","0.008","0.01","0.012","0.014","0.016","0.018","0.02"),cex.lab=2,cex.axis=2)	
## X values 
		XFirstValue <- max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x) - 0.8*XLimFigureTwo[j]
		Threshold <- mean(Data$V1*Ne[j]*2) + SD-0.1*XLimFigureTwo[j]
		SubsetXValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$x,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
		SubsetYValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$y,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
		YValuesToPrint <- c(density(Data$V1*Ne[j]*2,from=0,to=Max)$y[length(density(Data$V1*Ne[j]*2,from=0,to=Max)$y) - length(SubsetYValues)],SubsetYValues)
		TransformedXValues <- SubsetXValues - Threshold
		XValuesToPrint <- c(XFirstValue,XFirstValue-TransformedXValues)
		lines(rev(c(XValuesToPrint)),YValuesToPrint,col=ColorViridis[3],lwd=6 )
		
	}else{
		Breaks <- seq(from=0,to=max(Data$V1*Ne[j]*2+50),by=50)
		Histogram <- hist(Data$V1*2*Ne[j],breaks=Breaks,plot=FALSE)
		XSubset <- subset(rev(density(Data$V1*Ne[j]*2,from=0,to=Max)$x),rev(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)<=XLimFigureTwo[j]*0.78 )
		Length <- length(XSubset) - 1
		MaxLength <- length(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)
		plot(rev(c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.22*(XLimFigureTwo[j]),density(Data$V1*Ne[j]*2,from=0,to=Max)$x[(MaxLength-Length):(MaxLength)])),density(Data$V1*Ne[j]*2,from=0,to=Max)$y[1:(Length+2)],xlab="Allele Age",ylab="Probability",type="l",ylim=c(-0.2*ListMaxAge[j],ListMaxAge[j]),main="B) Allele Age",xaxt="n",yaxt="n",col=ColorViridis[3],cex.lab=2.5,cex.main=2.5,cex.axis=1.5,lwd=6,xlim=c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j],max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)))
		SD <- sd(Data$V1*Ne[j]*2)
		arrows(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j]+0.1*XLimFigureTwo[j],-0.12*ListMaxAge[j],min(Max- mean(Data$V1*Ne[j]*2)+SD,Max),-0.12*ListMaxAge[j], length=0.05, angle=90, code=3,col=ColorViridis[3],lwd=6)
		
#		abline(v=mean(Max - Data$V1*Ne[j]*2),lwd=6,col=ColorViridisAlpha[3])
		points(Max - mean(Data$V1*Ne[j]*2),-0.12*ListMaxAge[j],pch=20,col=ColorViridis[3],cex=3)
#		plot(max(Data$V1*Ne[j]*2) - 0:99*50,Histogram$counts[1:100]/sum(Histogram$counts),xlab="Allele Age",ylab="Probability",type="l",ylim=c(0,YLimFigureTwo[j]),main="B) Allele Age",xaxt="n",cex.lab=2,cex.main=2,cex.axis=1.5,lwd=6,xlim=c(max(density(Data$V1*Ne[j]*2,from=0)$x)-XLimFigureTwo[j],max(Data$V1*Ne[j]*2)))
		axis(2,at=c(0,0.002,0.004,0.006,0.008,0.01,0.012,0.014,0.016,0.018,0.02),labels=c("0","0.002","0.004","0.006","0.008","0.01","0.012","0.014","0.016","0.018","0.02"),cex.lab=2,cex.axis=2)	
## X values 
		XFirstValue <- max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x) - 0.8*XLimFigureTwo[j]
		Threshold <- mean(Data$V1*Ne[j]*2) + SD-0.1*XLimFigureTwo[j]
		SubsetXValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$x,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
		SubsetYValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$y,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
		YValuesToPrint <- c(density(Data$V1*Ne[j]*2,from=0,to=Max)$y[length(density(Data$V1*Ne[j]*2,from=0,to=Max)$y) - length(SubsetYValues)],SubsetYValues)
		TransformedXValues <- SubsetXValues - Threshold
		XValuesToPrint <- c(XFirstValue,XFirstValue-TransformedXValues)
		lines(rev(c(XValuesToPrint)),YValuesToPrint,col=ColorViridis[3],lwd=6 )
	}
	if (j==7 || j==8){
#		abline(v=max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-100,lty=3,lwd=3)
		segments(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-100,0,max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-100,100,lty=3,lwd=3)
	}
	if (j==1 || j==2){
#		abline(v=max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-5000,lty=3,lwd=3)
#		abline(v=max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-5200,lty=3,lwd=3)
		segments(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-5000,0,max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-5000,100,lty=3,lwd=3)
		segments(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-5200,0,max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-5200,300,lty=3,lwd=3)
		
	}
	if (j==5 || j==6){
#		abline(v=max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-2000,lty=3,lwd=3)
#		abline(v=max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-2200,lty=3,lwd=3)
		segments(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-2000,0,max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-2000,100,lty=3,lwd=3)
		segments(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-2200,0,max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-2200,300,lty=3,lwd=3)
	}
	if (j==9 || j==10){
#		abline(v=max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-100,lty=3,lwd=3)
#		abline(v=max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-300,lty=3,lwd=3)
		segments(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-100,0,max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-100,100,lty=3,lwd=3)
		segments(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-300,0,max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-300,300,lty=3,lwd=3)
		
	}
	ValueToPrintXAxis <- round(mean(Data$V1*Ne[j]*2)+SD)
	
	AgesFile <- paste("../Results/AlleleAges/Ages",DemScenario[j],"_",SelectionTest[2],".txt",sep="")
	Data <- read.table(AgesFile)
	
	Breaks <- seq(from=0,to=max(Data$V1*Ne[j]*2+50),by=50)
	Histogram <- hist(Data$V1*2*Ne[j],breaks=Breaks,plot=FALSE)
	
	Color <- col2rgb("purple")
# lines(Max  - 0:99*50,Histogram$counts[1:100]/sum(Histogram$counts),col="purple",lwd=6)
	lines(rev(c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.22*(XLimFigureTwo[j]),density(Data$V1*Ne[j]*2,from=0,to=Max)$x[(MaxLength-Length):(MaxLength)])),density(Data$V1*Ne[j]*2,from=0,to=Max)$y[1:(Length+2)],col=ColorViridis[2],lwd=6)
	SD <- sd(Data$V1*Ne[j]*2)
	arrows(Max- mean(Data$V1*Ne[j]*2)-SD,-0.08*ListMaxAge[j],min(Max- mean(Data$V1*Ne[j]*2)+SD,Max),-0.08*ListMaxAge[j], length=0.05, angle=90, code=3,col=ColorViridis[2],lwd=6)
## X values 
	XFirstValue <- max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x) - 0.8*XLimFigureTwo[j]
	Threshold <- mean(Data$V1*Ne[j]*2) + SD-0.1*XLimFigureTwo[j]
	SubsetXValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$x,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
	SubsetYValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$y,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
	YValuesToPrint <- c(density(Data$V1*Ne[j]*2,from=0,to=Max)$y[length(density(Data$V1*Ne[j]*2,from=0,to=Max)$y) - length(SubsetYValues)],SubsetYValues)
	TransformedXValues <- SubsetXValues - Threshold
	XValuesToPrint <- c(XFirstValue,XFirstValue-TransformedXValues)
	
#	Check <- length(subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$x,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > (mean(Data$V1*Ne[j]*2)+SD - 0.1*XLimFigureTwo[j])))
#	StartingYValue <- length(density(Data$V1*Ne[j]*2,from=0,to=Max)$x) - Check
	
	lines(rev(c(XValuesToPrint)),YValuesToPrint,col=ColorViridis[2],lwd=6 )
#	abline(v=mean(Max - Data$V1*Ne[j]*2),lwd=6,col=ColorViridisAlpha[2])
	points(Max - mean(Data$V1*Ne[j]*2),-0.08*ListMaxAge[j],pch=20,col=ColorViridis[2],cex=3)
	
	AgesFile <- paste("../Results/AlleleAges/Ages",DemScenario[j],"_",SelectionTest[3],".txt",sep="")
	Data <- read.table(AgesFile)
	
	Breaks <- seq(from=0,to=max(Data$V1*Ne[j]*2+50),by=50)
	Histogram <- hist(Data$V1*2*Ne[j],breaks=Breaks,plot=FALSE)
	
	Color <- col2rgb("orange")
#lines(Max  - 0:99*50,Histogram$counts[1:100]/sum(Histogram$counts),col="orange",lwd=6)
	lines(rev(c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.22*(XLimFigureTwo[j]),density(Data$V1*Ne[j]*2,from=0,to=Max)$x[(MaxLength-Length):(MaxLength)])),density(Data$V1*Ne[j]*2,from=0,to=Max)$y[1:(Length+2)],col=ColorViridis[1],lwd=6)
	SD <- sd(Data$V1*Ne[j]*2)
	arrows(Max- mean(Data$V1*Ne[j]*2)-SD,-0.04*ListMaxAge[j],min(Max- mean(Data$V1*Ne[j]*2)+SD,Max),-0.04*ListMaxAge[j], length=0.05, angle=90, code=3,col=ColorViridis[1],lwd=6)
## X values 
	XFirstValue <- max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x) - 0.8*XLimFigureTwo[j]
	Threshold <- mean(Data$V1*Ne[j]*2) + SD-0.1*XLimFigureTwo[j]
	SubsetXValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$x,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
	SubsetYValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$y,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
	YValuesToPrint <- c(density(Data$V1*Ne[j]*2,from=0,to=Max)$y[length(density(Data$V1*Ne[j]*2,from=0,to=Max)$y) - length(SubsetYValues)],SubsetYValues)
	TransformedXValues <- SubsetXValues - Threshold
	XValuesToPrint <- c(XFirstValue,XFirstValue-TransformedXValues)
	
#	Check <- length(subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$x,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > (mean(Data$V1*Ne[j]*2)+SD - 0.1*XLimFigureTwo[j])))
#	StartingYValue <- length(density(Data$V1*Ne[j]*2,from=0,to=Max)$x) - Check
	
	lines(rev(c(XValuesToPrint)),YValuesToPrint,col=ColorViridis[1],lwd=6 )
	
#abline(v=mean(Max - Data$V1*Ne[j]*2),lwd=6,col=ColorViridisAlpha[1])
	points(Max - mean(Data$V1*Ne[j]*2),-0.04*ListMaxAge[j],pch=20,col=ColorViridis[1],cex=3)
	
	AgesFile <- paste("../Results/AlleleAges/Ages",DemScenario[j],"_",SelectionTest[4],".txt",sep="")
	Data <- read.table(AgesFile)
	
	Breaks <- seq(from=0,to=max(Data$V1*Ne[j]*2+50),by=50)
	Histogram <- hist(Data$V1*2*Ne[j],breaks=Breaks,plot=FALSE)
	
#lines(Max  - 0:99*50,Histogram$counts[1:100]/sum(Histogram$counts),col="red",lty=5,lwd=6)
	lines(rev(c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.22*(XLimFigureTwo[j]),density(Data$V1*Ne[j]*2,from=0,to=Max)$x[(MaxLength-Length):(MaxLength)])),density(Data$V1*Ne[j]*2,from=0,to=Max)$y[1:(Length+2)],lty=5,col=ColorViridis[4],lwd=6)
#abline(v=mean(Max - Data$V1*Ne[j]*2),lty=5,lwd=6,col=ColorViridisAlpha[4])
	SD <- sd(Data$V1*Ne[j]*2)
	arrows(Max- mean(Data$V1*Ne[j]*2)-SD,-0.16*ListMaxAge[j],min(Max- mean(Data$V1*Ne[j]*2)+SD,Max),-0.16*ListMaxAge[j], length=0.05, angle=90, code=3,col=ColorViridis[4],lwd=6)
## X values 
	XFirstValue <- max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x) - 0.8*XLimFigureTwo[j]
	Threshold <- mean(Data$V1*Ne[j]*2) + SD-0.1*XLimFigureTwo[j]
	SubsetXValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$x,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
	SubsetYValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$y,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
	YValuesToPrint <- c(density(Data$V1*Ne[j]*2,from=0,to=Max)$y[length(density(Data$V1*Ne[j]*2,from=0,to=Max)$y) - length(SubsetYValues)],SubsetYValues)
	TransformedXValues <- SubsetXValues - Threshold
	XValuesToPrint <- c(XFirstValue,XFirstValue-TransformedXValues)
	
#	Check <- length(subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$x,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > (mean(Data$V1*Ne[j]*2)+SD - 0.1*XLimFigureTwo[j])))
#	StartingYValue <- length(density(Data$V1*Ne[j]*2,from=0,to=Max)$x) - Check
	
	lines(rev(c(XValuesToPrint)),YValuesToPrint,col=ColorViridis[4],lwd=6 ,lty=5)
	
	points(Max - mean(Data$V1*Ne[j]*2),-0.16*ListMaxAge[j],pch=20,col=ColorViridis[4],cex=3)
	
	
	AgesFile <- paste("../Results/AlleleAges/Ages",DemScenario[j],"_",SelectionTest[5],".txt",sep="")
	Data <- read.table(AgesFile)
	Breaks <- seq(from=0,to=max(Data$V1*Ne[j]*2+50),by=50)
	Histogram <- hist(Data$V1*2*Ne[j],breaks=Breaks,plot=FALSE)
	
#lines(Max  - 0:99*50,Histogram$counts[1:100]/sum(Histogram$counts),col="dodgerblue",lty=5,lwd=6)
	lines(rev(c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.22*(XLimFigureTwo[j]),density(Data$V1*Ne[j]*2,from=0,to=Max)$x[(MaxLength-Length):(MaxLength)])),density(Data$V1*Ne[j]*2,from=0,to=Max)$y[1:(Length+2)],lty=5,col=ColorViridis[5],lwd=6)
	SD <- sd(Data$V1*Ne[j]*2)
	arrows(Max- mean(Data$V1*Ne[j]*2)-SD,-0.2*ListMaxAge[j],min(Max- mean(Data$V1*Ne[j]*2)+SD,Max),-0.2*ListMaxAge[j], length=0.05, angle=90, code=3,col=ColorViridis[5],lwd=6)
## X values 
	XFirstValue <- max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x) - 0.8*XLimFigureTwo[j]
	Threshold <- mean(Data$V1*Ne[j]*2) + SD-0.1*XLimFigureTwo[j]
	SubsetXValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$x,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
	SubsetYValues <- subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$y,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > Threshold)
	YValuesToPrint <- c(density(Data$V1*Ne[j]*2,from=0,to=Max)$y[length(density(Data$V1*Ne[j]*2,from=0,to=Max)$y) - length(SubsetYValues)],SubsetYValues)
	TransformedXValues <- SubsetXValues - Threshold
	XValuesToPrint <- c(XFirstValue,XFirstValue-TransformedXValues)
	
#	Check <- length(subset(density(Data$V1*Ne[j]*2,from=0,to=Max)$x,density(Data$V1*Ne[j]*2,from=0,to=Max)$x > (mean(Data$V1*Ne[j]*2)+SD - 0.1*XLimFigureTwo[j])))
#	StartingYValue <- length(density(Data$V1*Ne[j]*2,from=0,to=Max)$x) - Check
	
	lines(rev(c(XValuesToPrint)),YValuesToPrint,col=ColorViridis[5],lwd=6,lty=5 )
	
	points(Max - mean(Data$V1*Ne[j]*2),-0.2*ListMaxAge[j],pch=20,col=ColorViridis[5],cex=3)
	
#	legend("topleft",c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title="4Ns",bty="n")
#	XLimFigureTwo[1]=1500
#	XLimFigureTwo[2]=900
#	XLimFigureTwo[3]=3000
#	XLimFigureTwo[4]=2000
#	XLimFigureTwo[5]=1500
#	XLimFigureTwo[6]=900
#	XLimFigureTwo[7]=1750
#	XLimFigureTwo[8]=1000
#	XLimFigureTwo[9]=2000
#	XLimFigureTwo[10]=900
#	XLimFigureTwo[11]=3000
	if (XLimFigureTwo[j] <= 1000){
		axis(1,at=c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.1*(XLimFigureTwo[j]),Max-2000,Max-1000,Max),labels=c(ValueToPrintXAxis,"1000","500","Present"),cex.lab=2,cex.axis=2)
	}else if (XLimFigureTwo[j] <= 1500){
        axis(1,at=c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.1*(XLimFigureTwo[j]),Max-2000,Max-1000,Max),labels=c(ValueToPrintXAxis,"1000","500","Present"),cex.lab=2,cex.axis=2)
	}else if (XLimFigureTwo[j] <= 1750){
		axis(1,at=c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.1*(XLimFigureTwo[j]),Max-1000,Max-500,Max),labels=c(ValueToPrintXAxis,"1000","500","Present"),cex.lab=2,cex.axis=2)		
	}else if (XLimFigureTwo[j] <= 2000){
		axis(1,at=c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.1*(XLimFigureTwo[j]),Max-1500,Max-1000,Max-500,Max),labels=c(ValueToPrintXAxis,"1500","1000","500","Present"),cex.lab=2,cex.axis=2)		
	}else if (XLimFigureTwo[j] <= 3000){
		axis(1,at=c(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.1*(XLimFigureTwo[j]),Max-2000,Max-1500,Max-1000,Max-500,Max),labels=c(ValueToPrintXAxis,"2000","1500","1000","500","Present"),cex.lab=2,cex.axis=2)		
	}
#	axis(1,at=c(Max-2500,Max-2000,Max-1500,Max-1000,Max-500,Max),labels=c("2500","2000","1500","1000","500","Present"),cex.lab=2,cex.axis=2)
#	rect(max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j]+10,-0.02*ListMaxAge[j],max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j]+0.2*(XLimFigureTwo[j]),ListMaxAge[j],col="white",border=NA)
	AgesFile <- paste("../Results/TTwos/TPW",DemScenario[j],"_",SelectionTest[1],".txt",sep="")
	
	Data <- read.table(AgesFile)
	
	Color <- col2rgb("black")
	axis.break(1, max(density(Data$V1*Ne[j]*2,from=0,to=Max)$x)-XLimFigureTwo[j] + 0.2*(XLimFigureTwo[j]), style = "gap")
    par(mar=c(5,5,4,3) + 0.1)
	
	plot(Data$V1[XLimFigureThree[j]:1],Data$V3[1:XLimFigureThree[j]],xlab=expression(bold(T[2])),ylab="Probability",type="l",main=expression(bold(paste("C) ",T[2],sep=""))),ylim=c(-0.2*ListMaxT2[j],1.05*ListMaxT2[j]),xaxt="n",yaxt="n",cex.lab=2.5,cex.main=2.5,cex.axis=1.5,lwd=6,col=ColorViridis[3])
#,ylim=c(0,1.0)
	if (j==7 || j==8){
#		abline(v=Data$V1[XLimFigureThree[j]]-100,lty=3,lwd=3)
		segments(Data$V1[XLimFigureThree[j]]-100,0,Data$V1[XLimFigureThree[j]]-100,100,lty=3,lwd=3)
	}
	if (j==1 || j==2){
#		abline(v=Data$V1[XLimFigureThree[j]]-5000,lty=3,lwd=3)
#		abline(v=Data$V1[XLimFigureThree[j]]-5200,lty=3,lwd=3)
		segments(Data$V1[XLimFigureThree[j]]-5000,0,Data$V1[XLimFigureThree[j]]-5000,100,lty=3,lwd=3)
		segments(Data$V1[XLimFigureThree[j]]-5200,0,Data$V1[XLimFigureThree[j]]-5200,300,lty=3,lwd=3)
		
	}
	if (j==5 || j==6){
#		abline(v=Data$V1[XLimFigureThree[j]]-2000,lty=3,lwd=3)
#		abline(v=Data$V1[XLimFigureThree[j]]-2200,lty=3,lwd=3)
		segments(Data$V1[XLimFigureThree[j]]-2000,0,Data$V1[XLimFigureThree[j]]-2000,100,lty=3,lwd=3)
		segments(Data$V1[XLimFigureThree[j]]-2200,0,Data$V1[XLimFigureThree[j]]-2200,300,lty=3,lwd=3)
		
	}
	if (j==9 || j==10){
#		abline(v=Data$V1[XLimFigureThree[j]]-100,lty=3,lwd=3)
#		abline(v=Data$V1[XLimFigureThree[j]]-300,lty=3,lwd=3)
		segments(Data$V1[XLimFigureThree[j]]-100,0,Data$V1[XLimFigureThree[j]]-100,100,lty=3,lwd=3)
		segments(Data$V1[XLimFigureThree[j]]-300,0,Data$V1[XLimFigureThree[j]]-100,300,lty=3,lwd=3)
		
	}
	SD <- (sum(Data$V1*Data$V1*Data$V3) - sum(Data$V1*Data$V3)*sum(Data$V1*Data$V3))^(1/2)
	arrows(XLimFigureThree[j]- sum(Data$V1*Data$V3)-SD,-0.12*ListMaxT2[j],min(XLimFigureThree[j]- sum(Data$V1*Data$V3)+SD,XLimFigureThree[j]),-0.12*ListMaxT2[j], length=0.05, angle=90, code=3,col=ColorViridis[3],lwd=6)
	
	points(XLimFigureThree[j]- sum(Data$V1*Data$V3),-0.12*ListMaxT2[j],pch=20,col=ColorViridis[3],cex=3)
	
	AgesFile <- paste("../Results/TTwos/TPW",DemScenario[j],"_",SelectionTest[2],".txt",sep="")
	Data <- read.table(AgesFile)
	
	Color <- col2rgb("purple")
	lines(Data$V1[XLimFigureThree[j]:1],Data$V3[1:XLimFigureThree[j]],col=ColorViridis[2],lwd=6)
	SD <- (sum(Data$V1*Data$V1*Data$V3) - sum(Data$V1*Data$V3)*sum(Data$V1*Data$V3))^(1/2)
	arrows(XLimFigureThree[j]- sum(Data$V1*Data$V3)-SD,-0.08*ListMaxT2[j],min(XLimFigureThree[j]- sum(Data$V1*Data$V3)+SD,XLimFigureThree[j]),-0.08*ListMaxT2[j], length=0.05, angle=90, code=3,col=ColorViridis[2],lwd=6)
	points(XLimFigureThree[j]- sum(Data$V1*Data$V3),-0.08*ListMaxT2[j],pch=20,col=ColorViridis[2],cex=3)
	
	AgesFile <- paste("../Results/TTwos/TPW",DemScenario[j],"_",SelectionTest[3],".txt",sep="")
	Data <- read.table(AgesFile)
	
	Color <- col2rgb("orange")
	lines(Data$V1[XLimFigureThree[j]:1],Data$V3[1:XLimFigureThree[j]],col=ColorViridis[1],lwd=6)
	SD <- (sum(Data$V1*Data$V1*Data$V3) - sum(Data$V1*Data$V3)*sum(Data$V1*Data$V3))^(1/2)
	arrows(XLimFigureThree[j]- sum(Data$V1*Data$V3)-SD,-0.04*ListMaxT2[j],min(XLimFigureThree[j]- sum(Data$V1*Data$V3)+SD,XLimFigureThree[j]),-0.04*ListMaxT2[j], length=0.05, angle=90, code=3,col=ColorViridis[1],lwd=6)
	
	points(XLimFigureThree[j]- sum(Data$V1*Data$V3),-0.04*ListMaxT2[j],pch=20,col=ColorViridis[1],cex=3)
	
	AgesFile <- paste("../Results/TTwos/TPW",DemScenario[j],"_",SelectionTest[4],".txt",sep="")
	Data <- read.table(AgesFile)
	
	lines(Data$V1[XLimFigureThree[j]:1],Data$V3[1:XLimFigureThree[j]],col=ColorViridis[4],lty=5,lwd=6)
	SD <- (sum(Data$V1*Data$V1*Data$V3) - sum(Data$V1*Data$V3)*sum(Data$V1*Data$V3))^(1/2)
	arrows(XLimFigureThree[j]- sum(Data$V1*Data$V3)-SD,-0.16*ListMaxT2[j],min(XLimFigureThree[j]- sum(Data$V1*Data$V3)+SD,XLimFigureThree[j]),-0.16*ListMaxT2[j], length=0.05, angle=90, code=3,col=ColorViridis[4],lwd=6)
	points(XLimFigureThree[j]- sum(Data$V1*Data$V3),-0.16*ListMaxT2[j],pch=20,col=ColorViridis[4],cex=3)
	
	AgesFile <- paste("../Results/TTwos/TPW",DemScenario[j],"_",SelectionTest[5],".txt",sep="")
	Data <- read.table(AgesFile)
	
	lines(Data$V1[XLimFigureThree[j]:1],Data$V3[1:XLimFigureThree[j]],col=ColorViridis[5],lty=5,lwd=6)
	SD <- (sum(Data$V1*Data$V1*Data$V3) - sum(Data$V1*Data$V3)*sum(Data$V1*Data$V3))^(1/2)
	arrows(XLimFigureThree[j]- sum(Data$V1*Data$V3)-SD,-0.2*ListMaxT2[j],min(XLimFigureThree[j]- sum(Data$V1*Data$V3)+SD,XLimFigureThree[j]),-0.2*ListMaxT2[j], length=0.05, angle=90, code=3,col=ColorViridis[5],lwd=6)
	points(XLimFigureThree[j]- sum(Data$V1*Data$V3),-0.2*ListMaxT2[j],pch=20,col=ColorViridis[5],cex=3)
#legend("topleft",c("0","-50","-100","50","100"),pch=19,col=c("black","purple","orange","red","dodgerblue"),cex=1.5,title="4Ns",bty="n")
	axis(1,at=c(XLimFigureThree[j]-2800,XLimFigureThree[j]-2400,XLimFigureThree[j]-2000,XLimFigureThree[j]-1600,XLimFigureThree[j]-1200,XLimFigureThree[j]-800,XLimFigureThree[j]-400,XLimFigureThree[j]),labels=c("2800","2400","2000","1600","1200","800","400","Present"),cex.lab=2,cex.axis=2)
	axis(2,at=c(0,0.005,0.01,0.015,0.02,0.025,0.03,0.035,0.04),labels=c("0","0.005","0.01","0.015","0.02","0.025","0.03","0.035","0.04"),cex.lab=2,cex.axis=2)	
	
	if (j==3){
		
		Distribution4Ns0 <- read.table("../Results/InferenceOfSelection/SelectionNoRec_NewTable0_N10000.txt")
		Distribution4Ns5 <- read.table("../Results/InferenceOfSelection/SelectionNoRec_NewTable-5_N10000.txt")
		Distribution4Ns10 <- read.table("../Results/InferenceOfSelection/SelectionNoRec_NewTable-10_N10000.txt")
		Distribution4Ns50 <- read.table("../Results/InferenceOfSelection/SelectionNoRec_NewTable-50_N10000.txt")
		Distribution4Ns100 <- read.table("../Results/InferenceOfSelection/SelectionNoRec_NewTable-100_N10000.txt")
#		boxplot(Distribution4Ns0$V1,Distribution4Ns5$V1,Distribution4Ns10$V1,Distribution4Ns50$V1,Distribution4Ns100$V1,names=c("0","5","10","50","100"), main="D) Inference of selection",xlab="Actual 4Ns values",ylab="Estimated 4Ns values",ylim=c(0,150),cex.lab=2,cex.axis=2)
#		abline(a=0,b=0,lty=2)
#		abline(a=5,b=0,lty=2)
#		abline(a=10,b=0,lty=2)
#		abline(a=50,b=0,lty=2)
#		abline(a=100,b=0,lty=2)
		
	}
	
	if (j==7){
		
		
		DataMinus50 <- read.table("../Results/InferenceOfSelection/Selection-50_N10000.txt")
		Data0 <- read.table("../Results/InferenceOfSelection/Selection0_N10000.txt")
		DataPlus50 <- read.table("../Results/InferenceOfSelection/Selection50_N10000.txt")
#		boxplot(DataMinus50$V1-100,Data0$V1-100,DataPlus50$V1-100,names=c("-50","0","50"),ylab="Estimated 4Ns values",xlab="Real 4Ns values", main="D) Inference of selection",cex.lab=2,cex.names=2,cex.axis=2)
# "10,000 haplotype lenghts per point (100 points in total per 4Ns value)"
#		abline(h=-50,lty=2)
#		abline(h=0,lty=2)
#		abline(h=50,lty=2)
		
#	dev.off()
		
	}

par(mar=c(5,5,5,2) + 0.1)

DistributionOfL <- read.table("../Results/DistributionOfL/DistributionOfL.txt")
Max <- max(DistributionOfL)
Min <- min(DistributionOfL)
plot(1:6,DistributionOfL[1,], col=ColorViridis[3], type="l", lwd=6, ylim=c(Min,Max), ylab="Probability", xlab="L", cex.lab=2.5, cex.axis=2.5, xaxt="n", main="D) Probability Distribution of L", cex.main=2.5)
lines(1:6,DistributionOfL[2,],col=ColorViridis[2],lwd=6)
lines(1:6,DistributionOfL[3,],col=ColorViridis[1],lwd=6)
lines(1:6,DistributionOfL[4,],col=ColorViridis[4],lty=5,lwd=6)
lines(1:6,DistributionOfL[5,],col=ColorViridis[5],lty=5,lwd=6)
axis(1,at=c(1,2,3,4,5,6),labels=c(expression(w[1],w[2],w[3],w[4],w[5],w[6])),cex.lab=2.5,cex.axis=2.5)
legend("center",c("-100","-50","0","50","100"), lty=c(1,1,1,6,6),lwd=6,col=ColorViridis,cex=2,title=expression(paste(4,N,'s',sep="")),bty="n")

#,cex.lab=2.5,cex.main=2,cex.axis=2

par(mar=c(0,0,5,0) + 0.0)
#par(oma=c(0,0,0,0))

Image <- readJPEG("../PotentialPaperFigures/HaplotypeLengths/Slide1.jpg")
plot(0.5,0.5,xaxt="n",yaxt="n",xlim=c(0,1.290323),ylim=c(0,1),cex.main=2.5,main="E) The effect of\n selection on L")
#plot(0.5,0.5,xaxt="n",yaxt="n",xlim=c(0,1.333333),ylim=c(0,1),main="D) Selection and pairwise\nhaplotypic identity\n by state lengths (L)",cex.main=2.5)

rasterImage(Image,0.0,0.0,1.290323,1,bty="n")


dev.off()

}

