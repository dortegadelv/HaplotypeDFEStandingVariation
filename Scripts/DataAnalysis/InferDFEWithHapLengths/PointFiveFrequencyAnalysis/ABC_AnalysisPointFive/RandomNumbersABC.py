import sys , random , math

print sys.argv[1]
Number = int(sys.argv[1])
RandomSeed = int(sys.argv[2])
Fraction = float(sys.argv[3])

### RandomNumbers
random.seed( RandomSeed )

BpNumber=250000
MutationRate = random.random() * 0.0
MutationRate = MutationRate + 0.000000015

RecRateFile = open ('../../../../../Data/LeftBpRecRatePerVariantSynonymousPointFive.txt', 'r')
RecRates = []
LowRecRates = []
for line in RecRateFile:
   RecRates.append(float(line) * .01)
   if float(line) < 1e-6:
      LowRecRates.append(float(line) * .01)
print RecRates[0]
print LowRecRates[0]

RecRateFile = open ('../../../../../Data/RightBpRecRatePerVariantSynonymousPointFive.txt', 'r')
RightRecRates = []
RightLowRecRates = []
for line in RecRateFile:
   RightRecRates.append(float(line) * .01)
   if float(line) < 1e-6:
      RightLowRecRates.append(float(line) * .01)
print RecRates[0]
print LowRecRates[0]


print "The length is " + str(len(RecRates))
print "The length is " + str(len(RightRecRates))

RandomNumbersFile = "../../../../../Results/ABCAnalysisPointFive/LeftRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../../Results/ABCAnalysisPointFive/LeftParameters" + str(Number) + ".txt"

RandFile = open (RandomNumbersFile, 'w')
ParsFile = open (ParamsFile, 'a')

RandomNumbersFile = "../../../../../Results/ABCAnalysisPointFive/RightRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../../Results/ABCAnalysisPointFive/RightParameters" + str(Number) + ".txt"

RandFileTwo = open (RandomNumbersFile, 'w')
ParsFileTwo = open (ParamsFile, 'w')

RandomNumbersFile = "../../../../../Results/ABCAnalysisPointFive/LeftLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFile = open (RandomNumbersFile, 'w')

RandomNumbersFile = "../../../../../Results/ABCAnalysisPointFive/RightLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFileTwo = open (RandomNumbersFile, 'w')

NeInitial  = random.random()* 800000
print "Ne Initial " + str(NeInitial)
NeInitial  = int(NeInitial + 200000 + 0.5)
print "Ne Initial " + str(NeInitial)

NeTwo  = random.random()* 2
NeTwo  = int ( 10**(3 + NeTwo) + 0.5)

NeThree  = random.random()* 2
NeThree  = int ( 10**( 3 + NeThree) + 0.5 )

## In the Gravel paper, the divergence time is 23000 kya. In generations this is 23000/25 = 920. Transformed into the proper units this is: 920 *( 0.0000000236 / 1.5e-8) is aprox 1450
TimeOne = random.random()* 699
TimeOne = int (TimeOne + 0.5)

TimeTwo = random.random()* (19299)
TimeTwo = int (TimeOne + TimeTwo + 1 + 0.5)

String = str(MutationRate) + "\t" + str(NeInitial) + "\t" + str(NeTwo) + "\t" + str(NeThree) + "\t" + str(TimeOne) + "\t" + str(TimeTwo)  + "\n"
ParsFile.write(String)

## Number of variants = 310
CounterRightRecRates = 0
for CurrentRecRate in RecRates:
   Theta = 4.0 * float( int(NeInitial )) * MutationRate * BpNumber
   RecRateRegion = 4.0* float( NeInitial )* CurrentRecRate * BpNumber
   RightRecRateRegion = 4.0 * float( NeInitial )* RightRecRates[CounterRightRecRates] * BpNumber
   GensOne = TimeOne / (4.0*float(int (NeInitial )))
   FractionOne = NeTwo / float(int (NeInitial ))
   
#   GensTwo = TimeTwo / (4.0*float(NeInitial))
#   FractionTwo = NeThree / (float(NeInitial))
      
   GensBot = TimeTwo / (4.0*float(int (NeInitial )))
   FractionBot =  NeThree / (float(int (NeInitial )))

   GensFive = ( (20000)) / (4.0*float(int (NeInitial)))
   FractionFive = 12000 / (float(int (NeInitial )))
   
   String = str(Theta) + " " + str(RecRateRegion) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensBot) + " " + str(FractionBot) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandFile.write(String)
   
   String = str(Theta) + " " + str(RightRecRateRegion) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensBot) + " " + str(FractionBot) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandFileTwo.write(String)
   CounterRightRecRates = CounterRightRecRates + 1
RandFile.close()
RandFileTwo.close()
ParsFile.close()

CounterRightRecRates = 0


RandLowRecFile.close()
RandLowRecFileTwo.close()

ParamsFile = "../../../../../Results/ABCAnalysisPointFive/PReFerSimParameters" + str(Number) + ".txt"
ParamsFileB = "../../../../../Results/ABCAnalysisPointFive/PReFerSimParameters" + str(Number) + "_B.txt"

ABCParsFile = open (ParamsFile, 'w')
ABCParsFileB = open (ParamsFileB, 'w')

DemHist = "../../../../../Results/ABCAnalysisPointFive/Output/ConstantSizeDemHist" + str(Number) + ".txt"
OutDir = "../../../../../Results/ABCAnalysisPointFive/Output/PReFerSimOutput" + str(Number) + ".txt"
AllelesFile = "../../../../../Results/ABCAnalysisPointFive/Output/PReFerSimOutputAlleles"
TrajFile = "../../../../../Results/ABCAnalysisPointFive/Output/TrajOutputAlleles"

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


Ne = 2.0 * 12000
String = str(int(Ne*Fraction+0.5)) + " " + str(int((Ne * 3)*Fraction +0.5)) + "\n"

# Ne = 2.0 * float(NeThree)
# String = String + str(int(Ne+0.5)) + "\n"

Ne = 2.0 * NeThree
String = String + str(int(Ne*Fraction+0.5)) + " " + str(int ((20000  - TimeTwo)*Fraction + 0.5 )) + "\n"

Ne = 2.0 * NeTwo
String = String + str(int(Ne*Fraction+0.5)) + " " + str(int ((TimeTwo - TimeOne)*Fraction + 0.5 )) + "\n"

Ne = 2.0 * NeInitial
String = String + str(int(Ne*Fraction+0.5)) + " " + str( int(TimeOne*Fraction + 0.5)) + "\n"

DemHistFile.write(String)

ABCParsFile.close()
DemHistFile.close()
ABCParsFileB.close()

