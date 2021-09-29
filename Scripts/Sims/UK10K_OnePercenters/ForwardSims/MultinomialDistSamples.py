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

file1 = open(ExitFile, "w")

Sum = ValueOne + ValueTwo + ValueThree + ValueFour + ValueFive + ValueSix + ValueSeven + ValueEight

Fractions = [ValueOne / Sum, ValueTwo / Sum, ValueThree / Sum, ValueFour / Sum , ValueFive / Sum , ValueSix / Sum, ValueSeven / Sum, ValueEight / Sum]

for i in range(275):
   Draws = numpy.random.multinomial(1, Fractions, size=1) 
   for j in range(8):
      if (Draws[0,j] == 1):
         file1.write(str(j+69) + "\n")


# print (numpy.random.multinomial(275, Fractions, size=1))
