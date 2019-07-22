for i in {1..22}
do
echo $i
File="../../../Data/Plink/Plink"$i".tped"
PlinkFilePositions="../../../Data/Plink/Positions"$i".txt"
awk '{print $4}' $File > $PlinkFilePositions
done

cat ../../../Data/Plink/MissenseOnePercent{1..22}.frq > ../../../Data/Plink/AllMissenseOnePercent.frq

cat ../../../Data/Plink/SynonymousOnePercent{1..22}.frq > ../../../Data/Plink/AllSynonymousOnePercent.frq

cat ../../../Data/Plink/MissensePointFivePercent{1..22}.frq > ../../../Data/Plink/AllMissensePointFivePercent.frq

cat ../../../Data/Plink/SynonymousPointFivePercent{1..22}.frq > ../../../Data/Plink/AllSynonymousPointFivePercent.frq


