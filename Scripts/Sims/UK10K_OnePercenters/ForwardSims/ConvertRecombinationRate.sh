perl ConvertRecombinationRate.pl ../../../../Data/LeftBpRecRatePerVariantNoCpG.txt RecRateMissenseOnePercentLeftNoCpG.txt 
perl ConvertRecombinationRate.pl ../../../../Data/RightBpRecRatePerVariantNoCpG.txt RecRateMissenseOnePercentRightNoCpG.txt
cat RecRateMissenseOnePercentLeftNoCpG.txt RecRateMissenseOnePercentRightNoCpG.txt > RecRateMissenseOnePercentNoCpG.txt

perl ConvertRecombinationRate.pl ../../../../Data/LeftBpRecRatePerVariantNoCpGSynonymous.txt RecRateSynonymousOnePercentLeftNoCpG.txt
perl ConvertRecombinationRate.pl ../../../../Data/RightBpRecRatePerVariantNoCpGSynonymous.txt RecRateSynonymousOnePercentRightNoCpG.txt
cat RecRateSynonymousOnePercentLeftNoCpG.txt RecRateSynonymousOnePercentRightNoCpG.txt > RecRateSynonymousOnePercentNoCpG.txt

