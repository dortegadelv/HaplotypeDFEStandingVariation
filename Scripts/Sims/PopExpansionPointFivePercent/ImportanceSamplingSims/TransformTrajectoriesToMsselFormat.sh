for i in {1..100}
do
echo $i
Sum=$(( $i + 1000 ))
FileOne="ExpansionDenserGrid/Exit_DemHistAfricanTennessen.txt_0.01_0_"$Sum".txtTrajectory.txt"
ExitFile="ExpansionDenserGrid/ExitMssel_0.01_0_"$i".txtTrajectory.txt"
perl ../TrajToMsselFormat.pl $FileOne $ExitFile 1000 50000
done
