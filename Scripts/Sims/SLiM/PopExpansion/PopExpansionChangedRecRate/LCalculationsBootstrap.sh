for i in {1..100}
do
echo $i
BootstrapPhoto="LDistributionBootSyn"$i".txt"
rm $BootstrapPhoto
touch $BootstrapPhoto
cat BootstrapSyn$i.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> $BootstrapPhoto
cat BootstrapSyn$i.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> $BootstrapPhoto
cat BootstrapSyn$i.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> $BootstrapPhoto
cat BootstrapSyn$i.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> $BootstrapPhoto
cat BootstrapSyn$i.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> $BootstrapPhoto
cat BootstrapSyn$i.txt | awk '$1 > 1.0' | wc -l >> $BootstrapPhoto
done


for i in {1..100}
do
echo $i
BootstrapPhoto="LDistributionBootNS"$i".txt"
rm $BootstrapPhoto
touch $BootstrapPhoto
cat BootstrapNS$i.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> $BootstrapPhoto
cat BootstrapNS$i.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> $BootstrapPhoto
cat BootstrapNS$i.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> $BootstrapPhoto
cat BootstrapNS$i.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> $BootstrapPhoto
cat BootstrapNS$i.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> $BootstrapPhoto
cat BootstrapNS$i.txt | awk '$1 > 1.0' | wc -l >> $BootstrapPhoto
done

