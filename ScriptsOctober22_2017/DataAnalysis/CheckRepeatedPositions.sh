for i in {1..22}
do
FileOne="/mnt/gluster/data/external_private_supp/uk10k/_EGAZ00001017893_"$i".UK10K_COHORT.REL-2012-06-02.beagle.anno.csq.shapeit.20140306.legend.gz"
FileNumber=$( zcat $FileOne | awk '{print $2}' | sort -n | uniq | wc -l )
FileNumberTwo=$( zcat $FileOne | wc -l )
echo $FileNumber
echo $FileNumberTwo
done

zcat ../../Data/UK10K_COHORT.20160215.sites.vcf.gz | head | awk '{print $2}'
