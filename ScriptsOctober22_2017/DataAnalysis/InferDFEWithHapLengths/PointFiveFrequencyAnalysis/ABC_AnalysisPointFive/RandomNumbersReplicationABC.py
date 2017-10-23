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


RecRateFile = open ('../../../../../Data/LeftBpRecRatePerVariantPointFive.txt', 'r')
RecRatesMis = []
LowRecRatesMis = []
for line in RecRateFile:
   RecRatesMis.append(float(line) * .01)
   if float(line) < 1e-6:
      LowRecRatesMis.append(float(line) * .01)
print RecRatesMis[0]
print LowRecRatesMis[0]

RecRateFile = open ('../../../../../Data/RightBpRecRatePerVariantPointFive.txt', 'r')
RightRecRatesMis = []
RightLowRecRatesMis = []
for line in RecRateFile:
   RightRecRatesMis.append(float(line) * .01)
   if float(line) < 1e-6:
      RightLowRecRatesMis.append(float(line) * .01)
print RecRates[0]
print LowRecRates[0]


RandomNumbersFile = "../../../../../Results/ABCReplicationPointFive/LeftRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../../Results/ABCReplicationPointFive/LeftParameters" + str(Number) + ".txt"

RandFile = open (RandomNumbersFile, 'w')
ParsFile = open (ParamsFile, 'a')

RandomNumbersFile = "../../../../../Results/ABCReplicationPointFive/RightRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../../Results/ABCReplicationPointFive/RightParameters" + str(Number) + ".txt"

RandFileTwo = open (RandomNumbersFile, 'w')
ParsFileTwo = open (ParamsFile, 'w')

RandomNumbersFile = "../../../../../Results/ABCReplicationPointFive/LeftRandomNumbersMissense" + str(Number) + ".txt"
RandFileMissense = open (RandomNumbersFile, 'w')

RandomNumbersFile = "../../../../../Results/ABCReplicationPointFive/RightRandomNumbersMissense" + str(Number) + ".txt"
RandFileMissenseRight = open (RandomNumbersFile, 'w')

RandomNumbersFile = "../../../../../Results/ABCReplicationPointFive/LeftLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFile = open (RandomNumbersFile, 'w')

RandomNumbersFile = "../../../../../Results/ABCReplicationPointFive/RightLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFileTwo = open (RandomNumbersFile, 'w')

NeInitial  = random.random()* 999000
print "Ne Initial " + str(NeInitial)
NeInitial  = 790955
print "Ne Initial " + str(NeInitial)

NeTwo  = random.random()* 49500
NeTwo  = 2744

NeThree  = random.random()* (10000)
NeThree  = 14341

## In the Gravel paper, the divergence time is 23000 kya. In generations this is 23000/25 = 920. Transformed into the proper units this is: 920 *( 0.0000000236 / 1.5e-8) is aprox 1450
TimeOne = random.random()* 999
TimeOne = 409

TimeTwo = random.random()* (4000)
TimeTwo = 10434
## Previous 5726
String = str(MutationRate) + "\t" + str(NeInitial) + "\t" + str(NeTwo) + "\t" + str(NeThree) + "\t" + str(TimeOne) + "\t" + str(TimeTwo) + "\n"
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
   
   GensBot =  ( TimeTwo ) / (4.0*float(int (NeInitial)))
   FractionBot = NeThree / (float(int (NeInitial)))
   
   GensFive = ( (20000.0 )) / (4.0*float(int (NeInitial)))
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
for CurrentRecRate in RecRatesMis:
   Theta = 4.0 * float( int(NeInitial )) * MutationRate * BpNumber
   RecRateRegion = 4.0* float( NeInitial )* CurrentRecRate * BpNumber
   RightRecRateRegion = 4.0 * float( NeInitial )* RightRecRatesMis[CounterRightRecRates] * BpNumber
   GensOne = TimeOne / (4.0*float(int (NeInitial )))
   FractionOne = NeTwo / float(int (NeInitial ))

#   GensTwo = TimeTwo / (4.0*float(NeInitial))
#   FractionTwo = NeThree / (float(NeInitial))

   GensBot =  ( TimeTwo ) / (4.0*float(int (NeInitial)))
   FractionBot = NeThree / (float(int (NeInitial)))

   GensFive = ( (20000.0 )) / (4.0*float(int (NeInitial)))
   FractionFive = 12000 / (float(int (NeInitial )))

   String = str(Theta) + " " + str(RecRateRegion) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensBot) + " " + str(FractionBot) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandFileMissense.write(String)

   String = str(Theta) + " " + str(RightRecRateRegion) + " " + str(GensOne) + " " + str(FractionOne) + " " + str(GensBot) + " " + str(FractionBot) + " " + str(GensFive) + " " + str(FractionFive) + "\n"
   RandFileMissenseRight.write(String)
   CounterRightRecRates = CounterRightRecRates + 1
RandFileMissense.close()
RandFileMissenseRight.close()



CounterRightRecRates = 0


RandLowRecFile.close()
RandLowRecFileTwo.close()

ParamsFile = "../../../../../Results/ABCReplicationPointFive/PReFerSimParameters" + str(Number) + ".txt"
ParamsFileB = "../../../../../Results/ABCReplicationPointFive/PReFerSimParameters" + str(Number) + "_B.txt"

ABCParsFile = open (ParamsFile, 'w')
ABCParsFileB = open (ParamsFileB, 'w')

DemHist = "../../../../../Results/ABCReplicationPointFive/Output/ConstantSizeDemHist" + str(Number) + ".txt"
OutDir = "../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutput" + str(Number) + ".txt"
AllelesFile = "../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputAlleles"
TrajFile = "../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAlleles"

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
ABCParsFile.close()
ABCParsFileB.close()

Selection = 50.0 / float( 2.0 * int(2 * NeThree *Fraction+0.5))

ParamsFile = "../../../../../Results/ABCReplicationPointFive/PReFerSimParameters" + str(Number) + "_C.txt"
ParamsFileB = "../../../../../Results/ABCReplicationPointFive/PReFerSimParameters" + str(Number) + "_D.txt"

ABCParsFile = open (ParamsFile, 'w')
ABCParsFileB = open (ParamsFileB, 'w')

OutDir = "../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputSel" + str(Number) + ".txt"
AllelesFile = "../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputAllelesSel"
TrajFile = "../../../../../Results/ABCReplicationPointFive/Output/TrajOutputAllelesSel"

String = """MutationRate  100.0 
DFEType:        point
DFEPointSelectionCoefficient:    """ + str(Selection)  + """
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

OutDir = "../../../../../Results/ABCReplicationPointFive/Output/PReFerSimOutputSel" + str(Number) + ".txt"

String = """MutationRate  100.0 
DFEType:        point
DFEPointSelectionCoefficient:    """ + str(Selection)  + """
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

Ne = 2.0 * NeThree
String = String + str(int(Ne*Fraction+0.5)) + " " + str(int(( 20000 -TimeTwo) *Fraction + 0.5)) + "\n"

Ne = 2.0 * NeTwo
String = String + str(int(Ne*Fraction+0.5)) + " " + str(int ((TimeTwo - TimeOne)*Fraction + 0.5 )) + "\n"

# Ne = 2.0 * float(NeThree)
# String = String + str(int(Ne+0.5)) + "\n"

Ne = 2.0 * NeInitial
String = String + str(int(Ne*Fraction+0.5)) + " " + str( int(TimeOne*Fraction + 0.5)) + "\n"

DemHistFile.write(String)

ABCParsFile.close()
DemHistFile.close()
ABCParsFileB.close()

