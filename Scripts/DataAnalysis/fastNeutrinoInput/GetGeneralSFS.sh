touch ../../../Data/fastNeutrinoInput/GeneralSFS.txt
for j in {2..7430}
do
head -n$j ../../../Data/fastNeutrinoInput/fastNeutrinoExitFile.txt | tail -n1 | awk '{sum=0; for (i=1; i<=NF; i++) { sum+= $i } print sum}' >> ../../../Data/fastNeutrinoInput/GeneralSFS.txt
done

