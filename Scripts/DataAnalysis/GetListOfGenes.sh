# Get Number of protein coding genes.
awk '{if($3=="gene" && $20=="\"protein_coding\";"){print $0}}' ../../Data/gencode.v19.annotation.gtf > ../../Data/testgencode.v19.annotation.gtf
# Sort genes
sort -k1,1 -k4,4n ../../Data/testgencode.v19.annotation.gtf > ../../Data/sortedgencode.v19.annotation.gtf
# Use bedtools
bedtools merge -i ../../Data/sortedgencode.v19.annotation.gtf -n > ../../Data/mergedgencode.v19.annotation.gtf
# Only get autosomal genes
head -n15286 ../../Data/mergedgencode.v19.annotation.gtf > ../../Data/mergedgencodeautosomes.v19.annotation.gtf
