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

RandomNumbersFile = "../../../../Results/ABCAnalysisPopExpansion/LeftRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../Results/ABCAnalysisPopExpansion/LeftParameters" + str(Number) + ".txt"

RandFile = open (RandomNumbersFile, 'w')
ParsFile = open (ParamsFile, 'a')

RandomNumbersFile = "../../../../Results/ABCAnalysisPopExpansion/RightRandomNumbers" + str(Number) + ".txt"
ParamsFile = "../../../../Results/ABCAnalysisPopExpansion/RightParameters" + str(Number) + ".txt"

RandFileTwo = open (RandomNumbersFile, 'w')
ParsFileTwo = open (ParamsFile, 'w')

RandomNumbersFile = "../../../../Results/ABCAnalysisPopExpansion/LeftLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFile = open (RandomNumbersFile, 'w')

RandomNumbersFile = "../../../../Results/ABCAnalysisPopExpansion/RightLowRecRandomNumbers" + str(Number) + ".txt"
RandLowRecFileTwo = open (RandomNumbersFile, 'w')

NeInitial  = random.random()* 90000
print "Ne Initial " + str(NeInitial)
NeInitial  = int(NeInitial + 10000 + 0.5)
print "Ne Initial " + str(NeInitial)
NePast = random.random() * 9000
NePast = int( NePast + 1000 + 0.5 )
Time = random.random()* 500
Time = int(Time + 0.5)
TimeFraction = float( int(Time) / ( 4.0 * NeInitial))
PopFraction = float ( int (NePast) / ( 1.0 *  NeInitial))

String = str(NeInitial) + "\t" + str(NePast) + "\t" + str (Time) + "\n"
ParsFile.write(String)

## Number of variants = 310
Theta = 4.0 * float( int(NeInitial )) * MutationRate * BpNumber
Rho = 4.0 * float( int(NeInitial )) * RhoRate * BpNumber


for x in range(150):   
   String = str(Theta) + "\t"+ str(Rho) + "\t" + str(TimeFraction) + "\t" + str(PopFraction) + "\n"
   RandFile.write(String)   
   String = str(Theta) + "\t"+ str(Rho) + "\t" + str(TimeFraction) + "\t" + str(PopFraction) + "\n"
   RandFileTwo.write(String)
RandFile.close()
RandFileTwo.close()
ParsFile.close()

Theta = 4.0 * float( int(NeInitial )) * MutationRate * BpNumber
Rho = 4.0 * float( int(NeInitial )) * RhoRate * BpNumber

for x in range(150):
   String = str(Theta) + "\t"+ str(Rho) + "\t" + str(TimeFraction) + "\t" + str(PopFraction) + "\n"
   RandLowRecFile.write(String)
   String = str(Theta) + "\t"+ str(Rho) + "\t" + str(TimeFraction) + "\t" + str(PopFraction) + "\n"
   RandLowRecFileTwo.write(String)

RandLowRecFile.close()
RandLowRecFileTwo.close()

ParamsFile = "../../../../Results/ABCAnalysisPopExpansion/PReFerSimParameters" + str(Number) + ".txt"
ParamsFileB = "../../../../Results/ABCAnalysisPopExpansion/PReFerSimParameters" + str(Number) + "_B.txt"

ABCParsFile = open (ParamsFile, 'w')
ABCParsFileB = open (ParamsFileB, 'w')

DemHist = "../../../../Results/ABCAnalysisPopExpansion/Output/ConstantSizeDemHist" + str(Number) + ".txt"
OutDir = "../../../../Results/ABCAnalysisPopExpansion/Output/PReFerSimOutput" + str(Number) + ".txt"
AllelesFile = "../../../../Results/ABCAnalysisPopExpansion/Output/PReFerSimOutputAlleles"
TrajFile = "../../../../Results/ABCAnalysisPopExpansion/Output/TrajOutputAlleles"

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
String = str(int( 2.0 * NePast *Fraction+0.5)) + " " + str(int((NePast * 10)*Fraction+0.5)) + "\n"
String = String + str(int(2.0 * NeInitial*Fraction+0.5)) + " " + str(int((Time )*Fraction+0.5)) + "\n"


DemHistFile.write(String)

ABCParsFile.close()
DemHistFile.close()
ABCParsFileB.close()

