Numerator=$( grep 'age' TestData/run.2/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
Denominator=$( grep 'age' TestData/run.2/ReducedTrajectories.txt | wc -l | awk '{print $1}' )
Ratio=$( echo "scale=8; $Numerator / $Denominator " | bc )
echo $Ratio
Numerator=$( grep 'age' TestData/run.3/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
Denominator=$( grep 'age' TestData/run.3/ReducedTrajectories.txt | wc -l | awk '{print $1}' )
Ratio=$( echo "scale=8; $Numerator / $Denominator " | bc )
echo $Ratio
Numerator=$( grep 'age' TestData/run.4/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
Denominator=$( grep 'age' TestData/run.4/ReducedTrajectories.txt | wc -l | awk '{print $1}' )
Ratio=$( echo "scale=8; $Numerator / $Denominator " | bc )
echo $Ratio
Numerator=$( grep 'age' TestData/run.5/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
Denominator=$( grep 'age' TestData/run.5/ReducedTrajectories.txt | wc -l | awk '{print $1}' )
Ratio=$( echo "scale=8; $Numerator / $Denominator " | bc )
echo $Ratio
Numerator=$( grep 'age' TestData/run.6/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
Denominator=$( grep 'age' TestData/run.6/ReducedTrajectories.txt | wc -l | awk '{print $1}' )
Ratio=$( echo "scale=8; $Numerator / $Denominator " | bc )
echo $Ratio
Numerator=$( grep 'age' TestData/run.8/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
Denominator=$( grep 'age' TestData/run.8/ReducedTrajectories.txt | wc -l | awk '{print $1}' )
Ratio=$( echo "scale=8; $Numerator / $Denominator " | bc )
echo $Ratio

