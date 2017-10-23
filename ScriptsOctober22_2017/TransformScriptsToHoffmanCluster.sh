perl -i -pe 's/\#\$ \-cwd/\#\$ \-cwd\n\#\$ \-A diegoort/g' Sims/ConstantPopSize/ForwardSims/ConstantSize_*.sh
perl -i -pe 's/\#\$ \-cwd/\#\$ \-cwd\n\#\$ \-A diegoort/g' Sims/*/ForwardSims/Expansion_*.sh
perl -i -pe 's/\#\$ \-l h_vmem=2g/\#\$ \-l express\,h_rt=2:00:00/g' Sims/ConstantPopSize/ForwardSims/ConstantSize_*.sh
perl -i -pe 's/\#\$ \-l h_vmem=2g/\#\$ \-l express\,h_rt=2:00:00/g' Sims/*/ForwardSims/Expansion_*.sh

#### Little fix

perl -i -pe 's/\#\$ \-cwd\#\$ \-A diegoort/\#\$ \-cwd\n\#\$ \-A diegoort/g' Sims/ConstantPopSize/ForwardSims/ConstantSize_*.sh
perl -i -pe 's/\#\$ \-cwd\#\$ \-A diegoort/\#\$ \-cwd\n\#\$ \-A diegoort/g' Sims/*/ForwardSims/Expansion_*.sh

