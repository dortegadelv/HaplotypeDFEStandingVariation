import sys , random , math

print sys.argv[1]
Number = int(sys.argv[1])
RandomSeed = int(sys.argv[2])
Fraction = float(sys.argv[3])

### RandomNumbers
random.seed( RandomSeed )

BpNumber=250000
MutationRate = random.random() * 0.0000000225
MutationRate = 1.5e-08

RecRateFile = open ('../../../../Data/LeftBpRecRatePerVariantSynonymous.txt', 'r')
RecRates = []
LowRecRates = []
for line in RecRateFile:
   RecRates.append(float(line) * .01)
   if float(line) < 1e-6:
      LowRecRates.append(float(line) * .01)
print RecRates[0]
print LowRecRates[0]

RecRateFile = open ('../../../../Data/RightBpRecRatePerVariantSynonymous.txt', 'r')
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

RandomNumbersFile = "../../../../Results/ABCReplication/LeftRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../Results/ABCReplication/LeftParameters" + str(Number) + ".txt"

RandFile = open (RandomNumbersFile, 'w')
ParsFile = open (ParamsFile, 'a')

RandomNumbersFile = "../../../../Results/ABCReplication/RightRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../Results/ABCReplication/RightParameters" + str(Number) + ".txt"

RandFileTwo = open (RandomNumbersFile, 'w')
ParsFileTwo = open (ParamsFile, 'w')

RandomNumbersFile = "../../../../Results/ABCReplication/LeftLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFile = open (RandomNumbersFile, 'w')

RandomNumbersFile = "../../../../Results/ABCReplication/RightLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFileTwo = open (RandomNumbersFile, 'w')

NeInitial  = random.random()* 999000
print "Ne Initial " + str(NeInitial)
NeInitial  = int( 551894 )
print "Ne Initial " + str(NeInitial)

NeTwo  = random.random()* 49500
NeTwo  = int ( 6685 )

NeThree  = random.random()* math.log10(490000)
NeThree  = int (math.pow(10, NeThree) + 10000 + 0.5)

TimeOne = random.random()* 919
TimeOne = int ( 303 )

TimeTwo = random.random()* (918 - TimeOne)
TimeTwo = int (TimeOne + TimeTwo + 1 + 0.5)

String = str(MutationRate) + "\t" + str(NeInitial) + "\t" + str(NeTwo) + "\t"+ str(TimeOne) + "\n"
ParsFile.write(String)

## Number of variants = 310
CounterRightRecRates = 0
for CurrentRecRate in RecRates:
   Theta = 4.0 * float( int(NeInitial )) * MutationRate * BpNumber
   RecRateRegion = 4.0* float( NeInitial)* CurrentRecRate * BpNumber
   RightRecRateRegion = 4.0 * float( NeInitial )* RightRecRates[CounterRightRecRates] * BpNumber
   
   GensOne = TimeOne / (4.0*float(int (NeInitial)))
   FractionOne = NeTwo / float(int (NeInitial ))
   
#   GensTwo = TimeTwo / (4.0*float(NeInitial))
#   FractionTwo = NeThree / (float(NeInitial))
   
   GensThree = (int(920) * ( 0.0000000236 / MutationRate)) / (4.0*float(int (NeInitial )))
   FractionThree = ( int (1861) * ( 0.0000000236 / MutationRate)) / (float(int (NeInitial )))
   
   GensFour = ( int ( 2040 ) * (0.0000000236 / MutationRate)) / (4.0*float(int (NeInitial )))
   FractionFour = ( int (14474 ) * ( 0.0000000236 / MutationRate)) / (float(int (NeInitial )))
   
   GensFive = ( int (5920 ) * ( 0.0000000236 / MutationRate)) / (4.0*float(int (NeInitial )))
   FractionFive = ( int (7300 ) * ( 0.0000000236 / MutationRate)) / (float(int (NeInitial )))
   
   String = str(Theta) + " " + str(RecRateRegion) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensThree) + " " + str(FractionThree) + " " + str(GensFour) + " " + str(FractionFour) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandFile.write(String)
   
   String = str(Theta) + " " + str(RightRecRateRegion) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensThree) + " " + str(FractionThree) + " " + str(GensFour) + " " + str(FractionFour) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandFileTwo.write(String)
   CounterRightRecRates = CounterRightRecRates + 1
RandFile.close()
RandFileTwo.close()
ParsFile.close()

CounterRightRecRates = 0

for CurrentRecRate in LowRecRates:
   Theta = 4.0 * float( int(NeInitial )) * MutationRate * BpNumber
   RecRateRegion = 4.0* float( NeInitial)* CurrentRecRate * BpNumber
   RightRecRateRegion = 4.0 * float( NeInitial )* RightLowRecRates[CounterRightRecRates] * BpNumber
   
   GensOne = TimeOne / (4.0*float(int (NeInitial)))
   FractionOne = NeTwo / float(int (NeInitial ))
   
#   GensTwo = TimeTwo / (4.0*float(NeInitial))
#   FractionTwo = NeThree / (float(NeInitial))
   
#   GensThree = (int(920) * ( 0.0000000236 / MutationRate)) / (4.0*float(int (NeInitial )))
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

ParamsFile = "../../../../Results/ABCReplication/PReFerSimParameters" + str(Number) + ".txt"
ParamsFileB = "../../../../Results/ABCReplication/PReFerSimParameters" + str(Number) + "_B.txt"

ABCParsFile = open (ParamsFile, 'w')
ABCParsFileB = open (ParamsFileB, 'w')

DemHist = "../../../../Results/ABCReplication/Output/ConstantSizeDemHist" + str(Number) + ".txt"
OutDir = "../../../../Results/ABCReplication/Output/PReFerSimOutput" + str(Number) + ".txt"
AllelesFile = "../../../../Results/ABCReplication/Output/PReFerSimOutputAlleles"
TrajFile = "../../../../Results/ABCReplication/Output/TrajOutputAlleles"

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


Ne = 2.0 * 7300 * 0.0000000236/ MutationRate
String = str(int(Ne*Fraction+0.5)) + " " + str(int((Ne * 5)*Fraction+0.5)) + "\n"

Ne = 2.0 * 14474 * 0.0000000236/ MutationRate
String = String + str(int(Ne*Fraction+0.5)) + " " + str(int(3880*Fraction * ( 0.0000000236 / MutationRate) +0.5)) + "\n"

Ne = 2.0 * 1861 * 0.0000000236/ MutationRate
String = String + str(int(Ne*Fraction+0.5)) + " " + str(int(1120*Fraction * ( 0.0000000236 / MutationRate) +0.5)) + "\n"

# Ne = 2.0 * float(NeThree)
# String = String + str(int(Ne+0.5)) + "\n"

Ne = 2.0 * NeTwo
String = String + str(int(Ne*Fraction+0.5)) + " " + str(int ((1450 - TimeOne)*Fraction + 0.5 )) + "\n"

Ne = 2.0 * NeInitial
String = String + str(int(Ne*Fraction+0.5)) + " " + str( int(TimeOne*Fraction + 0.5)) + "\n"

DemHistFile.write(String)

ABCParsFile.close()
DemHistFile.close()
ABCParsFileB.close()

