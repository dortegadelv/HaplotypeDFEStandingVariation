import sys, numpy

ValueOne=float(sys.argv[1])
ValueTwo=float(sys.argv[2])
ValueThree=float(sys.argv[3])
ValueFour=float(sys.argv[4])
ValueFive=float(sys.argv[5])
ValueSix=float(sys.argv[6])
ValueSeven=float(sys.argv[7])
ValueEight=float(sys.argv[8])
ExitFile=sys.argv[9]

FractionsOne=float(sys.argv[10])
FractionsTwo=float(sys.argv[11])
FractionsThree=float(sys.argv[12])
FractionsFour=float(sys.argv[13])
FractionsFive=float(sys.argv[14])
FractionsSix=float(sys.argv[15])
FractionsSeven=float(sys.argv[16])
FractionsEight=float(sys.argv[17])


file1 = open(ExitFile, "w")

Sum = ValueOne/(1. - FractionsOne) + ValueTwo/(1. - FractionsTwo) + ValueThree/(1. - FractionsThree) + ValueFour/(1. - FractionsFour) + ValueFive/(1. - FractionsFive) + ValueSix/(1. - FractionsSix) + ValueSeven/(1. - FractionsSeven) + ValueEight/(1. - FractionsEight)

NumberOne = ValueOne/(1. - FractionsOne) - ValueOne
NumberTwo = ValueTwo/(1. - FractionsTwo) - ValueTwo
NumberThree = ValueThree/(1. - FractionsThree) - ValueThree
NumberFour = ValueFour/(1. - FractionsFour) - ValueFour
NumberFive = ValueFive/(1. - FractionsFive) - ValueFive
NumberSix = ValueSix/(1. - FractionsSix) - ValueSix
NumberSeven = ValueSeven/(1. - FractionsSeven) - ValueSeven
NumberEight = ValueEight/(1. - FractionsEight) - ValueEight

Sum = ValueOne + ValueTwo + ValueThree + ValueFour + ValueFive + ValueSix + ValueSeven + ValueEight + NumberOne + NumberTwo + NumberThree + NumberFour + NumberFive + NumberSix + NumberSeven + NumberEight

print (str(NumberOne) + " " + str(NumberEight) + "\n")

Fractions = [ValueOne / Sum, ValueTwo / Sum, ValueThree / Sum, ValueFour / Sum , ValueFive / Sum , ValueSix / Sum, ValueSeven / Sum, ValueEight / Sum , NumberOne / Sum, NumberTwo / Sum, NumberThree / Sum, NumberFour / Sum , NumberFive / Sum , NumberSix / Sum, NumberSeven / Sum, NumberEight / Sum]

for i in range(275):
   Draws = numpy.random.multinomial(1, Fractions, size=1) 
   for j in range(16):
      if (Draws[0,j] == 1):
         file1.write(str(j+69) + "\n")


# print (numpy.random.multinomial(275, Fractions, size=1))
