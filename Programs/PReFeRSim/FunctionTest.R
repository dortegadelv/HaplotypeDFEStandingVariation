setwd("/Users/vicentediegoortegadelvecchyo/Documents/DissertationThesis/PReFerSim/PRFSimulator/")

LineSFS <- c()
j=1
IntegrationInterval <- 100000
BurnInPopSize <- 20
for (g in 1:IntegrationInterval){
	FunctionValueToEvaluate = g /IntegrationInterval
	BinomialValue <- dbinom(j,20,FunctionValueToEvaluate)
	PointSel=0.005
	SFSFunctionTermOne = (1-exp(-2*BurnInPopSize*(-PointSel/2)*(1-FunctionValueToEvaluate)))/(1-exp(-2*BurnInPopSize*(-PointSel/2)));
	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
	CurrentTheoreticalSFSValue = SFSFunctionTermOne * SFSFunctionTermTwo * BinomialValue
	LineSFS <- c(LineSFS, CurrentTheoreticalSFSValue)
	}


setwd("/Users/vicentediegoortegadelvecchyo/Documents/DissertationThesis/PReFerSim/PRFSimulator/")

LineSFS <- c()
j=1
IntegrationInterval <- 20
BurnInPopSize <- 20
for (g in 1:IntegrationInterval){
	FunctionValueToEvaluate = g /IntegrationInterval
	BinomialValue <- dbinom(j,20,FunctionValueToEvaluate)
	PointSel=0.005
	SFSFunctionTermOne = (1-exp(-2*BurnInPopSize*(-PointSel/2)*(1-FunctionValueToEvaluate)))/(1-exp(-2*BurnInPopSize*(-PointSel/2)));
	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
	CurrentTheoreticalSFSValue = SFSFunctionTermOne * SFSFunctionTermTwo * BinomialValue
	LineSFS <- c(LineSFS, CurrentTheoreticalSFSValue)
}


LineSFS <- c()
j=1
IntegrationInterval <- 50000
BurnInPopSize <- 5000
SampleSize <- BurnInPopSize
PointSel <- -0.0002
Theta <- 4
Gamma <- 2*BurnInPopSize * PointSel
PartialSums <- c()
Theta <- 4
SFS <- c()
IntegralSums <- c()
for (j in 1:(SampleSize-1)){
IntegralSums[j] <- 0
	
}

for (g in 1:(IntegrationInterval-1)){
	FunctionValueToEvaluate = g /IntegrationInterval
	SFSFunctionTermOne = (1-exp(-2*Gamma*(1-FunctionValueToEvaluate)))/(1-exp(-2*Gamma));
	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
	for (j in 1:10){
	BinomialValue <- dbinom(j,SampleSize,FunctionValueToEvaluate)
	CurrentTheoreticalSFSValue <- SFSFunctionTermOne * SFSFunctionTermTwo * BinomialValue
	IntegralSums[j] <- IntegralSums[j] + (1.0 /IntegrationInterval) * CurrentTheoreticalSFSValue
	}
#	PartialSums <- c(PartialSums,(1.0 /IntegrationInterval) * CurrentTheoreticalSFSValue)
#	LineSFS <- c(LineSFS,CurrentTheoreticalSFSValue)
# print (CurrentTheoreticalSFSValue)
#	SFSFunctionTermOne = (exp(2*Gamma*(FunctionValueToEvaluate))- exp(2*Gamma))/(1-exp(2*Gamma))
#	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
#	CurrentTheoreticalSFSValue <- SFSFunctionTermOne * SFSFunctionTermTwo
}
IntegralSums[1:10]*Theta

#### Simpson rule


LineSFS <- c()
LowerParts <- c()
MiddleParts <- c()
UpperParts <- c()
j=1
IntegrationInterval <- 10000
BurnInPopSize <- 5000
SampleSize <- BurnInPopSize
PointSel <- -0.0002
Theta <- 4
Gamma <- 2*BurnInPopSize * PointSel
PartialSums <- c()
Theta <- 4
SFS <- c()
IntegralSums <- c()
for (j in 1:(SampleSize-1)){
	IntegralSums[j] <- 0
	
}

for (g in 1:(IntegrationInterval-1)){
	LowerPoint <- (g - 0.5) /IntegrationInterval
	UpperPoint <- (g + 0.5) /IntegrationInterval
	FirstTerm <- (UpperPoint - LowerPoint) / 6.0
	
	### Lower Parts
	FunctionValueToEvaluate = (g - 0.5) /IntegrationInterval

	SFSFunctionTermOne = (1-exp(-2*Gamma*(1-FunctionValueToEvaluate)))/(1-exp(-2*Gamma));
	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
	for (j in 1:10){
		BinomialValue <- dbinom(j,SampleSize,FunctionValueToEvaluate)
		CurrentTheoreticalSFSValue <- SFSFunctionTermOne * SFSFunctionTermTwo * BinomialValue
		LowerParts[j] <- CurrentTheoreticalSFSValue
	}

	### Middle Parts
	FunctionValueToEvaluate = (g) /IntegrationInterval
	
	SFSFunctionTermOne = (1-exp(-2*Gamma*(1-FunctionValueToEvaluate)))/(1-exp(-2*Gamma));
	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
	for (j in 1:10){
		BinomialValue <- dbinom(j,SampleSize,FunctionValueToEvaluate)
		CurrentTheoreticalSFSValue <- SFSFunctionTermOne * SFSFunctionTermTwo * BinomialValue
		MiddleParts[j] <- 4 * CurrentTheoreticalSFSValue
	}

	### Upper Parts
	FunctionValueToEvaluate = (g + 0.5) /IntegrationInterval
	
	SFSFunctionTermOne = (1-exp(-2*Gamma*(1-FunctionValueToEvaluate)))/(1-exp(-2*Gamma));
	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
	for (j in 1:10){
		BinomialValue <- dbinom(j,SampleSize,FunctionValueToEvaluate)
		CurrentTheoreticalSFSValue <- SFSFunctionTermOne * SFSFunctionTermTwo * BinomialValue
		UpperParts[j] <- CurrentTheoreticalSFSValue
	}
	
	### Integral
	for (j in 1:10){
	IntegralSums[j] <- IntegralSums[j] + FirstTerm* (LowerParts[j] + MiddleParts[j] + UpperParts[j])
	}
#	PartialSums <- c(PartialSums,(1.0 /IntegrationInterval) * CurrentTheoreticalSFSValue)
#	LineSFS <- c(LineSFS,CurrentTheoreticalSFSValue)
# print (CurrentTheoreticalSFSValue)
#	SFSFunctionTermOne = (exp(2*Gamma*(FunctionValueToEvaluate))- exp(2*Gamma))/(1-exp(2*Gamma))
#	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
#	CurrentTheoreticalSFSValue <- SFSFunctionTermOne * SFSFunctionTermTwo
}
IntegralSums[1:10]*Theta




LineSFS <- c()
LowerParts <- c()
MiddleParts <- c()
UpperParts <- c()
j=1
IntegrationInterval <- 50000
BurnInPopSize <- 5000
SampleSize <- BurnInPopSize
PointSel <- -0.002
Gamma <- 2*BurnInPopSize * PointSel
PartialSums <- c()
Theta <- 40
SFS <- c()
IntegralSums <- c()
for (j in 1:(SampleSize-1)){
	IntegralSums[j] <- 0
	
}

for (g in 1:(IntegrationInterval-1)){
	LowerPoint <- (g - 0.5) /IntegrationInterval
	UpperPoint <- (g + 0.5) /IntegrationInterval
	FirstTerm <- (UpperPoint - LowerPoint) / 6.0
	
### Lower Parts
	FunctionValueToEvaluate = (g - 0.5) /IntegrationInterval
	
	SFSFunctionTermOne = (1-exp(-2*Gamma*(1-FunctionValueToEvaluate)))/(1-exp(-2*Gamma));
	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
	for (j in 1:10){
		BinomialValue <- dbinom(j,SampleSize,FunctionValueToEvaluate)
		CurrentTheoreticalSFSValue <- SFSFunctionTermOne * SFSFunctionTermTwo * BinomialValue
		LowerParts[j] <- CurrentTheoreticalSFSValue
	}
	
### Middle Parts
	FunctionValueToEvaluate = (g) /IntegrationInterval
	
	SFSFunctionTermOne = (1-exp(-2*Gamma*(1-FunctionValueToEvaluate)))/(1-exp(-2*Gamma));
	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
	for (j in 1:10){
		BinomialValue <- dbinom(j,SampleSize,FunctionValueToEvaluate)
		CurrentTheoreticalSFSValue <- SFSFunctionTermOne * SFSFunctionTermTwo * BinomialValue
		MiddleParts[j] <- 4 * CurrentTheoreticalSFSValue
	}
	
### Upper Parts
	FunctionValueToEvaluate = (g + 0.5) /IntegrationInterval
	
	SFSFunctionTermOne = (1-exp(-2*Gamma*(1-FunctionValueToEvaluate)))/(1-exp(-2*Gamma));
	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
	for (j in 1:10){
		BinomialValue <- dbinom(j,SampleSize,FunctionValueToEvaluate)
		CurrentTheoreticalSFSValue <- SFSFunctionTermOne * SFSFunctionTermTwo * BinomialValue
		UpperParts[j] <- CurrentTheoreticalSFSValue
	}
	
### Integral
	for (j in 1:10){
		IntegralSums[j] <- IntegralSums[j] + FirstTerm* (LowerParts[j] + MiddleParts[j] + UpperParts[j])
	}
#	PartialSums <- c(PartialSums,(1.0 /IntegrationInterval) * CurrentTheoreticalSFSValue)
#	LineSFS <- c(LineSFS,CurrentTheoreticalSFSValue)
# print (CurrentTheoreticalSFSValue)
#	SFSFunctionTermOne = (exp(2*Gamma*(FunctionValueToEvaluate))- exp(2*Gamma))/(1-exp(2*Gamma))
#	SFSFunctionTermTwo = (1/(FunctionValueToEvaluate*(1-FunctionValueToEvaluate)))
#	CurrentTheoreticalSFSValue <- SFSFunctionTermOne * SFSFunctionTermTwo
}
IntegralSums[1:10]*Theta



