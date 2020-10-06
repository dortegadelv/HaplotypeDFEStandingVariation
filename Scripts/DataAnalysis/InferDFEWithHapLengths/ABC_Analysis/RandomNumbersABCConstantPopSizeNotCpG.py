import sys , random , math

print sys.argv[1]
Number = int(sys.argv[1])
RandomSeed = int(sys.argv[2])
Fraction = float(sys.argv[3])

### RandomNumbers
random.seed( RandomSeed )

BpNumber = 500000
MutationRate = 0.000000012
RhoRate = 0.00000001

RandomNumbersFile = "../../../../Results/ABCAnalysisConstantPopSize/LeftRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../Results/ABCAnalysisConstantPopSize/LeftParameters" + str(Number) + ".txt"

RandFile = open (RandomNumbersFile, 'w')
ParsFile = open (ParamsFile, 'a')

RandomNumbersFile = "../../../../Results/ABCAnalysisConstantPopSize/RightRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../Results/ABCAnalysisConstantPopSize/RightParameters" + str(Number) + ".txt"

RandFileTwo = open (RandomNumbersFile, 'w')
ParsFileTwo = open (ParamsFile, 'w')

RandomNumbersFile = "../../../../Results/ABCAnalysisConstantPopSize/LeftLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFile = open (RandomNumbersFile, 'w')

RandomNumbersFile = "../../../../Results/ABCAnalysisConstantPopSize/RightLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFileTwo = open (RandomNumbersFile, 'w')

NeInitial  = random.random()* 19000
print "Ne Initial " + str(NeInitial)
NeInitial  = int(NeInitial + 1000 + 0.5)
print "Ne Initial " + str(NeInitial)

String = str(NeInitial) + "\n"
ParsFile.write(String)

## Number of variants = 310
Theta = 4.0 * float( int(NeInitial )) * MutationRate * BpNumber
Rho = 4.0 * float( int(NeInitial )) * RhoRate * BpNumber

for x in range(150):   
   String = str(Theta) + "\t"+ str(Rho) + "\n"
   RandFile.write(String)
   String = str(Theta) + "\t"+ str(Rho) + "\n"
   RandFileTwo.write(String)

RandFile.close()
RandFileTwo.close()
ParsFile.close()

Theta = 4.0 * float( int(NeInitial )) * MutationRate * BpNumber
Rho = 4.0 * float( int(NeInitial )) * RhoRate * BpNumber

for x in range(150):
   String = str(Theta) + "\t"+ str(Rho) + "\n"
   RandLowRecFile.write(String)
   String = str(Theta) + "\t"+ str(Rho) + "\n"
   RandLowRecFileTwo.write(String)

RandLowRecFile.close()
RandLowRecFileTwo.close()

ParamsFile = "../../../../Results/ABCAnalysisConstantPopSize/PReFerSimParameters" + str(Number) + ".txt"
ParamsFileB = "../../../../Results/ABCAnalysisConstantPopSize/PReFerSimParameters" + str(Number) + "_B.txt"

ABCParsFile = open (ParamsFile, 'w')
ABCParsFileB = open (ParamsFileB, 'w')

DemHist = "../../../../Results/ABCAnalysisConstantPopSize/Output/ConstantSizeDemHist" + str(Number) + ".txt"
OutDir = "../../../../Results/ABCAnalysisConstantPopSize/Output/PReFerSimOutput" + str(Number) + ".txt"
AllelesFile = "../../../../Results/ABCAnalysisConstantPopSize/Output/PReFerSimOutputAlleles"
TrajFile = "../../../../Results/ABCAnalysisConstantPopSize/Output/TrajOutputAlleles"

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
LastGenerationAFSamplingValue: 4000
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
LastGenerationAFSamplingValue: 4000
FilePrefix: """ + OutDir + """
AlleleTrajsInput: """ + AllelesFile + """
AlleleTrajsOutput: """ + TrajFile + """
"""

ABCParsFileB.write(String)


Ne = 2.0 * NeInitial
String = str(int(Ne*Fraction+0.5)) + " " + str(int((Ne * 5)*Fraction+0.5)) + "\n"


DemHistFile.write(String)

ABCParsFile.close()
DemHistFile.close()
ABCParsFileB.close()

