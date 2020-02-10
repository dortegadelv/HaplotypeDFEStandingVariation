import dendropy
import sys

TreeFile = sys.argv[1]
NeValue = int(sys.argv[2])
PairwiseT2File = sys.argv[3]

f = open(PairwiseT2File,'w')

print (TreeFile)

TreeList = dendropy.TreeList.get(path=TreeFile, schema="newick")

print ('Here')
TotalTimes = []

for i in range(0,40000):
    TotalTimes.append(0)

print ('And here!')
TotalSum = 0
for j in range(0,10000):
    print (j)
    CurrentTree = TreeList[j]
    pdc = CurrentTree.phylogenetic_distance_matrix()
    for i, t1 in enumerate(CurrentTree.taxon_namespace[:-1]):
        for t2 in CurrentTree.taxon_namespace[i+1:]:
            if ((t1.label != '1') and (t2.label != '1')):
                 TotalSum = TotalSum + 1
                 CurrentDistance = int( (pdc(t1, t2) * 4 * NeValue + 0.5 ) / 2 )
                 TotalTimes[CurrentDistance] = TotalTimes[CurrentDistance] + 1


print (TotalSum)
for i in range(0,40000):
    Fraction = float(TotalTimes[i]) / float (TotalSum)
    f.write('{:-5}\t{:-20}\t{:1.10}\n'.format(i , Fraction, Fraction))

f.close()
