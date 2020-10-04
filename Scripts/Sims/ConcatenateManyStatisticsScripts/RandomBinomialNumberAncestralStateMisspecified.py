import sys, numpy

Probability=float(sys.argv[1])

n, p = 10, .5  # number of trials, probability of each trial
s = numpy.random.binomial(300, Probability, 1)
# print (s)
sys.stdout.write(str(s[0]))

