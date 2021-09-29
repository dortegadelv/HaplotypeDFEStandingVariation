import sys , random , math

print sys.argv[1]
Number = int(sys.argv[1])
RandomSeed = int(sys.argv[2])
Fraction = float(sys.argv[3])
Ne = float(sys.argv[4])

### RandomNumbers
random.seed( RandomSeed )

BpNumber=250000
MutationRate = random.random() * 0.0
MutationRate = MutationRate + 0.000000015

RecRateFile = open ('../../../../Data/LeftBpRecRatePerVariantNoCpGSynonymous.txt', 'r')
RecRates = []
LowRecRates = []
for line in RecRateFile:
   RecRates.append(float(line) * .01)
   if float(line) < 1e-6:
      LowRecRates.append(float(line) * .01)
print RecRates[0]
print LowRecRates[0]

RecRateFile = open ('../../../../Data/RightBpRecRatePerVariantNoCpGSynonymous.txt', 'r')
RightRecRates = []
RightLowRecRates = []
for line in RecRateFile:
   RightRecRates.append(float(line) * .01)
   if float(line) < 1e-6:
      RightLowRecRates.append(float(line) * .01)
print RecRates[0]
print LowRecRates[0]


print "The length is " + str(len(RecRates))
print "The length is " + str(len(LowRecRates))

RandomNumbersFile = "../../../../Results/ABCAnalysis/LeftRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../Results/ABCAnalysis/LeftParameters" + str(Number) + ".txt"

RandFile = open (RandomNumbersFile, 'w')
ParsFile = open (ParamsFile, 'a')

RandomNumbersFile = "../../../../Results/ABCAnalysis/RightRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../Results/ABCAnalysis/RightParameters" + str(Number) + ".txt"

RandFileTwo = open (RandomNumbersFile, 'w')
ParsFileTwo = open (ParamsFile, 'w')

RandomNumbersFile = "../../../../Results/ABCAnalysis/LeftLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFile = open (RandomNumbersFile, 'w')

RandomNumbersFile = "../../../../Results/ABCAnalysis/RightLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFileTwo = open (RandomNumbersFile, 'w')

RandomNumbersFile = "../../../../Results/ABCAnalysis/LeftRandomNumbersZeroRec" + str(Number) + ".txt"
RandFileZeroRec = open (RandomNumbersFile, 'w')

RandomNumbersFile = "../../../../Results/ABCAnalysis/RightRandomNumbersZeroRec" + str(Number) + ".txt"
RandFileTwoZeroRec = open (RandomNumbersFile, 'w')


NeInitial  = random.random()* 999000
print "Ne Initial " + str(NeInitial)
NeInitial  = int( 484290 )
print "Ne Initial " + str(NeInitial)

NeTwo  = random.random()* 19500
NeTwo  = int ( 2715 )

NeThree  = random.random()* math.log10(490000)
NeThree  = int (math.pow(10, NeThree) + 10000 + 0.5)

TimeOne = random.random()* 1449
TimeOne = int ( 255 )

TimeTwo = random.random()* (1448 - TimeOne)
TimeTwo = int (TimeOne + TimeTwo + 1 + 0.5)

String = str(MutationRate) + "\t" + str(NeInitial) + "\t" + str(NeTwo) + "\t"+ str(TimeOne) + "\n"
ParsFile.write(String)

## Number of variants = 310
CounterRightRecRates = 0
for CurrentRecRate in RecRates:
   Theta = 4.0 * round(float(NeInitial) * .2 , 0 ) * MutationRate * BpNumber * 5
   RecRateRegion = 4.0* round( float(NeInitial) * .2 , 0)* CurrentRecRate * BpNumber * 5
   RightRecRateRegion = 4.0 * round( float( NeInitial) * .2 , 0) * RightRecRates[CounterRightRecRates] * BpNumber * 5
   
   GensOne =  ( round (float(TimeOne) * 0.2 , 0 )) / (4.0*float(round (float(NeInitial) * .2 , 0 )))
   FractionOne = ( round ( float(NeTwo)  * .2 , 0)) / float(round (float(NeInitial) * .2 , 0 ))
   
#   GensTwo = TimeTwo / (4.0*float(NeInitial))
#   FractionTwo = NeThree / (float(NeInitial))
   
   GensThree = (round(1450. * .2, 0 )) / (4.0*float(round ( float (NeInitial) * .2 , 0  )))
   FractionThree = ( round (2930. * .2, 0 )) / (float(round ( float (NeInitial) * .2 , 0 )))
   
   GensFour = ( round ( 3210. * .2 , 0 ) ) / (4.0*float(round ( float (NeInitial) * .2 , 0 )))
   FractionFour = ( round (22770. * .2 , 0)) / (float(round ( float (NeInitial) * .2  , 0)))
   
   GensFive = ( round (9315. * .2 , 0)) / (4.0*float(round ( float (NeInitial) * .2 , 0 )))
   FractionFive = ( round (11485. * .2 , 0 )) / (float(round ( float (NeInitial) * .2, 0)))
   
   String = str(Theta) + " " + str(RecRateRegion) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensThree) + " " + str(FractionThree) + " " + str(GensFour) + " " + str(FractionFour) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandFile.write(String)
   
   String = str(Theta) + " " + str(RightRecRateRegion) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensThree) + " " + str(FractionThree) + " " + str(GensFour) + " " + str(FractionFour) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandFileTwo.write(String)
   
   String = str(Theta) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensThree) + " " + str(FractionThree) + " " + str(GensFour) + " " + str(FractionFour) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandFileZeroRec.write(String)
   
   String = str(Theta) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensThree) + " " + str(FractionThree) + " " + str(GensFour) + " " + str(FractionFour) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandFileTwoZeroRec.write(String)
   
   CounterRightRecRates = CounterRightRecRates + 1
RandFile.close()
RandFileTwo.close()
ParsFile.close()
RandFileZeroRec.close()
RandFileTwoZeroRec.close()

CounterRightRecRates = 0

for CurrentRecRate in LowRecRates:
   Theta = 4.0 * float( int(NeInitial )) * MutationRate * BpNumber
   RecRateRegion = 4.0* float( NeInitial)* CurrentRecRate * BpNumber
   RightRecRateRegion = 4.0 * float( NeInitial )* RightLowRecRates[CounterRightRecRates] * BpNumber
   
   GensOne = TimeOne / (4.0*float(int (NeInitial)))
   FractionOne = NeTwo / float(int (NeInitial ))
   
#   GensTwo = TimeTwo / (4.0*float(NeInitial))
#   FractionTwo = NeThree / (float(NeInitial))
   
   GensThree = (int(1450)) / (4.0*float(int (NeInitial )))
   FractionThree = ( int (1861) * ( 0.0000000236 / MutationRate)) / (float(int (NeInitial )))
   
   GensFour = ( int ( 2040 ) * (0.0000000236 / MutationRate)) / (4.0*float(int (NeInitial )))
   FractionFour = ( int (14474 ) * ( 0.0000000236 / MutationRate)) / (float(int (NeInitial )))
   
   GensFive = ( int (5920 ) * ( 0.0000000236 / MutationRate)) / (4.0*float(int (NeInitial )))
   FractionFive = ( int (7300 ) * ( 0.0000000236 / MutationRate)) / (float(int (NeInitial )))
   
   String = str(Theta) + " " + str(RecRateRegion) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensThree) + " " + str(FractionThree) + " " + str(GensFour) + " " + str(FractionFour) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandLowRecFile.write(String)
   
   String = str(Theta) + " " + str(RightRecRateRegion) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensThree) + " " + str(FractionThree) + " " + str(GensFour) + " " + str(FractionFour) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandLowRecFileTwo.write(String)
   CounterRightRecRates = CounterRightRecRates + 1

RandLowRecFile.close()
RandLowRecFileTwo.close()

ParamsFile = "../../../../Results/ABCAnalysis/PReFerSimParameters" + str(Number) + ".txt"
ParamsFileB = "../../../../Results/ABCAnalysis/PReFerSimParameters" + str(Number) + "_B.txt"

ABCParsFile = open (ParamsFile, 'w')
ABCParsFileB = open (ParamsFileB, 'w')

DemHist = "../../../../Results/ABCAnalysis/Output/ConstantSizeDemHist" + str(Number) + ".txt"
OutDir = "../../../../Results/ABCAnalysis/Output/PReFerSimOutput" + str(Number) + ".txt"
AllelesFile = "../../../../Results/ABCAnalysis/Output/PReFerSimOutputAlleles"
TrajFile = "../../../../Results/ABCAnalysis/Output/TrajOutputAlleles"

DemHistFile = open (DemHist,'w')
String = """MutationRate  100.0 
DFEType: 	point
DFEPointSelectionCoefficient:	 0.0
DemographicHistory:         """ + DemHist + """
PrintSNPNumber:   0
PrintSumOfS: 0
PrintAverageDAF: 0
PrintWeightedSumOfS: 0
PrintGenLoad: 0
PrintFixedSites: 0
PrintSegSiteInfo: 1
PrintSampledGenotypes: 0
PrintSFS: 0
LastGenerationAFSamplingValue: 7242
FilePrefix: """ + OutDir + """
"""

ABCParsFile.write(String)

DemHistFile = open (DemHist,'w')
String = """MutationRate  100.0 
DFEType:        point
DFEPointSelectionCoefficient:    0.0
DemographicHistory:         """ + DemHist + """
PrintSNPNumber:   0
PrintSumOfS: 0
PrintAverageDAF: 0
PrintWeightedSumOfS: 0
PrintGenLoad: 0
PrintFixedSites: 0
PrintSegSiteInfo: 0
PrintSampledGenotypes: 0
PrintSFS: 0
LastGenerationAFSamplingValue: 7242
FilePrefix: """ + OutDir + """
AlleleTrajsInput: """ + AllelesFile + """
AlleleTrajsOutput: """ + TrajFile + """
"""

ABCParsFileB.write(String)

Ne = 2.0 * round(11485.*Fraction,0)
String = str(int(round(Ne,0))) + " " + str(int(22970 )) + "\n"

Ne = 2.0 * round(22770.*Fraction,0)
String = String + str(int(round(Ne,0))) + " " + str(int(1221)) + "\n"

Ne = 2.0 * round(2930.*Fraction,0)
String = String + str(int(round(Ne,0))) + " " + str(int(352)) + "\n"

# Ne = 2.0 * float(NeThree)
# String = String + str(int(Ne+0.5)) + "\n"

Ne = 2.0 * round(NeTwo*Fraction,0)
String = String + str(int(round(Ne,0))) + " " + str(int(round ((1450 - TimeOne)*Fraction,0 ))) + "\n"

Ne = 2.0 * round(NeInitial*Fraction,0)
String = String + str(int(round(Ne,0))) + " " + str( int(round(TimeOne*Fraction,0))) + "\n"

DemHistFile.write(String)

ABCParsFile.close()
DemHistFile.close()
ABCParsFileB.close()

