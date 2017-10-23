First, to create the plink files used to calculate the frequencies, use:

cd ..
qsub -t 1-22 CreatePlinkFiles.sh

I first obtained the frequency per each site in the UK10K individuals that are clearly European according to the UK10K paper:

qsub -t 1-22 CalculateFrequencyPlinkFiles.sh

Then add the annotations for each site:

perl AssignAnnotations.pl

Then add the ancestral state:

perl AssignAncestralState.pl

Then get the list of missense variants at a particular frequency:

qsub -t 1-22 GetListOfMissenseAllelesAtACertainFrequency.sh

Then do:

cat ../../../Data/Plink/MissenseOnePercent{1..22}.frq > ../../../Data/Plink/AllMissenseOnePercent.frq

Then execute this for every variant at a one percent frequency:

qsub -t 1-700 CalculateHaplotypeLengths.sh

Convert bed file with data of the regions with genes:

perl ConvertBedFile.pl

Then get sites varying in the regions:

../../../Programs/htslib-1.5/TabixTest/bin/tabix ../../../Data/UK10K_COHORT.20160215.sites.vcf.gz -R ../../../Data/GenesInMaskVCFTabixReadyBed.bed
