import sys, numpy

ValueOne=float(sys.argv[1])
ValueTwo=float(sys.argv[2])
ValueThree=float(sys.argv[3])
ValueFour=float(sys.argv[4])
ValueFive=float(sys.argv[5])
ValueSix=float(sys.argv[6])
ValueSeven=float(sys.argv[7])
ValueEight=float(sys.argv[8])

Sum = ValueOne + ValueTwo + ValueThree + ValueFour + ValueFive + ValueSix + ValueSeven + ValueEight

Fractions = [ValueOne / Sum, ValueTwo / Sum, ValueThree / Sum, ValueFour / Sum , ValueFive / Sum , ValueSix / Sum, ValueSeven / Sum, ValueEight / Sum]

Draws = numpy.random.multinomial(275, Fractions, size=1) 

String = str(Draws[0,0] ) + " " + str(Draws[0,1] ) + " " + str(Draws[0,2] ) + " " + str(Draws[0,3] ) + " " + str(Draws[0,4] ) + " " + str(Draws[0,5] ) + " " + str(Draws[0,6] ) + " " + str(Draws[0,7] )

sys.stdout.write(String)

# print (numpy.random.multinomial(275, Fractions, size=1))
