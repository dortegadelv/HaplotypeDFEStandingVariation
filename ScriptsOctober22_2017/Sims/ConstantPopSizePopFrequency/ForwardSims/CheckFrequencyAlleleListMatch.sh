wc -l TestData/run.2/Alleles{1..1000}.txt | tail
awk '{print $3}' TestData/run.2/full_out.run.2.num.{1..1000}.N.20000.h.0.500000.F.0.000000.txt | grep '1.000000e-02' | wc -l

wc -l TestData/run.3/Alleles{1..2000}.txt | tail
awk '{print $3}' TestData/run.3/full_out.run.3.num.{1..2000}.N.20000.h.0.500000.F.0.000000.txt | grep '1.000000e-02' | wc -l

wc -l TestData/run.4/Alleles{1..2000}.txt | tail
awk '{print $3}' TestData/run.4/full_out.run.4.num.{1..2000}.N.20000.h.0.500000.F.0.000000.txt | grep '1.000000e-02' | wc -l

wc -l TestData/run.5/Alleles{1..2000}.txt | tail
awk '{print $3}' TestData/run.5/full_out.run.5.num.{1..2000}.N.20000.h.0.500000.F.0.000000.txt | grep '1.000000e-02' | wc -l

wc -l TestData/run.6/Alleles{1..3000}.txt | tail
awk '{print $3}' TestData/run.6/full_out.run.6.num.{1..3000}.N.20000.h.0.500000.F.0.000000.txt | grep '1.000000e-02' | wc -l
