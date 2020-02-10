AgeSum=$( grep 'age' TestData/run.2/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
TrajNum=$( grep 'age' TestData/run.2/ReducedTrajectories.txt | wc -l )
MeanAge=$( echo "scale=4; $AgeSum/$TrajNum" | bc )
echo $MeanAge

AgeSum=$( grep 'age' TestData/run.3/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
TrajNum=$( grep 'age' TestData/run.3/ReducedTrajectories.txt | wc -l )
MeanAge=$( echo "scale=4; $AgeSum/$TrajNum" | bc )
echo $MeanAge

AgeSum=$( grep 'age' TestData/run.4/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
TrajNum=$( grep 'age' TestData/run.4/ReducedTrajectories.txt | wc -l )
MeanAge=$( echo "scale=4; $AgeSum/$TrajNum" | bc )
echo $MeanAge

AgeSum=$( grep 'age' TestData/run.5/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
TrajNum=$( grep 'age' TestData/run.5/ReducedTrajectories.txt | wc -l )
MeanAge=$( echo "scale=4; $AgeSum/$TrajNum" | bc )
echo $MeanAge

AgeSum=$( grep 'age' TestData/run.6/ReducedTrajectories.txt | awk '{ sum+=$6} END {print sum}' )
TrajNum=$( grep 'age' TestData/run.6/ReducedTrajectories.txt | wc -l )
MeanAge=$( echo "scale=4; $AgeSum/$TrajNum" | bc )
echo $MeanAge

#### Only take 10,000 trajectories

AgeSum=$( grep 'age' TestData/run.2/ReducedTrajectories.txt | head -n10000 | awk '{ sum+=$6*40000} END {print sum}' )
AgeSquare=$( grep 'age' TestData/run.2/ReducedTrajectories.txt | head -n10000 | awk '{ sum+=($6*40000)*($6*40000)} END {print sum}' )
TrajNum=$( grep 'age' TestData/run.2/ReducedTrajectories.txt | head -n10000 | wc -l )
MeanAge=$( echo "scale=6; $AgeSum/$TrajNum" | bc )
AgeSquare=`echo ${AgeSquare} | sed -e 's/[eE]+*/\\*10\\^/'`
MeanAgeSquare=$( echo "scale=6; $AgeSquare/$TrajNum" | bc )
echo $MeanAge
echo $MeanAgeSquare
Variance=$( echo "scale=6;$MeanAgeSquare - $MeanAge*$MeanAge" | bc )
SD=$( echo "sqrt($Variance)" | bc )
echo $SD

AgeSum=$( grep 'age' TestData/run.3/ReducedTrajectories.txt | head -n10000 | awk '{ sum+=$6*40000} END {print sum}' )
AgeSquare=$( grep 'age' TestData/run.3/ReducedTrajectories.txt | head -n10000 | awk '{ sum+=($6*40000)*($6*40000)} END {print sum}' )
TrajNum=$( grep 'age' TestData/run.3/ReducedTrajectories.txt | head -n10000 | wc -l )
MeanAge=$( echo "scale=6; $AgeSum/$TrajNum" | bc )
AgeSquare=`echo ${AgeSquare} | sed -e 's/[eE]+*/\\*10\\^/'`
MeanAgeSquare=$( echo "scale=6; $AgeSquare/$TrajNum" | bc )
echo $MeanAge
echo $MeanAgeSquare
Variance=$( echo "scale=6;$MeanAgeSquare - $MeanAge*$MeanAge" | bc )
SD=$( echo "sqrt($Variance)" | bc )
echo $SD

AgeSum=$( grep 'age' TestData/run.4/ReducedTrajectories.txt | head -n10000 | awk '{ sum+=$6*40000} END {print sum}' )
AgeSquare=$( grep 'age' TestData/run.4/ReducedTrajectories.txt | head -n10000 | awk '{ sum+=($6*40000)*($6*40000)} END {print sum}' )
TrajNum=$( grep 'age' TestData/run.4/ReducedTrajectories.txt | head -n10000 | wc -l )
MeanAge=$( echo "scale=6; $AgeSum/$TrajNum" | bc )
AgeSquare=`echo ${AgeSquare} | sed -e 's/[eE]+*/\\*10\\^/'`
MeanAgeSquare=$( echo "scale=6; $AgeSquare/$TrajNum" | bc )
echo $MeanAge
echo $MeanAgeSquare
Variance=$( echo "scale=6;$MeanAgeSquare - $MeanAge*$MeanAge" | bc )
SD=$( echo "sqrt($Variance)" | bc )
echo $SD

AgeSum=$( grep 'age' TestData/run.5/ReducedTrajectories.txt | head -n10000 | awk '{ sum+=$6*40000} END {print sum}' )
AgeSquare=$( grep 'age' TestData/run.5/ReducedTrajectories.txt | head -n10000 | awk '{ sum+=($6*40000)*($6*40000)} END {print sum}' )
TrajNum=$( grep 'age' TestData/run.5/ReducedTrajectories.txt | head -n10000 | wc -l )
MeanAge=$( echo "scale=6; $AgeSum/$TrajNum" | bc )
AgeSquare=`echo ${AgeSquare} | sed -e 's/[eE]+*/\\*10\\^/'`
MeanAgeSquare=$( echo "scale=6; $AgeSquare/$TrajNum" | bc )
echo $MeanAge
echo $MeanAgeSquare
Variance=$( echo "scale=6;$MeanAgeSquare - $MeanAge*$MeanAge" | bc )
SD=$( echo "sqrt($Variance)" | bc )
echo $SD

AgeSum=$( grep 'age' TestData/run.6/ReducedTrajectories.txt | head -n10000 | awk '{ sum+=$6*40000} END {print sum}' )
AgeSquare=$( grep 'age' TestData/run.6/ReducedTrajectories.txt | head -n10000 | awk '{ sum+=($6*40000)*($6*40000)} END {print sum}' )
TrajNum=$( grep 'age' TestData/run.6/ReducedTrajectories.txt | head -n10000 | wc -l )
MeanAge=$( echo "scale=6; $AgeSum/$TrajNum" | bc )
AgeSquare=`echo ${AgeSquare} | sed -e 's/[eE]+*/\\*10\\^/'`
MeanAgeSquare=$( echo "scale=6; $AgeSquare/$TrajNum" | bc )
echo $MeanAge
echo $MeanAgeSquare
Variance=$( echo "scale=6;$MeanAgeSquare - $MeanAge*$MeanAge" | bc )
SD=$( echo "sqrt($Variance)" | bc )
echo $SD


