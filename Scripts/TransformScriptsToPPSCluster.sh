perl -i -pe 's/\#\$ \-A diegoort//g' Sims/ConstantPopSize/ForwardSims/ConstantSize_*.sh
perl -i -pe 's/\#\$ \-A diegoort//g' Sims/*/ForwardSims/Expansion_*.sh
perl -i -pe 's/\#\$ \-l express\,h_rt=2:00:00/\#\$ \-l h_vmem=2g/g' Sims/ConstantPopSize/ForwardSims/ConstantSize_*.sh
perl -i -pe 's/\#\$ \-l express\,h_rt=2:00:00/\#\$ \-l h_vmem=2g/g' Sims/*/ForwardSims/Expansion_*.sh

perl -i -pe 's/\#\$ \-A diegoort//g' Sims/*/ImportanceSamplingSims/RunImportanceSampling*.sh
perl -i -pe 's/\#\$ \-l h_rt=24:00:00/\#\$ \-l h_vmem=2g/g' Sims/*/ImportanceSamplingSims/RunImportanceSampling*.sh
perl -i -pe 's/\#\$ \-A diegoort//g' Sims/*/ImportanceSamplingSims/RunMsselCalculateDistance*.sh
perl -i -pe 's/\#\$ \-l h_rt=24:00:00/\#\$ \-l h_vmem=2g/g' Sims/*/ImportanceSamplingSims/RunMsselCalculateDistance*.sh

