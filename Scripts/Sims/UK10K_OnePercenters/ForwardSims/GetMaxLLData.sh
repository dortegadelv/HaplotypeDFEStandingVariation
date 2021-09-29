awk '{print $2}' ../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFE.txt | sort -g | tail -n2
grep '2114104.03833872' ../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFE.txt
awk '{print $2}' ../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFEAnother.txt | sort -g | tail -n2
grep '2114089.17690862' ../../../../Results/UK10K_OnePercenters/ForwardSims/LLDataDFEAnother.txt

