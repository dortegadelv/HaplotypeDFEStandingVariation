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

We use the following script to grab the variants that are not close to centromeres and telomeres:

perl GetListOfSNPsCloserToCentromeresOrTelomeres.pl
perl GetListOfSNPsCloserToCentromeresOrTelomeresSynonymous.pl

We will use the following scripts to prove that the synonymous and nonsynonymous variants have similar distributions of B values and functional content around the variant.

perl CreateBedFileBStatistic.pl
perl CreateBedFileUCSCGenes.pl
perl CreateBedFilePhastCons.pl
sort -k1,1 -k2,2n ../../../Data/UCSCGenes_BStatistic/ExonsBedFile.txt > ../../../Data/UCSCGenes_BStatistic/ExonsBedFileSort.txt
for i in {1..22}
do
File="../../../Data/UCSCGenes_BStatistic/PhastCons100WayVertebratesBedFile_chr"$i".txt"
OutputFile="../../../Data/UCSCGenes_BStatistic/PhastCons100WayVertebratesBedFileSort_chr"$i".txt"
sort -k1,1 -k2,2n $File > $OutputFile
done

bedtools merge -i ../../../Data/UCSCGenes_BStatistic/ExonsBedFileSort.txt > ../../../Data/UCSCGenes_BStatistic/ExonsBedUniqueFile.txt

for i in {1..22}
do
File="../../../Data/UCSCGenes_BStatistic/PhastCons100WayVertebratesBedFileSort_chr"$i".txt"
OutputFile="../../../Data/UCSCGenes_BStatistic/PhastCons100WayVertebratesBedFileUnique_chr"$i".txt"
bedtools merge -i $File > $OutputFile
done

perl CompareFunctionalContent.pl
perl CompareFunctionalContentNS.pl

We used liftover from https://genome.ucsc.edu/cgi-bin/hgLiftOver with default parameters (Minimum ratio of bases that must remap = 0.95; Minimum hit size in query = 0; Minimum chain size in target = 0;
Min ratio of alignment blocks or exons that must map = 1).
We then used:

for i in {1..22}
do
File="../../../Data/UCSCGenes_BStatistic/bkgd/bkgd/chrBed"$i"Hg19.bed"
Output="../../../Data/UCSCGenes_BStatistic/bkgd/bkgd/chrBed"$i"Hg19Sorted.bed"
sort -k1,1 -k2,2n $File > $Output
done

perl CompareBValuesContent.pl


####### CpG Sites
# This compares the reference allele of the reference genome hg19 with what
# the reference allele I got from the 1000 genomes VCF. Things match!
perl RefAlleleMapCheck.pl

# We clasified CpG sites using

for i in {1..22}
do
perl RefAlleleCpgAllSites.pl $i
done

## Merge Annotations with CpG information

perl MergeAncCpgAnnotation.pl

# Get 1% frequency sites that are not CpGs

qsub -t 1-22 GetListOfMissenseAllelesAtACertainFrequencyCpG.sh
qsub -t 1-22 GetListOfSynonymousAllelesAtACertainFrequencyCpG.sh

cat ../../../Data/Plink/SynonymousOnePercentCpG{1..22}.frq > ../../../Data/Plink/SynonymousOnePercentCpG.frq
cat ../../../Data/Plink/MissenseOnePercentCpG{1..22}.frq > ../../../Data/Plink/MissenseOnePercentCpG.frq

# Create Plink file without CpGs

perl CreatePlinkFileWithoutCpGs.pl

## Positions of only CpGs 

for i in {1..22}
do
echo $i
awk '{print $4}' ../../../Data/Plink/PlinkNotCpG$i.tped > ../../../Data/Plink/PositionsNotCpG$i.txt
done

perl PrintCpGPositionsOnePercentFrequency.pl

### Calculate Haplotype lengths not CpG regions

qsub -t 1-183 CalculateHaplotypeLengthsSynonymousOnlyCpG.sh
qsub -t 1-325 CalculateHaplotypeLengthsOnlyCpG.sh

### GetListOfExonsAwayFromCentromeresTelomeres

perl GetExonsAwayFromCentromereTelomere.pl

#### Count total number of CpG sites

for i in {1..22}
do
perl CountCpGSites.pl $i
done


############## Check Recombination maps

perl GetGeneticMapLeftRightPrintMap.pl
perl GetGeneticMapLeftRightSynonymousPrintMap.pl
perl GetGeneticMapLeftRightNotCpGPrintMap.pl
perl GetGeneticMapLeftRightSynonymousNotCpGPrintMap.pl


