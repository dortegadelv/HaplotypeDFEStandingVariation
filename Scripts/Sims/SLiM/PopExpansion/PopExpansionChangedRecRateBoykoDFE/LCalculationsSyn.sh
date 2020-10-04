rm LDistributionSynSites.txt
touch LDistributionSynSites.txt
cat ReplicateSyn_HapLength{1..300}.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSites.txt
cat ReplicateSyn_HapLength{1..300}.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSites.txt
cat ReplicateSyn_HapLength{1..300}.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSites.txt
cat ReplicateSyn_HapLength{1..300}.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSites.txt
cat ReplicateSyn_HapLength{1..300}.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSites.txt
cat ReplicateSyn_HapLength{1..300}.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSites.txt

rm LDistributionNSSites.txt
touch LDistributionNSSites.txt
cat ReplicateNS_HapLength{1..300}.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionNSSites.txt
cat ReplicateNS_HapLength{1..300}.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionNSSites.txt
cat ReplicateNS_HapLength{1..300}.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionNSSites.txt
cat ReplicateNS_HapLength{1..300}.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionNSSites.txt
cat ReplicateNS_HapLength{1..300}.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionNSSites.txt
cat ReplicateNS_HapLength{1..300}.txt | awk '$1 > 1.0' | wc -l >> LDistributionNSSites.txt

rm LDistributionSynSitesTwo.txt
touch LDistributionSynSitesTwo.txt
cat LDistributionSynRandom.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesTwo.txt
cat LDistributionSynRandom.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesTwo.txt
cat LDistributionSynRandom.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesTwo.txt
cat LDistributionSynRandom.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesTwo.txt
cat LDistributionSynRandom.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesTwo.txt
cat LDistributionSynRandom.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesTwo.txt

rm LDistributionNSSitesTwo.txt
touch LDistributionNSSitesTwo.txt
cat ReplicateNS_HapLength*.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionNSSitesTwo.txt
cat ReplicateNS_HapLength*.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionNSSitesTwo.txt
cat ReplicateNS_HapLength*.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionNSSitesTwo.txt
cat ReplicateNS_HapLength*.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionNSSitesTwo.txt
cat ReplicateNS_HapLength*.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionNSSitesTwo.txt
cat ReplicateNS_HapLength*.txt | awk '$1 > 1.0' | wc -l >> LDistributionNSSitesTwo.txt


rm LDistributionSynSitesThree.txt
touch LDistributionSynSitesThree.txt
cat ReplicateSyn_HapLength*.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesThree.txt
cat ReplicateSyn_HapLength*.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesThree.txt
cat ReplicateSyn_HapLength*.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesThree.txt
cat ReplicateSyn_HapLength*.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesThree.txt
cat ReplicateSyn_HapLength*.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesThree.txt
cat ReplicateSyn_HapLength*.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesThree.txt


############### Random

rm LDistributionSynSitesRand1.txt
touch LDistributionSynSitesRand1.txt
cat LDistributionSynRandom1.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesRand1.txt
cat LDistributionSynRandom1.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesRand1.txt
cat LDistributionSynRandom1.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesRand1.txt
cat LDistributionSynRandom1.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesRand1.txt
cat LDistributionSynRandom1.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesRand1.txt
cat LDistributionSynRandom1.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesRand1.txt

rm LDistributionSynSitesRand2.txt
touch LDistributionSynSitesRand2.txt
cat LDistributionSynRandom2.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesRand2.txt
cat LDistributionSynRandom2.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesRand2.txt
cat LDistributionSynRandom2.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesRand2.txt
cat LDistributionSynRandom2.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesRand2.txt
cat LDistributionSynRandom2.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesRand2.txt
cat LDistributionSynRandom2.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesRand2.txt

rm LDistributionSynSitesRand3.txt
touch LDistributionSynSitesRand3.txt
cat LDistributionSynRandom3.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesRand3.txt
cat LDistributionSynRandom3.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesRand3.txt
cat LDistributionSynRandom3.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesRand3.txt
cat LDistributionSynRandom3.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesRand3.txt
cat LDistributionSynRandom3.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesRand3.txt
cat LDistributionSynRandom3.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesRand3.txt

rm LDistributionSynSitesRand4.txt
touch LDistributionSynSitesRand4.txt
cat LDistributionSynRandom4.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesRand4.txt
cat LDistributionSynRandom4.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesRand4.txt
cat LDistributionSynRandom4.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesRand4.txt
cat LDistributionSynRandom4.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesRand4.txt
cat LDistributionSynRandom4.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesRand4.txt
cat LDistributionSynRandom4.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesRand4.txt

rm LDistributionSynSitesRand5.txt
touch LDistributionSynSitesRand5.txt
cat LDistributionSynRandom5.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesRand5.txt
cat LDistributionSynRandom5.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesRand5.txt
cat LDistributionSynRandom5.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesRand5.txt
cat LDistributionSynRandom5.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesRand5.txt
cat LDistributionSynRandom5.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesRand5.txt
cat LDistributionSynRandom5.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesRand5.txt


rm LDistributionSynSitesRand6.txt
touch LDistributionSynSitesRand6.txt
cat LDistributionSynRandom6.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesRand6.txt
cat LDistributionSynRandom6.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesRand6.txt
cat LDistributionSynRandom6.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesRand6.txt
cat LDistributionSynRandom6.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesRand6.txt
cat LDistributionSynRandom6.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesRand6.txt
cat LDistributionSynRandom6.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesRand6.txt

rm LDistributionSynSitesRand7.txt
touch LDistributionSynSitesRand7.txt
cat LDistributionSynRandom7.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesRand7.txt
cat LDistributionSynRandom7.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesRand7.txt
cat LDistributionSynRandom7.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesRand7.txt
cat LDistributionSynRandom7.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesRand7.txt
cat LDistributionSynRandom7.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesRand7.txt
cat LDistributionSynRandom7.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesRand7.txt

rm LDistributionSynSitesRand8.txt
touch LDistributionSynSitesRand8.txt
cat LDistributionSynRandom8.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesRand8.txt
cat LDistributionSynRandom8.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesRand8.txt
cat LDistributionSynRandom8.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesRand8.txt
cat LDistributionSynRandom8.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesRand8.txt
cat LDistributionSynRandom8.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesRand8.txt
cat LDistributionSynRandom8.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesRand8.txt

rm LDistributionSynSitesRand9.txt
touch LDistributionSynSitesRand9.txt
cat LDistributionSynRandom9.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesRand9.txt
cat LDistributionSynRandom9.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesRand9.txt
cat LDistributionSynRandom9.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesRand9.txt
cat LDistributionSynRandom9.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesRand9.txt
cat LDistributionSynRandom9.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesRand9.txt
cat LDistributionSynRandom9.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesRand9.txt

rm LDistributionSynSitesRand10.txt
touch LDistributionSynSitesRand10.txt
cat LDistributionSynRandom10.txt | awk '$1 <= 0.2 && $1 >= 0.0' | wc -l >> LDistributionSynSitesRand10.txt
cat LDistributionSynRandom10.txt | awk '$1 <= 0.4 && $1 > 0.2' | wc -l >> LDistributionSynSitesRand10.txt
cat LDistributionSynRandom10.txt | awk '$1 <= 0.6 && $1 > 0.4' | wc -l >> LDistributionSynSitesRand10.txt
cat LDistributionSynRandom10.txt | awk '$1 <= 0.8 && $1 > 0.6' | wc -l >> LDistributionSynSitesRand10.txt
cat LDistributionSynRandom10.txt | awk '$1 <= 1.0 && $1 > 0.8' | wc -l >> LDistributionSynSitesRand10.txt
cat LDistributionSynRandom10.txt | awk '$1 > 1.0' | wc -l >> LDistributionSynSitesRand10.txt


