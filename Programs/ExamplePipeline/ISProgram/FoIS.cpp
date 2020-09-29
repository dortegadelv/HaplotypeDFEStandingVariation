#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>
//#include <boost/random.hpp>
#include <boost/tr1/random.hpp>
#include <boost/math/distributions/binomial.hpp>
#include <boost/math/distributions/beta.hpp>
#include <boost/math/distributions.hpp>
#include <boost/algorithm/string.hpp>
#include <boost/lexical_cast.hpp>
#include <boost/math/special_functions/beta.hpp>
#include <float.h>
#include <numeric>

#include <sstream>
#include <stdexcept>

#include "Gamma.h"
#include "prob.hpp"

using namespace std;
using namespace std::tr1;
using boost::math::binomial;
using boost::lexical_cast;


long double PathBetaProbability;

int main(int argc, char const *argv[])
{

//	cout << "Hello, World\n";
//	 typedef boost::mt19937 RNGType;
//	 RNGType rng;
//	boost::mt19937 rng;
	// Get Parameters, should be the selection coefficients
	double sAA = 0.0, sAa = 0.0, f = 0.0, Back_sAA, Back_sAa;
	double LogRatio, ActualRatio, CurrentWeight, PrevLogRatio;
	int repetitions, i, Ne, p, Test = 0, j, k, l , PrintFrequenciesAtThisGen, PrintFrequenciesFlag = 0;
	unsigned int seed,CurrentRepetitionSeed, BaldingModelFlag;
	double CurrentAlleleAge, GenerationsAgoin4NeScale;
	int CoefOfVarFlag = 0, RepRandomNumber, SampleFinalGenFlag = 0, SampleFinalGenPopSize = 0;
	int ExitLoopFlag = 0;
        long double ForwardProb, ReverseProb;
	vector<int> WrightFisher;
	vector<int> AlleleAge;
	vector<int> N_eSizes;
	vector<int> MultSel, MultScalars;
	vector<double> Ratios, PrevRatios;
	vector <double> XPrimes, YPrimes;
	vector <double> Bounds;
	vector <double> SValuesToCheck , ForwardProbValues , AllWeightsToPrint , ExpAllWeights;
	double NormalizedSummedWeights;
	vector <int> SISR_List;
	int ZeroWeightFlag;
	int Ages;
	double MaximumWRatio;
	double BigW, SumW, TestAge, XP, YP, Epsilon = 0.0001, CurrentForward, CurrentBackward;
	double Margin = 0.0000003, UpperMargin = 0.99999;
	double ExpectedAlleleAge, ExpectedAlleleAgeGeneration, ThisXPrime;
	double F_Beta = 0.0, GammaTest, DistributionTypeS, DistributionParameter1S, DistributionParameter2S, random_uniform_number, CV_Threshold = 100000, CurrentSimFrequency;
	WrightFisher.push_back(0);
	WrightFisher.push_back(6);
//	for(vector<int>::iterator p=WrightFisher.begin(); p!= WrightFisher.end();++p){
//		cout << *p << '\n';
//	}
	BaldingModelFlag = 0;
	  while (!WrightFisher.empty())
  {
    WrightFisher.pop_back();
  }
//	cout <<" Test 2\n";

//	for(vector<int>::iterator p=WrightFisher.begin(); p!= WrightFisher.end();++p){
//		cout << *p << '\n';
//	}

	// declaration of functions
	ofstream outputFile, outputTrajectory, outputFrequencies;
	long double ForwardProbability (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e);
	double ReverseProbability (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e);
	double Weight (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e);
	double MontyWeight (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e, vector<double> XPrimes, vector<double> YPrimes, vector <int> Ne_SizeChanges);
	double XPrime (double S_AA, double S_Aa, int AlleleNumber, int N_e);
	double YPrime (double S_AA, double S_Aa, int AlleleNumber, int N_e);
	double ReverseProbability2 (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e);
	double ReverseProbability3 (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e);
	vector<int> BackWrightFisher (double Threshold, double S_AA, double S_Aa, int N_e, int random_seed);
	vector<int> BackWrightFisher2 (double Threshold, double S_AA, double S_Aa, int N_e, int random_seed, double Margin, double UpperMargin);
	vector<int> BackWrightFisher3 (double Threshold, double S_AA, double S_Aa, int N_e, int random_seed, double Margin, double UpperMargin);
	vector<int> BackWrightFisher4 (double Threshold, double S_AA, double S_Aa, int N_e, int random_seed, double Margin, double UpperMargin, vector <int> Ne_SizeChanges, double F_Beta, double Epsilon);
	double BackWrightFisher4_XPrime (double CurrentF, double S_AA, double S_Aa, int GenNumber, int random_seed, double Margin, double UpperMargin, int CurrentNeBefore, int CurrentNeAfter, double F_Beta, double Epsilon);
	vector<int> BackWrightFisherBD (double Threshold, double S_AA, double S_Aa, int N_e, int random_seed, double Margin, double UpperMargin);
	void test_mean(int TestRepetition, int ThisSeed);
	vector<int> SampleFromList (vector <double> NormalizedList);
	double bnldev(double pp, int n, int *idum);
//	double bnldev(double pp, int n, int *idum);
	
	vector<string> strs;	
	string ExitFile, ExitTrajectory, String2, DemographicFile, BoundsFile, buffer, PrintFrequenciesFile , SValuesToCheckFile ;
	int TMax = 1000000;
/*	GammaTest = Gamma(1.5);
	cout << "Gamma Test = " << GammaTest << "\n";
        GammaTest = Gamma(0.9333);
        cout << "Gamma Test = " << GammaTest << "\n";
        GammaTest = Gamma(0.009);
        cout << "Gamma Test = " << GammaTest << "\n";
        GammaTest = Gamma(115);
        cout << "Gamma Test = " << GammaTest << "\n";
	return 0; */
//	GammaTest = beta_binomial_pdf(1, 1.0,2.0,10);
//	cout << "Beta-Binomial pdf test = " << GammaTest << "\n";	
/*	GammaTest = beta_binomial_pdf(2, 1.0,2.0,10);
	cout << "Beta-Binomial pdf test = " << GammaTest << "\n";
	return 0; */
	if (argc < 7 ){
		cout<<"usage :"<<argv[0] <<" -A <Homozygous_selection_coefficient> -a <Heterozygous_selection_coefficient> -f <Frequency_of_sampled_allele> -r <Number_of_repetitions> -N <Number_of_chromosomes_in_the_present_day_population> -s <Random_seed> -F <Exit_file> -b <Allele_frequency_bounds_file> -D <Demographic_history_file> -X <Selection_values_file> -p <Number_of_chromosomes_sampled>\n";
		exit(1);
	}
	DistributionTypeS = 0;
	for (int i = 1; i < argc; i++) {
		if (argv[i][0] == '-') { 
			 switch (argv[i][1]) {
			cout << "Good!\n";
			case 'A': sAA= atof(argv[i+1]);
			break;
			case 'p': SampleFinalGenFlag = 1;
			SampleFinalGenPopSize = atoi(argv[i+1]);
			break;
			case 'a': sAa= atof(argv[i+1]);
			break;
			case 'C': CV_Threshold = atof(argv[i+1]);
			break;
			case 'f': f = atof(argv[i+1]);
			break;
			case 'r': repetitions = atoi(argv[i+1]);
			break;
			case 'N': Ne = atoi(argv[i+1]);
			break;
			case 's': seed = atoi(argv[i+1]);
			break;
			case 't': Test = atoi (argv[i+1]);
			break;
			case 'M': Margin = atof (argv[i+1]);
			break;
			case 'U': UpperMargin = atof (argv[i+1]);
			break;
			case 'Q': F_Beta = atof (argv[i+1]);
			break;
			case 'P': PrintFrequenciesAtThisGen = atoi (argv[i+1]);
			PrintFrequenciesFlag = 1;
			break;
			case 'E': Epsilon = atof (argv[i+1]);
			break;
			case 'S': DistributionTypeS = atoi (argv[i+1]);
			DistributionParameter1S = atof (argv[i+2]);
			DistributionParameter2S = atof (argv[i+3]);
			break;
			case 'F': ExitFile = argv[i+1];
			String2 = "Trajectory.txt";
			ExitTrajectory = ExitFile + String2;
			String2 = "WeightYears.txt";
			ExitFile = ExitFile + String2;
			String2 = "FrequenciesAtXGeneration.txt";
			PrintFrequenciesFile = ExitFile + String2;
			outputFile.open(ExitFile.c_str());
			outputTrajectory.open(ExitTrajectory.c_str());
			break;
			case 'B':
			BaldingModelFlag = 1;
			break;
			case 'b': { BoundsFile = argv[i+1];
			ifstream file(BoundsFile.c_str());
			while (file) {
				getline(file, buffer);
				if (!file) break;
				if (buffer.empty() || buffer[0]=='#')
					continue;
				boost::split(strs, buffer, boost::is_any_of("\t "));
				vector<string>::iterator line_parse = strs.begin();
				Bounds.push_back(lexical_cast<double>(*line_parse));
				cout << "Bounds: " << *line_parse << "\n";
			}
				 }
			break;
			case 'X': {
			SValuesToCheckFile = argv[i+1];
			ifstream sfile(SValuesToCheckFile.c_str());
			while(sfile){
				getline(sfile, buffer);
				if (!sfile) break;
				if (buffer.empty())
					continue;
				SValuesToCheck.push_back(lexical_cast<double>(buffer));
				
			}
			}
			break;
			case 'D': DemographicFile = argv[i+1];
			ifstream is(DemographicFile.c_str());
			vector<string> DemoType;
			vector <double> DemoRate, DemoTime;
			double LineParseNumber;
			int LineParseNumberInt;
			string stringToConvert;
			while (is) {
				getline(is, buffer);
				if (!is) break;
				if (buffer.empty() || buffer[0]=='#')
					continue;	
//				sstringstream isss(buffer);
				cout << "Line: " << buffer << "\n";
				boost::split(strs, buffer, boost::is_any_of("\t "));
				int LineCounter = 0;
				vector<string>::iterator line_parse = strs.begin();
//				std::vector<std::string>::iterator line_parse = strs.begin();
				cout << "Data: " << *line_parse << "\n"; 
				DemoType.push_back(*line_parse);
				advance(line_parse,1);
//				stringToConvert = *line_parse;
				LineParseNumber = lexical_cast<double>(*line_parse);
				cout << "Data2: " << LineParseNumber << "\n";
				DemoTime.push_back(LineParseNumber);
				advance(line_parse,1);
				LineParseNumber = lexical_cast<double>(*line_parse);
				cout << "Data3: " << LineParseNumber << "\n";
				DemoRate.push_back(LineParseNumber);
                                advance(line_parse,1);
				LineParseNumberInt = lexical_cast<int>(*line_parse);
                                cout << "Data4: " << LineParseNumberInt << "\n";
                                MultSel.push_back(LineParseNumberInt);

			}
			is.close();
			vector<string>::iterator line_type = DemoType.begin();
			vector<double>::iterator line_time = DemoTime.begin();
			vector<double>::iterator line_rate = DemoRate.begin();
			vector<int>::iterator line_multype = MultSel.begin();
			int CurrentPopulationSize = Ne;
					 int NumberOfGenerations = 0;
					 int TimeBoundary;
					 int IterationPopSize = Ne;
					 int IterationGens = 0;
					 int PastGrowthFlag = 0;
					 double PastGrowthRate = 0;
			for (j = 0; j < (int) DemoRate.size(); j++){
//				printf("Line iteration = %i\n", j);
				
//				cout << "Time boundary: " << TimeBoundary << "\t" << *line_time<< "\t" << CurrentPopulationSize << "\n";
//				IterationGens = 0;
				if (j != ((int) DemoRate.size() - 1)){
				if (*line_type == "eN"){
					advance(line_time,1);
//					advance(line_multype,1);
					TimeBoundary = int(*line_time * 2 * (float) Ne);
					CurrentPopulationSize = int ((float) Ne * *line_rate) ;
					while (NumberOfGenerations < TimeBoundary) {
						N_eSizes.push_back(CurrentPopulationSize);
						MultScalars.push_back(*line_multype);
//						cout << "Gens: " << NumberOfGenerations <<  "NeVector: " << CurrentPopulationSize << " Scalar: " << *line_multype << "\n";
						NumberOfGenerations++;
					}
					PastGrowthFlag = 0;
				}else if (*line_type == "g") {
					advance(line_time,1);
//					advance(line_multype,1);
					TimeBoundary = int(*line_time * 2 * (float) Ne);
					IterationGens = 0;
					while (NumberOfGenerations < TimeBoundary) {
//					cout << "Growth! ";
					if ((IterationGens == 0) && (PastGrowthFlag == 1)){
					CurrentPopulationSize = (int) ( (double) CurrentPopulationSize* exp(-PastGrowthRate) + 0.5);
					N_eSizes.push_back(CurrentPopulationSize);
					MultScalars.push_back(*line_multype);
					IterationPopSize = CurrentPopulationSize;
					IterationGens++;
//					cout << "Gens: " << NumberOfGenerations <<  "NeVector: " << CurrentPopulationSize << " IterationPopSize" << IterationPopSize<<  "\n";
					NumberOfGenerations++;
					}else{
					CurrentPopulationSize = (int) ( (double) IterationPopSize * exp (-*line_rate * (double) IterationGens) + 0.5);
					N_eSizes.push_back(CurrentPopulationSize);
					MultScalars.push_back(*line_multype);
					IterationGens++;
//					cout << "Gens: " << NumberOfGenerations <<  "NeVector: " << CurrentPopulationSize << " IterationPopSize" << IterationPopSize<<  "\n";
					NumberOfGenerations++;
						}
					}
					PastGrowthFlag = 1;
					PastGrowthRate = *line_rate;
				}
			}else {
				if (*line_type == "eN"){
					CurrentPopulationSize = int ((float) Ne * *line_rate) ;
					while (NumberOfGenerations < TMax) {
						N_eSizes.push_back(CurrentPopulationSize);
						MultScalars.push_back(*line_multype);
//						cout << "Gens: " << NumberOfGenerations <<  "NeVector: " << CurrentPopulationSize << " Scalar: " << *line_multype << "\n";
						NumberOfGenerations++;
					}
					PastGrowthFlag = 0;
				}else if (*line_type == "g") {
					IterationGens = 0;
					while (NumberOfGenerations < TMax) {
//						cout << "Growth! ";
						if ((IterationGens == 0) && (PastGrowthFlag == 1)){
							CurrentPopulationSize = (int) ( (double) CurrentPopulationSize* exp(-PastGrowthRate) + 0.5);
							N_eSizes.push_back(CurrentPopulationSize);
							MultScalars.push_back(*line_multype);
							IterationPopSize = CurrentPopulationSize;
							IterationGens++;
//							cout << "Gens: " << NumberOfGenerations <<  "NeVector: " << CurrentPopulationSize << " IterationPopSize" << IterationPopSize<<  "\n";
							NumberOfGenerations++;
						}else{
						CurrentPopulationSize = (int) ( (double) IterationPopSize * exp (-*line_rate * (double) IterationGens) + 0.5);
						N_eSizes.push_back(CurrentPopulationSize);
						MultScalars.push_back(*line_multype);
						IterationGens++;
//						cout << "Gens: " << NumberOfGenerations <<  " NeVector: " << CurrentPopulationSize << " IterationPopSize" << IterationPopSize<<  "\n";		
						NumberOfGenerations++;
						}
					}
					PastGrowthFlag = 1;
					PastGrowthRate = *line_rate;
				}
				
				
//				cout << "Hey!\n";
			}
 
/*				for (i=NumberOfGenerations; NumberOfGenerations < TMax; NumberOfGenerations++) {
					CurrentPopulationSize
				} */
				IterationPopSize = CurrentPopulationSize;
				advance(line_type,1);
//				advance(line_time,1);
				advance(line_rate,1);
				advance(line_multype,1);
			}
					 line_time = DemoTime.end();
					 line_multype = MultSel.end();
//					 cout << "Final Population Size: " << CurrentPopulationSize << "Final Population Time: " <<NumberOfGenerations << "\n" ;
/*		vector<int>::iterator NeSizeIterator = N_eSizes.begin();
//					 cout << "InitialSize: " << *NeSizeIterator;
			for (i = 0; i < (int) DemoRate.size(); i++){
//				cout << i << "\t" << *NeSizeIterator<< "\n";
			}
			*/
			break;
		}
	}
}
	
//cout << "ExitTraj: " << ExitTrajectory<<"\n";
//	exit(1);
	cout<<"sAA: " <<sAA << "\n";
	cout<<"sAa: " <<sAa << "\n";
	cout<<"f: " <<f << "\n";
	cout<<"repetitions: " <<repetitions << "\n";
	cout<<"Ne: " <<Ne << "\n";
	cout<<"seed: " <<seed << "\n";
	boost::mt19937 rng(seed);
	srand(seed);
	RepRandomNumber = -seed;
/*	if (Test == 1){
		test_mean(10000,seed);

	} */

//	return 0;
	
MaximumWRatio = 0;
ExpectedAlleleAge = 0;
SumW = 0;
TestAge = 0;
ranlux_base_01 real_engine_2(seed);
uniform_real<> zeroone(0,1);
int AllelesInPresentGeneration;
int TemporalAlleles;
int LowerBoundPerRepetition;
int UpperBoundPerRepetition;
int NoMorePrintFlag;
double Weights;
double ExpWeights, random_uniform_number_f;
string ReducedTrajectories;
string TemporalTrajectories;
double CumulativeWeight;
vector<int>::iterator NeSizesIterator, NeSizesIteratorAfter, SelMultIterator;
int NumberOfGenerations = 0, CurrentNeSizeBefore, CurrentNeSizeAfter, NumberOfExtinctTrajectories, LowBound, UpBound;
double Currentf= f, PathXPrime, PathYPrime, FrequencyToPrint, AfterFrequency, BetaDisUpLimit, BetaDisLowLimit;
int CurrentAlleleNumber = int(Currentf * Ne);
/* Don't forget to remove later what is below January 15, 2013  */
 
	ofstream ExampleTrajectory;
//	ExampleTrajectory.open("ExitTrajectoryTest.txt");
//	ExampleTrajectory << CurrentAlleleNumber << "\n";


/* Don't forget to remove later what is in the upper part January 15, 2013  */
boost::math::beta_distribution<> nd((int) (SampleFinalGenPopSize*f + 0.5) + 1, (int) SampleFinalGenPopSize - (int) (SampleFinalGenPopSize*f + 0.5) + 1 );
//boost::variate_generator<boost::mt19937&,boost::math::beta_distribution<> > var_nor(rng,nd);
	for (j = 0; j< repetitions; j++) {
	if (SampleFinalGenFlag == 0){	
	CurrentAlleleNumber = int(f * Ne + 0.5);
	Currentf = double(CurrentAlleleNumber) / double(Ne);
	}else{
	CurrentAlleleNumber = int(f * SampleFinalGenPopSize + 0.5);
	Currentf = double(CurrentAlleleNumber) / double(SampleFinalGenPopSize);
	}
        if (SampleFinalGenFlag == 1){
        // Previous way to go from present-day sampled allele number to allele frequency in first generation
/*              Test = (int) ( bnldev(Currentf,Ne, &RepRandomNumber) + 0.5);
                CurrentAlleleNumber =  Test;
                Currentf = double(CurrentAlleleNumber) / double(Ne); */
//              Test = (int) ( var_nor() * Ne + 0.5);
		random_uniform_number_f =  static_cast <float> (rand()) / static_cast <float> (RAND_MAX);
		Currentf = quantile(nd,random_uniform_number_f);
                CurrentAlleleNumber = (int) (Currentf*Ne + 0.5);
                Currentf = double(CurrentAlleleNumber) / double(Ne);
		Test = CurrentAlleleNumber;
                if (Test < 2){
                CurrentAlleleNumber = 2;
                Currentf = double(2.0) / double(Ne);
                }
        }

		ReducedTrajectories = "";
		TemporalTrajectories = "";
		NoMorePrintFlag = 1;
		NormalizedSummedWeights = 0;
		ExpWeights = 0;
		Ages = 0;
		ZeroWeightFlag = 0;

	for (k = 0; k < ( Bounds.size()); k++) {
		if (Bounds[k] < Currentf) {
			LowBound = k;
		}
		if (Bounds[k] > Currentf) {
			UpBound = k;
			LowerBoundPerRepetition = LowBound;
			UpperBoundPerRepetition = k;
			break;
		}
	}

	for (k = 0; k < ( SValuesToCheck.size()); k++) {
//		cout << "k = " << k << " Selection = " << SValuesToCheck[k] << "\n";
		ForwardProbValues.push_back(0);
		AllWeightsToPrint.push_back(0);
		ExpAllWeights.push_back(0);
	}
	
	cout << "Frequency = " << Currentf << " Lower Bound = " << LowBound << " Up Bound = " << UpBound << "\n";
	NumberOfGenerations = 0;
//		cout << "Old bounds: " << j << "\t" << LowerBoundPerRepetition[j] << "\t" << UpperBoundPerRepetition[j] << "\n";
	if (( UpBound - LowBound) == 2 ) {
		FrequencyToPrint = (Bounds[UpperBoundPerRepetition - 1] + Bounds[LowerBoundPerRepetition])/ 2.0;
		GenerationsAgoin4NeScale = double(double(NumberOfGenerations) / double(2*Ne));
//		cout << "Frequency is in one of the bounds: " << FrequencyToPrint << "\t" << Bounds[LowBound] << "\t" << Bounds[UpBound] << "\n";
		ReducedTrajectories = string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Currentf) )->str() + string("\n");
		TemporalTrajectories = string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Currentf) )->str() + string("\n");

		
//		cout <<  "TRA\t0\t" << CurrentAlleleNumber << "\t" << FrequencyToPrint << "\t" << Ne << endl;
//		cout << "Print TRA: "<< ReducedTrajectories[j] << "\t" << LowerBoundPerRepetition[j] << "\t" << UpperBoundPerRepetition[j] << "\n";
		UpperBoundPerRepetition = UpperBoundPerRepetition - 1;
	}else {
		FrequencyToPrint = (Bounds[UpperBoundPerRepetition] + Bounds[LowerBoundPerRepetition])/ 2.0;
		GenerationsAgoin4NeScale = double(double(NumberOfGenerations) / double(2*Ne));
//		cout << "Frequency is in the middle of the bounds: " << FrequencyToPrint << "\t" << Bounds[LowBound] << "\t" << Bounds[UpBound] << "\n";
		ReducedTrajectories = string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Currentf) )->str() + string("\n");
		TemporalTrajectories = string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Currentf) )->str() + string("\n");
//		cout <<  "TRA\t0\t" << CurrentAlleleNumber << "\t" << FrequencyToPrint << "\t" << Ne << endl;
	}
//			cout << "New Bounds: " << j << "\t" << LowerBoundPerRepetition[j] << "\t" << UpperBoundPerRepetition[j] << "\n";


//	cout << "Lower and Upper Bound Number: " << LowBound << "\t" << UpBound << "\n";
//	cout << "Bounds: " << Bounds[LowBound] << "\t" << Bounds[UpBound] << "\n";
//	return 0;
	

//	AllelesPerGen.push_back( vector<int>() );
	Weights = 0;
	if (SampleFinalGenFlag == 1){
                binomial flipstart(SampleFinalGenPopSize, Currentf);
		CurrentForward = pdf(flipstart,(int) (f * SampleFinalGenPopSize + 0.5) );
		BetaDisUpLimit = boost::math::ibeta((int) (SampleFinalGenPopSize*f + 0.5) + 1, (int) SampleFinalGenPopSize - (int) (SampleFinalGenPopSize*f + 0.5) + 1,Currentf + 0.5/(double) Ne) / (1 - boost::math::ibeta((int) (SampleFinalGenPopSize*f + 0.5) + 1, (int) SampleFinalGenPopSize - (int) (SampleFinalGenPopSize*f + 0.5) + 1,1.5/(double) Ne));
		BetaDisLowLimit = boost::math::ibeta((int) (SampleFinalGenPopSize*f + 0.5) + 1, (int) SampleFinalGenPopSize - (int) (SampleFinalGenPopSize*f + 0.5) + 1,Currentf - 0.5/(double) Ne) / (1 - boost::math::ibeta((int) (SampleFinalGenPopSize*f + 0.5) + 1, (int) SampleFinalGenPopSize - (int) (SampleFinalGenPopSize*f + 0.5) + 1,1.5/(double) Ne));;
		CurrentBackward = BetaDisUpLimit - BetaDisLowLimit;
		cout << "ForwardSampleProb = " << CurrentForward << " BackwardSampleProb = " << CurrentBackward << " Beta low = " << BetaDisLowLimit << " Beta up = " << BetaDisUpLimit << "\n";
                }

	 for (l = 0; l < ( SValuesToCheck.size()); l++) {
		AllWeightsToPrint[l] = 0;
		if (SampleFinalGenFlag == 1){
			AllWeightsToPrint[l] = AllWeightsToPrint[l] + log(CurrentForward) - log(CurrentBackward);
		}
	}
	AllelesInPresentGeneration = CurrentAlleleNumber ;
	TemporalAlleles = CurrentAlleleNumber;
		cout << "Rep = "<< j << " AlleleNumber = " << AllelesInPresentGeneration << " f = " << f << "\n";

		ExitLoopFlag = 0;
//		NumberOfGenerations = 0;
while (ExitLoopFlag == 0){
//	RepRandomNumber = int(rand ());
//	cout << "RepRandNumb: " << RepRandomNumber; 
//	cout << "i: " << i << " RepRand = " << RepRandomNumber << "\n";
	// Create simulation using the Wright-Fisher model.
	// Remember that we start with f frequency and we
	// go backwards.

	NumberOfExtinctTrajectories = 0;
	CumulativeWeight = 0;
	
	Back_sAA = sAA;
	Back_sAa = sAa;
	if ( ( NumberOfGenerations+1 ) < TMax ){
	NeSizesIterator = N_eSizes.begin();
	advance(NeSizesIterator,NumberOfGenerations);
	NeSizesIteratorAfter = N_eSizes.begin();
	advance(NeSizesIteratorAfter,NumberOfGenerations+1);
	SelMultIterator = MultScalars.begin();
	advance(SelMultIterator,NumberOfGenerations);
	}
//	vector<int> AllelesPerGen = BackWrightFisher3(f,sAA,sAa,Ne,RepRandomNumber,Margin,UpperMargin);
//	cout << "Prev sAa = " << sAa << " sAA = " << sAA << "\n";
	if (DistributionTypeS == 1){
	        boost::math::beta_distribution<> beta_dis(DistributionParameter1S,DistributionParameter2S);
                random_uniform_number =  zeroone(real_engine_2);
		Back_sAA = -quantile(beta_dis,random_uniform_number);
		Back_sAA = max(sAa * 2,-1.0);
//		cout << "sAa = " << Back_sAA << " sAA = " << Back_sAA << "\n"; 
	}else if (DistributionTypeS == 2){
		Back_sAA = DistributionParameter1S;
		Back_sAa = DistributionParameter2S;	
//		cout << "sAa = " << Back_sAA << " sAA = " << Back_sAA << "\n";
	}
//	cout << "sAa = " << Back_sAA << " sAA = " << Back_sAA << "\n";
//	cout << "Current f = " << Currentf << " Current Ne = "<< *NeSizesIterator << " Current allele number = " << CurrentAlleleNumber <<  "\n";

	ExitLoopFlag = 1;
	
	/* Delete what is below January 21, 2013 */
	/*	for (k=0; k <=1000; k++) {
		Test = bnldev(Currentf,CurrentNeSizeAfter, &RepRandomNumber);
		ExampleTrajectory << Test << "\n";
	} */
//	return 0;
	/* Delete what is in the upper part January 21, 2013 */
	
	
	// First I should add one random number to each of the vectors  && (AllelesPerGen[j][NumberOfGenerations] == 1)
	if (BaldingModelFlag == 0){
		
		// I should start from this point tomorrow April 29 2014
//			cout << "Rep = " << j <<  " Alleles in present generation = " << AllelesInPresentGeneration[j] << " Ne sizes = " << *NeSizesIterator << "\n";
			
			CurrentNeSizeBefore = *NeSizesIterator;
			CurrentNeSizeAfter = *NeSizesIteratorAfter;
//			ExampleTrajectory << "R: "<< CurrentNeSizeBefore << "\t" << CurrentNeSizeAfter << "\t";
//            cout << "R: "<< CurrentNeSizeBefore << "\t" << CurrentNeSizeAfter << "\n";
			Currentf = double(AllelesInPresentGeneration) / double(CurrentNeSizeBefore);

			Test = 0;
			int PrevGenAlleleNumber = AllelesInPresentGeneration;

//			cout << "BeforeLoopGen = " << AllelesPerGen[j][NumberOfGenerations] << " This Gen = " << Test << "\n";
//			cout << "Repetition = " << j << " Exit Loop Flag = " << ExitLoopFlag << " PrevGen = " << PrevGenAlleleNumber << " Test =" << Test << "\n";
//			while ((Test == 0) && (PrevGenAlleleNumber > 1)) {

//			cout << " Current f = " << Currentf << "\n";

				if (Currentf > 0){
//					cout << "Rep Random Number = " << RepRandomNumber << "\n";
//					RepRandomNumber = rand();
                                       if (( NumberOfGenerations == 0) && (AllelesInPresentGeneration == 1)){
					ThisXPrime = BackWrightFisher4_XPrime(Currentf,Back_sAA* *SelMultIterator,Back_sAa* *SelMultIterator,NumberOfGenerations,RepRandomNumber,Margin,UpperMargin,CurrentNeSizeBefore,CurrentNeSizeAfter,F_Beta,Epsilon);
                                        Test = (int) ( bnldev(ThisXPrime,CurrentNeSizeAfter, &RepRandomNumber) + 0.5 );
					}else if ( NumberOfGenerations == 0 ){
					while (((Test == 0) && (AllelesInPresentGeneration > 1)) ) {
                                        ThisXPrime = BackWrightFisher4_XPrime(Currentf,Back_sAA* *SelMultIterator,Back_sAa* *SelMultIterator,NumberOfGenerations,RepRandomNumber,Margin,UpperMargin,CurrentNeSizeBefore,CurrentNeSizeAfter,F_Beta,Epsilon);
                                        Test = (int) ( bnldev(ThisXPrime,CurrentNeSizeAfter, &RepRandomNumber) + 0.5 );
					}
                                        }
					else{
					while (((Test == 0) && (AllelesInPresentGeneration > 1)) ) {
					
					ThisXPrime = BackWrightFisher4_XPrime(Currentf,Back_sAA* *SelMultIterator,Back_sAa* *SelMultIterator,NumberOfGenerations,RepRandomNumber,Margin,UpperMargin,CurrentNeSizeBefore,CurrentNeSizeAfter,F_Beta,Epsilon);
					Test = (int) ( bnldev(ThisXPrime,CurrentNeSizeAfter, &RepRandomNumber) + 0.5 );
					
					}
					}
				/*	if (NumberOfExtinctTrajectories < 7 ){ 
						cout << Test << "\n";
					
					}
				*/	
//					cout << j << "\t" << Test << "\t" << Currentf << "\t" << RepRandomNumber << "\tXP= " << ThisXPrime << "\n";
					/* Don't forget to remove later what is below January 15, 2013  */

			/*		if (j == 1) {
						ExampleTrajectory << Test << "\n";
					}
					*/
					/* Don't forget to remove later what is in the upper part January 15, 2013  */
					
				}
//				cout << "Repetition = " << j << " Frequency = " << Currentf << " Previous Ne = " << CurrentNeSizeBefore << " Random number = " << RepRandomNumber << "\n";
//				cout << "Went here!!\n";
			

			
//			}
			if (Test > 0){
				ExitLoopFlag = 0;
				NumberOfExtinctTrajectories = NumberOfExtinctTrajectories + 1;
//				cout << j << " = " << Test << " "<< CurrentNeSizeAfter << "\n";
//				cout << " Test = " << Test << " Size = " << CurrentNeSizeBefore << " Current f = " << Currentf << "\n";
//				cout << "Entered Exit Loop Flag\n";
				AfterFrequency = ( double(Test) / double(CurrentNeSizeAfter));
//				cout << "Current frequency: " << AfterFrequency << "\n";
                GenerationsAgoin4NeScale = double(double(NumberOfGenerations + 1) / double(2*Ne));
                ReducedTrajectories = string(ReducedTrajectories) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << AfterFrequency) )->str() + string("\n");
                TemporalTrajectories = string(TemporalTrajectories) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << AfterFrequency) )->str() + string("\n");

				if (AfterFrequency <= Bounds[LowerBoundPerRepetition]){
//					cout << "Lower bound\n";
					FrequencyToPrint = (Bounds[UpperBoundPerRepetition - 1] + Bounds[LowerBoundPerRepetition - 1])/ 2.0;
					GenerationsAgoin4NeScale = double(double(NumberOfGenerations + 1) / double(2*Ne));
/*					ReducedTrajectories[j] = string(ReducedTrajectories[j]) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Test) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << FrequencyToPrint) )->str() +  string("\t") + static_cast<ostringstream*>( &(ostringstream() << CurrentNeSizeAfter) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Bounds[LowerBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Bounds[UpperBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << AfterFrequency) )->str() + " Down" + string("\n");
					TemporalTrajectories[j] = string(TemporalTrajectories[j]) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Test) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << FrequencyToPrint) )->str() +  string("\t") + static_cast<ostringstream*>( &(ostringstream() << CurrentNeSizeAfter) )->str() + string("\t")  + static_cast<ostringstream*>( &(ostringstream() << Bounds[LowerBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Bounds[UpperBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << AfterFrequency) )->str() + " Down" + string("\n");
*/ /*					ReducedTrajectories = string(ReducedTrajectories) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Currentf) )->str() + string("\n");
					TemporalTrajectories = string(TemporalTrajectories) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << FrequencyToPrint) )->str() + string("\n"); */
					LowerBoundPerRepetition = LowerBoundPerRepetition - 1;
					UpperBoundPerRepetition = UpperBoundPerRepetition - 1;
//					return 0;
				}
				else if (AfterFrequency > Bounds[UpperBoundPerRepetition]){
//					cout << "Upper bound\n";
					FrequencyToPrint = (Bounds[UpperBoundPerRepetition + 1] + Bounds[LowerBoundPerRepetition + 1])/ 2.0;
					GenerationsAgoin4NeScale = double(double(NumberOfGenerations + 1) / double(2*Ne));
//					cout << "1: "<< ReducedTrajectories[j];
/*					ReducedTrajectories[j] = string(ReducedTrajectories[j]) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Test) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << FrequencyToPrint) )->str() +  string("\t") + static_cast<ostringstream*>( &(ostringstream() << CurrentNeSizeAfter) )->str() + string("\t")  + static_cast<ostringstream*>( &(ostringstream() << Bounds[LowerBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Bounds[UpperBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << AfterFrequency) )->str() + " Up" + string("\n");
					TemporalTrajectories[j] = string(TemporalTrajectories[j]) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Test) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << FrequencyToPrint) )->str() +  string("\t") + static_cast<ostringstream*>( &(ostringstream() << CurrentNeSizeAfter) )->str() + string("\t")  + static_cast<ostringstream*>( &(ostringstream() << Bounds[LowerBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Bounds[UpperBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << AfterFrequency) )->str() + " Up" + string("\n");
*/ /*					ReducedTrajectories = string(ReducedTrajectories) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Currentf) )->str() + string("\n");
					TemporalTrajectories = string(TemporalTrajectories) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << FrequencyToPrint) )->str() + string("\n"); */
					LowerBoundPerRepetition = LowerBoundPerRepetition + 1;
					UpperBoundPerRepetition = UpperBoundPerRepetition + 1;
//					cout << "2: "<< ReducedTrajectories[j];

				}
			}else {
				if (NoMorePrintFlag == 1){
				GenerationsAgoin4NeScale = double(double(NumberOfGenerations + 1) / double(2*Ne));
/*				ReducedTrajectories[j] = string(ReducedTrajectories[j]) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Test) )->str() + string("\t0") + string("\t") + static_cast<ostringstream*>( &(ostringstream() << CurrentNeSizeAfter) )->str() + string("\t")  + static_cast<ostringstream*>( &(ostringstream() << Bounds[LowerBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Bounds[UpperBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << AfterFrequency) )->str() + string("\n");
				TemporalTrajectories[j] = string(TemporalTrajectories[j]) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Test) )->str() + string("\t0") + string("\t") + static_cast<ostringstream*>( &(ostringstream() << CurrentNeSizeAfter) )->str() + string("\t")  + static_cast<ostringstream*>( &(ostringstream() << Bounds[LowerBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << Bounds[UpperBoundPerRepetition[j]]) )->str() + string("\t") + static_cast<ostringstream*>( &(ostringstream() << AfterFrequency) )->str() + string("\n");
*/				ReducedTrajectories = string(ReducedTrajectories) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + string("\t0") + string("\n");
				TemporalTrajectories = string(TemporalTrajectories) + string("TRA\t") + static_cast<ostringstream*>( &(ostringstream() << GenerationsAgoin4NeScale) )->str() + string("\t") + string("\t0") + string("\n");
				NoMorePrintFlag = 0;
//				cout << " Log Ne = " << log(CurrentNeSizeAfter) << " Weight before = " << Weights[j] << "\n";
				PathYPrime = YPrime(-Back_sAA * *SelMultIterator, -Back_sAa* *SelMultIterator, PrevGenAlleleNumber, CurrentNeSizeBefore);
					//			cout << "Backwards Ne = " << CurrentNeSizeBefore << " YPrime = "<< PathYPrime << " GenPast = "<< Test << " GenFuture = " << PrevGenAlleleNumber << "\n";
				binomial flip2(CurrentNeSizeAfter, PathYPrime);
					//			cout << "Did I got here?\n";
					//			Weights[j] = Weights[j] - log(pdf(flip2,Test));
					
				CurrentBackward = pdf(flip2,Test)/(1);
//				cout << "Final Weight: " << Weights[j] << "\tBackward = " << CurrentBackward << " Test: "<< Test << " YPrime: " << PathYPrime << " Prev Gen: " << PrevGenAlleleNumber <<"\n";
//				Weights[j] = Weights[j] + log(CurrentNeSizeAfter) - log(CurrentBackward);
				Weights = Weights - log(CurrentBackward) + log(CurrentNeSizeAfter);
	                        for (l = 0; l < ( SValuesToCheck.size()); l++) {
        	                        AllWeightsToPrint[l] = AllWeightsToPrint[l] - log(CurrentBackward) + log(CurrentNeSizeBefore);
                	        }
//				cout << "Final Weight: " << Weights[j] << "\tBackward = " << CurrentBackward << " Test: "<< Test << " YPrime: " << PathYPrime << " Prev Gen: " << PrevGenAlleleNumber <<"\n";
//				cout << "After Weight: " << Weights[j] << "\n";
				Ages = NumberOfGenerations;
					if (PrevGenAlleleNumber > 1){
						Weights = 0;
						for (l = 0; l < ( SValuesToCheck.size()); l++) {
							AllWeightsToPrint[l] = 0;
						}
						ZeroWeightFlag = 1;
					}
//				cout << "Weight after = " << Weights[j] << "\t" << j << "\n";	
				}
			}

			

			
			if (Test > 0){
			PathXPrime = XPrime(sAA, sAa, Test, CurrentNeSizeAfter);

//			cout << "Forward Ne = " << CurrentNeSizeAfter << " XPrime = "<< PathXPrime << " GenPast = "<< Test << " GenFuture = " << PrevGenAlleleNumber << "\n";
			binomial flip(CurrentNeSizeBefore, PathXPrime);
//			cout << "Previous weight = " << Weights[j]<< "\t";
//			cout << "Ne = " << CurrentNeSizeBefore << " X prime = " << PathXPrime << " draw future = " << PrevGenAlleleNumber << " Draw past = " << Test <<  " Prob = " << pdf(binomial (CurrentNeSizeBefore, PathXPrime),PrevGenAlleleNumber) << "\n";
//			Weights[j] = Weights[j] + log(pdf(binomial (CurrentNeSizeBefore, PathXPrime),PrevGenAlleleNumber));
			CurrentForward = pdf(binomial (CurrentNeSizeBefore, PathXPrime) ,PrevGenAlleleNumber);
			
			for (l = 0; l < ( SValuesToCheck.size()); l++) {
				PathXPrime = XPrime(SValuesToCheck[l]*2, SValuesToCheck[l], Test, CurrentNeSizeAfter);
				ForwardProbValues[l] = pdf(binomial (CurrentNeSizeBefore, PathXPrime) ,PrevGenAlleleNumber);
			}
//			advance(NeSizesIterator,1);
			PathYPrime = YPrime(-Back_sAA* *SelMultIterator, -Back_sAa * *SelMultIterator, PrevGenAlleleNumber, CurrentNeSizeBefore);
						binomial flip2(CurrentNeSizeAfter, PathYPrime);
//			cout << "Did I got here?\n";
//			Weights[j] = Weights[j] - log(pdf(flip2,Test));
			
			CurrentBackward = pdf(binomial (CurrentNeSizeAfter, PathYPrime),Test)/( 1 - pdf(binomial (CurrentNeSizeAfter, PathYPrime),0));
//			cout << "Backwards Ne = " << CurrentNeSizeBefore << " YPrime = "<< PathYPrime << " GenPast = "<< Test << " GenFuture = " << PrevGenAlleleNumber << " Prob = " << pdf(binomial (CurrentNeSizeAfter, PathYPrime),Test) << "\n";
				Weights = Weights + log(CurrentForward) - log(CurrentBackward);
			for (l = 0; l < ( SValuesToCheck.size()); l++) {
				AllWeightsToPrint[l] = AllWeightsToPrint[l] + log(ForwardProbValues[l]) - log(CurrentBackward);
			}
			/*	if (NumberOfExtinctTrajectories < 7 ){ 
					cout << "Weight = " << Weights[j] << "\n";
					
				}
*/
//			cout << "j = " << j << " Weight = " << Weights[j] << "\n";
//			cout << "j: "<< j << "\t" << PrevGenAlleleNumber << "\t" << Test << "\t" << CurrentForward << "\t" << CurrentBackward << "\t" << Weights[j] << "\n";			
/*			if (CurrentForward > CurrentBackward){
			
			cout << "j = " << j << " Forward = " << CurrentForward << " Backward = " << CurrentBackward << " Ne Before = " << CurrentNeSizeBefore << " Ne After = " << CurrentNeSizeAfter << "\n";
			cout << "Ne Pres = " << CurrentNeSizeBefore << " X prime = " << PathXPrime << " alleles = " << PrevGenAlleleNumber << "\n"; 
			cout << "Ne Past = " << CurrentNeSizeAfter << " Y prime = " << PathYPrime << " alleles = "<< Test << "\n"; 
			return 0;
			}	
				*/
			if ( ( NumberOfGenerations+1 ) < TMax ){
			NeSizesIterator = N_eSizes.begin();
			advance(NeSizesIterator,NumberOfGenerations);
			}
//			int Test = BackWrightFisher4_XPrime(Currentf,Back_sAA,Back_sAa,NumberOfGenerations,RepRandomNumber,Margin,UpperMargin,CurrentNeSize,F_Beta,Epsilon); //= ;
			AllelesInPresentGeneration = Test;
			TemporalAlleles = Test;
//			cout << "Here! Test = " << Test << "\n";
//			cout << "AlleleNumber = "<<AllelesPerGen[j][NumberOfGenerations+1] << " Current Allele Number = "<< AllelesPerGen[j][NumberOfGenerations] << " Currentf = "<< Currentf << " Current Ne = " << *NeSizesIterator << "\n";
//			cout << "Weight = " << Weights[j] << "\n"; if ( (Test == 0) && (PrevGenAlleleNumber >= 1))
//			return 0;
//			cout << "Weight before = " << j << " " << Weights[j] << " Test = "<< Test << " PrevGen " << PrevGenAlleleNumber << " Ne = " << CurrentNeSizeAfter << "\n";
			
			CumulativeWeight = CumulativeWeight + exp(Weights);
//			NormalizedSummedWeights[j] = CumulativeWeight;
			}else {
			AllelesInPresentGeneration = Test;
			TemporalAlleles = Test;
//			cout << "Weight before = " << j << " " << Weights[j] << " Test = "<< Test << " PrevGen " << PrevGenAlleleNumber << " Ne = " << CurrentNeSizeAfter << "\n";
//			Weights[j] = Weights[j] + log(*NeSizesIterator);
//			cout << "Weight after = " << j << " " << Weights[j] << " Test = " << Test << " PrevGen " << PrevGenAlleleNumber<< " j = " << j<< "\n";

			}

			if (Test == CurrentNeSizeAfter){
				AllelesInPresentGeneration = 0;
				TemporalAlleles = 0;
				cout << "Reached frequency one: " << *NeSizesIterator << "\t" << CurrentNeSizeAfter <<"\n";
				Weights = 0;
				for (l = 0; l < ( SValuesToCheck.size()); l++) {
					AllWeightsToPrint[l] = 0;
				}
				ZeroWeightFlag = 1;
				NoMorePrintFlag = 0;
//				return 0;
			}
			
//			cout << "Hi!";
/*			while (Test == *NeSizesIterator){
//			cout << "Here!" << "\n";	
				NeSizesIterator = N_eSizes.begin();
//				cout << "Entered loop Test\n\n";
//				cout << "Previous Test! = " << Test << " Generation Number = " << NumberOfGenerations << "\n";
				while (!AllelesInPresentGeneration.empty())
				{
					AllelesInPresentGeneration.pop_back();
				}
				
				while (!TemporalAlleles.empty())
				{
					TemporalAlleles.pop_back();
				}

				AllelesInPresentGeneration.push_back(int(f * *NeSizesIterator));
				TemporalAlleles.push_back(int(f * *NeSizesIterator));
//				cout << "Allele Number = "<< AllelesPerGen[j][0] << "\n";
//				cout << "\n";
				for (k = 0; k < NumberOfGenerations; k++) {
//					cout << "I am here" << k << "\n";
					
					Currentf = double(AllelesInPresentGeneration[j]) / double(*NeSizesIterator);
					advance(NeSizesIterator,1);
					Test = BackWrightFisher4_XPrime(Currentf,Back_sAA,Back_sAa,k,RepRandomNumber,Margin,UpperMargin,CurrentNeSizeBefore,CurrentNeSizeAfter,F_Beta,Epsilon); //= ;
					AllelesInPresentGeneration[j] = Test;
					TemporalAlleles[j] = Test;
					if (k < 5){
					cout << "Generation " << k << " = " << Currentf << " Allele count = " << AllelesPerGen[j][k] << " Allele count Present Gen = " << AllelesPerGen[j][k+1] << " Ne sizes = " << *NeSizesIterator << " Gen Number = " << NumberOfGenerations << "\n";
					cout << "Back SAA = " << Back_sAA << " Back SAa = " << Back_sAa << "\n";
						return 0;
					}
					if (k == 5){
						return 0;
					}
				}
//				cout << "Test! = " << Test << " Generation Number = " << NumberOfGenerations << "\n";
//				return 0;
			} */
//		return 0;
		
//		return 0;
		}else{
//		cout <<"DB Flag" << "\n";

	}
	
	// Then estimate the weight of each of the vectors
/*	if (NumberOfGenerations == 2) {
		for (j = 0; j< repetitions; j++){
		cout << "j = " << j << " Weight = " << Weights[j] << "\n";
		}
		return 0;
	} */
//	return 0;
//	cout << "Previous Weights\n";

		if (ZeroWeightFlag == 0){
		ExpWeights = exp(Weights);
		for (l = 0; l < ( SValuesToCheck.size()); l++) {
			ExpAllWeights[l] = exp(AllWeightsToPrint[l]);
		}
			if (j == 0){
			NormalizedSummedWeights = exp(Weights);
			}else{
			NormalizedSummedWeights = NormalizedSummedWeights + exp(Weights);
			}
		}else{
		ExpWeights = 0;
		for (l = 0; l < ( SValuesToCheck.size()); l++) {
			ExpAllWeights[l] = 0;
		}
			if (j == 0){
				NormalizedSummedWeights = 0;
			}else{
				NormalizedSummedWeights = NormalizedSummedWeights + 0;
			}
		}
//		cout << NormalizedSummedWeights[j] << "\n";

	

/*	if (NumberOfGenerations == 60449){
		cout << "Final Weights\n";
		for (j = 0; j< repetitions; j++){
			cout << "j = " << j << " Weight = " << Weights[j] << " Exp Weight = " << ExpWeights[j] << " Normalized Weights = " << NormalizedSummedWeights[j] << "\n";
		}
		return 0;
	}
	*/
	
//	ExampleTrajectory << NumberOfGenerations << "\n";
	
	// If it is, then resample the bad paths from some of the other better ones. 
/*	if (NumberOfGenerations == 2000){
	return 0;
	} */
//	cout << "Gen Number = " << NumberOfGenerations << " Extinct Trajectories = "<< NumberOfExtinctTrajectories << "\n";
	NumberOfGenerations++;

/*	if (NumberOfGenerations == 5) {
		return 0;
	}
*/
/*	if (PrintFrequenciesFlag == 1){
	
		if (NumberOfGenerations == PrintFrequenciesAtThisGen){
			outputFrequencies.open(PrintFrequenciesFile.c_str());
			for (j = 0; j < repetitions; j++) {
				outputFrequencies << AllelesInPresentGeneration << "\t" << Weights << endl;
			}
			outputFrequencies.close();
			return 0;
		}
	
	} */
}

	cout << "Final Weights\n";
//	for (j = 0; j< repetitions; j++){
		cout << "j = " << j << " Weight = " << Weights << " Exp Weight = " << ExpWeights << " Normalized Weights = " << NormalizedSummedWeights << "\n";
//		cout << ReducedTrajectories[j];
//		cout << "Last Generation " << j << " value = " << "\n";
//	}
//	return 0;
	
	/*
	
	cout << "Beta path probability = " << PathBetaProbability <<"\n";
	//	AlleleAge.push_back( (int) AllelesPerGen.size() - 1);
	int TestAlleleAge = 0, AlleleTest2;
	AlleleTest2 =  (int) AllelesPerGen.size() - 1;
	double GenerationsAgoin4NeScale = AlleleTest2 / (4*Ne);
	double CurrentFrequency;
	outputTrajectory << "REP\t" << i << endl;
	vector<int>::iterator NeSizesIterator = N_eSizes.begin();
	for(vector<int>::iterator B=AllelesPerGen[0].begin(); B!= AllelesPerGen[0].end();++B){
		//	cout << *p << '\n';
		GenerationsAgoin4NeScale = TestAlleleAge / double(2* Ne);
		CurrentFrequency = *B /double (*NeSizesIterator);
		if (*B != 0){
			outputTrajectory << "TRA" << "\t" << GenerationsAgoin4NeScale << "\t" << *B << "\t"<< CurrentFrequency << "\t" << *NeSizesIterator << endl;
		}
		advance(NeSizesIterator,1);
 		TestAlleleAge = TestAlleleAge + 1;
		AlleleTest2 = AlleleTest2 - 1;
	}
	outputTrajectory << "TOT" << "\t" << TestAlleleAge << endl;
	//	cout << "Test Allele Age: " << TestAlleleAge << "\n";
	// Calculate the forward probability
	
	//	ForwardProb = ForwardProbability(AllelesPerGen,sAA,sAa,Ne);
	
	// Calculate the backward probability
	
	//	ReverseProb = ReverseProbability2(AllelesPerGen,sAA,sAa,Ne);
	//	ReverseProb = ReverseProbability3(AllelesPerGen,sAA,sAa,Ne);
	// Calculate weight
	//	cout<<"i :" <<i << " Forward: " <<ForwardProb << "\n";
	//	cout<<"i :" <<i << " Reverse: " <<ReverseProb << "\n";
	//	LogRatio = Weight(AllelesPerGen,sAA,sAa,Ne); 
	//	LogRatio = log(float(Ne / 2 )) + ForwardProb - ReverseProb;
	//	LogRatio =  log (Ne/2) + ForwardProb - ReverseProb;
	NeSizesIterator = N_eSizes.begin();
	for(vector<int>::iterator p=AllelesPerGen[0].begin(); p!= AllelesPerGen[0].end() - 1;++p){
		//		cout << "Trajectory:"<< *p << "\t";
		XP = XPrime(sAA,sAa, *p, *NeSizesIterator);
		XPrimes.push_back(XP);
		//		cout << XP << "\t";
		YP = YPrime(-Back_sAA,-Back_sAa, *p, *NeSizesIterator);
		YPrimes.push_back(YP);
		//		cout << YP << "\n";
		advance(NeSizesIterator,1);
	}
	
	NeSizesIterator = N_eSizes.begin();
	
	advance(NeSizesIterator, ( (int) AllelesPerGen.size() - 2));
	LogRatio = log(*NeSizesIterator) + PathBetaProbability;
	PrevLogRatio = log(*NeSizesIterator) + MontyWeight(AllelesPerGen[0],sAA,sAa,Ne,XPrimes,YPrimes,N_eSizes);
		cout << "Log ratio! = " << LogRatio << "\n";
	 cout << "Prev Log ratio! = " << PrevLogRatio << "\n";
	 cout << "PathBetaProbability! = " << PathBetaProbability << "\n";
	 cout << "Weight! = " << MontyWeight(AllelesPerGen,sAA,sAa,Ne,XPrimes,YPrimes,N_eSizes) << "\n";
	 cout << "Size! = " << *NeSizesIterator << "\n";
	
	//	ActualRatio = exp(LogRatio);
	//	outputFile << TestAlleleAge << "\t" << ActualRatio << endl;
	//	cout << "Ratio1: " << ActualRatio << " LogRatio: "<< LogRatio <<"\n";
	//	LogRatio = Weight(AllelesPerGen,sAA,sAa,Ne);
	//	ActualRatio = exp(LogRatio);
	//	cout << "Ratio2: " << ActualRatio << " LogRatio: "<< LogRatio <<"\n";
	cout << "Ages = " << AllelesPerGen.size() <<  " Ratios = " << PrevLogRatio << " " << LogRatio << "\n";
	Ratios.push_back(LogRatio);
	PrevRatios.push_back(PrevLogRatio);
	//	cout << "i: " << i << "\n";
	if (i == 0){
		MaximumWRatio = LogRatio;
		//		cout << "Maximum W ratio: " << MaximumWRatio << "\n";
	}
	if (LogRatio > MaximumWRatio){
		MaximumWRatio = LogRatio;
		//		cout << "Max Ratio Here! " << MaximumWRatio <<"\n";
	}
	AlleleAge.push_back(AllelesPerGen.size() - 1);
	CurrentAlleleAge = ActualRatio* ((double) AllelesPerGen.size() - 1);
	//	cout << "Current Allele Age: " << CurrentAlleleAge << "\n";
	//	ExpectedAlleleAge = ExpectedAlleleAge + CurrentAlleleAge;
	//	cout << "Allele age: " << (double) AllelesPerGen.size() << "\n";
	//	cout << "Ratio " << LogRatio << "\n";
	SumW = SumW + ActualRatio;
	TestAge = TestAge + (double) AllelesPerGen.size() - 1;
	while (!XPrimes.empty())
	{
		XPrimes.pop_back();
	}
	while (!YPrimes.empty())
	{
		YPrimes.pop_back();
	}
	
	*/
	
BigW = 0;
ExpectedAlleleAge = 0;
SumW = 0;
// cout << "Numbers and Weight\n";
//	cout << "Number = " << j << "\n";
	outputFile << Ages << "\t" << ExpWeights ;
	for (l = 0; l < ( SValuesToCheck.size()); l++) {
	outputFile << "\t" << ExpAllWeights[l] ;
	}
	outputFile << "\n" ;
	outputTrajectory << "REP\t" << j << endl;
	outputTrajectory << ReducedTrajectories;
	outputTrajectory << "TOT" << "\t" << Ages << endl;

}
	
	outputFile.close();
	outputTrajectory.close();
	

	
//	ExampleTrajectory.close();
	
// Estimate something, like the age of the allele
cout << "Big W value: " << BigW << " SumW: " << SumW <<"\n";
ExpectedAlleleAge = ExpectedAlleleAge /SumW;
cout << "Expected Allele Age: " << ExpectedAlleleAge << "\n";
ExpectedAlleleAgeGeneration = ExpectedAlleleAge / (2*Ne);
cout << "Allele age per gen (4Ne): " << ExpectedAlleleAgeGeneration << "\n";
// Check how well the method performs based on the weights
TestAge = TestAge / repetitions;
cout << "Average Age Test: " << TestAge <<"\n";
TestAge = TestAge / (2*Ne);
cout << "Average Age Test (4Ne): " << TestAge <<"\n";
	
	
}


double MontyWeight (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e, vector<double> XPrimes, vector<double> YPrimes, vector <int> Ne_SizeChanges)
{
	vector<int>::iterator p = AlleleSequence.begin();
	vector<int>::iterator NeChange = Ne_SizeChanges.begin(); 
	double term, term1a, term1b, term2, term3, temp, X, XPrime, NumeratorBinomialCoefficient; 
	int t,tloss,i;
	//	cout << "Calculating Monty Weights\n";
	//	cout << "Number of alleles: " << *p <<"\n";
	NumeratorBinomialCoefficient = 0;
	
	for (i=1; i<=N_e; i++) {
		NumeratorBinomialCoefficient = NumeratorBinomialCoefficient + log(i);
	}
	p = AlleleSequence.begin();
	for (i=1; i<=*p; i++) {
		NumeratorBinomialCoefficient = NumeratorBinomialCoefficient - log(i);
	}
	for (i=1; i<=(N_e- *p); i++) {
		NumeratorBinomialCoefficient = NumeratorBinomialCoefficient - log(i);
	}
	
	
	advance(p,1);
//	printf("\nc1 = %d\n",*p);
	tloss = (int) AlleleSequence.size() - 2;
	printf("tloss = %i\n",tloss);
	p = AlleleSequence.begin();
//	printf("c0 = %d\n",*p);
	advance(p,1);
	vector<double>::iterator d = XPrimes.begin();
	advance(d,1);	
	//	p = XPrimes.begin();
	p = AlleleSequence.begin();
	term1a = *p * log(*d);
//	printf("xp1 = %f log(xp1) = %f c[0] = %i\n",*d, log(*d),*p);
	d = XPrimes.begin();
	advance(d,1);
//	printf("yp1 = %f\n",*d);
//	printf("term1a = %f n0 = %i\n",term1a, N_e);
	term1b = (N_e - *p) * log(1 - *d);
//	printf("term1b = %f\n",term1b);
	d = YPrimes.end();
	vector<double>::reverse_iterator drev = YPrimes.rbegin();
	advance(drev,1);
	advance(NeChange,tloss);
	term3 = log((double) *NeChange) + 
	log(*drev) +
	(*NeChange - 1) * log(1 - *drev);
//	printf("n[tloss] = %i, yp = %f\n",*NeChange,*drev);
//	printf("term3 = %f\n", term3);
	drev = YPrimes.rbegin();
	advance(NeChange,1);
	term2 = *NeChange * log(1 - *drev);
//	printf("n[tloss+1] = %i, yp[tloss] = %f, term2 = %f\n",*NeChange,*drev,term2);
	term = NumeratorBinomialCoefficient + term1a + term1b - term2 - term3;
//	printf("term = %f\n",term);
	p = AlleleSequence.begin();
	advance(p,1);
	
	vector<double>::iterator xpvec = XPrimes.begin();
	vector<double>::iterator ypvec = YPrimes.begin();
	advance(xpvec,1);
	NeChange = Ne_SizeChanges.begin();
	advance(NeChange,1);
	for (t=1;t < tloss; t++){
		advance(xpvec,1);
		temp = *p * log(*xpvec / *ypvec);
		term += temp;
		temp = (*NeChange - *p) * log((1-*xpvec) / (1-*ypvec));
		term += temp;
		if ( (t==1) || (t==2) ) {
//			printf("c[t] = %i xp+1 %f yp-1 %f nt = %i term = %f\n",*p, *xpvec, *ypvec, *NeChange, term);
		}
		advance(ypvec,1);
		advance(p,1);
		advance(NeChange,1);
	}
//	printf("Total Weight = %f\n",term);
	return term;
}

double XPrime (double S_AA, double S_Aa, int AlleleNumber, int N_e){
	double X, XP;
	X = (double) AlleleNumber/ N_e;
		if ((S_AA != 0) && (S_Aa!= 0)){
	XP = (X * (1 + S_AA * X + S_Aa * (1-X)))/ ( 1 + S_AA*X*X + 2*S_Aa*X*(1-X) );
		}else {
			XP = (double) AlleleNumber/ N_e;
		}

	return XP;
}

double YPrime (double S_AA, double S_Aa, int AlleleNumber, int N_e){
	double a, b, c, xp, temp, dis;
	
			if ((S_AA != 0) && (S_Aa!= 0)){
	xp = (double) AlleleNumber / N_e;
	a = S_AA * (1 - xp) - S_Aa * (1 - 2 * xp);
	b = 1 + S_Aa * (1 - 2 * xp);
	c = -xp;
	dis = b * b - 4 * a * c;
	if (dis < 0.0) {
		printf("Problem in yprime, dis = %g\n", dis);
		exit(0);
	}
	else {
		temp = (-b - sqrt(dis))/(2 * a);
		if (temp > 0.0 && temp < 1.0)
			return temp;
		else
			return (-b + sqrt(dis))/(2 * a);
	}
	}
	else {
		xp = (double) AlleleNumber / N_e;
		return xp;
	}

}

long double ForwardProbability (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e)
{	
//	cout<<"a: "<<a << "\n";
	int i, ElementsChecked, PreviousNumbersOfAlleles, NewNumberOfAlleles;
	double X, XPrime;
//	unsigned long long int choose(unsigned long long int n, unsigned long long int k);
	long double CurrentProbability, CurrentLogProbability;
	long double PathProbability;
	cout.precision( 10 );
//	cout << "Test\n";
	ElementsChecked = 0;
	PathProbability = 0;
//cout << "Da fuck: " << PreviousNumbersOfAlleles<<"\n";
vector<int>::reverse_iterator p =AlleleSequence.rbegin();
PreviousNumbersOfAlleles = 0;
	while( p != AlleleSequence.rend()){

		if (ElementsChecked > 0){
		NewNumberOfAlleles = *p;
		PreviousNumbersOfAlleles = *(p - 1);
//		cout <<"X: "<< *p << " Previous: " << PreviousNumbersOfAlleles << " ";
		if (PreviousNumbersOfAlleles > 0){
		X = double(PreviousNumbersOfAlleles) / double(N_e);
		XPrime = (X*(1 + S_AA*X + S_Aa*(1 - X)))/(1 + S_AA*X*X+ 2*S_Aa*X*(1-X));
//		cout << "N: "<< *p << " X: " << X << " X prime: " << XPrime;
		binomial flip(N_e, XPrime);

			//		binomial flip(10, 0.5);

		CurrentProbability = pdf(flip,NewNumberOfAlleles);
//		cout << " Probability: " << CurrentProbability << "\n";
//		CurrentProbability = pdf(flip,5);
		CurrentLogProbability = log(CurrentProbability);
		PathProbability = PathProbability + log(CurrentProbability);
//		cout << "Transition from: " << PreviousNumbersOfAlleles<< " to " << NewNumberOfAlleles << "\n";
//		cout << "Current Probability: " << CurrentProbability << " CurrentLogProb: " << CurrentLogProbability << " PathProb: "<< PathProbability <<" Ne: "<<N_e << " X prime: "<< XPrime << " X: "<<X <<" Allele: "<< PreviousNumbersOfAlleles<< " Elements Checked: " << ElementsChecked << "\n";
}else{
//		cout << "Transition from: " << PreviousNumbersOfAlleles<< " to " << NewNumberOfAlleles << "\n";
		CurrentProbability = 1;
		CurrentLogProbability = log(CurrentProbability);
		PathProbability = PathProbability + log(1);
		X = double(PreviousNumbersOfAlleles) / double(N_e);
		XPrime = (X*(1 + S_AA*X + S_Aa*(1 - X)))/(1 + S_AA*X*X+ 2*S_Aa*X*(1-X));
//		cout << "Current Probability: " << CurrentProbability << " CurrentLogProb: " << CurrentLogProbability << " PathProb: "<< PathProbability <<" Ne: "<<N_e << " X prime: "<< XPrime << " X: "<<X <<" Allele: "<< PreviousNumbersOfAlleles<< " Elements Checked: " << ElementsChecked << "\n";

}
}
//		cout << "Path Prob: " << PathProbability << "\n";
		*p++;
//	cout << "other p " << *p++ << "\n";
	ElementsChecked = ElementsChecked + 1;
	PreviousNumbersOfAlleles = *p;
	}
//	cout << "Path Probability " << PathProbability << "\n";
	return (PathProbability);
}

double Weight (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e)
{	
//	cout<<"a: "<<a << "\n";
	int i, ElementsChecked, PreviousNumbersOfAlleles;
	double X, XPrime, YPrime, RatioXY;
	unsigned long long int choose(unsigned long long int n, unsigned long long int k);
	double CurrentProbability, CurrentLogProbability, CurrentValue, CurrentLogValue;
	double PathProbability;
	int AntepenultimateAllele, PenultimateAllele, LastAllele, FirstAllele, SecondAllele,AlleleNumber;

	vector<int> ForwardWF;

	int TotalSize = ( (int) AlleleSequence.size() - 1);

vector<int>::reverse_iterator p =AlleleSequence.rbegin();
PreviousNumbersOfAlleles = 0;
	while( p != AlleleSequence.rend()){

		AlleleNumber = *p;
//		cout << AlleleNumber << "\n";
		ForwardWF.push_back(AlleleNumber);
		*p++;
	}
	vector<int>::iterator f=ForwardWF.begin();
	cout << "Test :" << *(f + 1) << "Test2:" << *(f + TotalSize) << "\n";
	LastAllele = *(f + TotalSize);
	PenultimateAllele = * (f + (TotalSize - 1));
	SecondAllele = *(f + 2);

	// First term
	PathProbability = log(N_e / 2);

	// Numerator terms

	X = double(PenultimateAllele) / double(N_e);
	XPrime = (X*(1 + S_AA*X + S_Aa*(1 - X)))/(1 + S_AA*X*X+ 2*S_Aa*X*(1-X));
	binomial flip(N_e, XPrime);

			//		binomial flip(10, 0.5);

	PathProbability = log(N_e/2);
	cout << "StartPathProb: " << PathProbability << "\n";
	CurrentProbability = pdf(flip, LastAllele);
	CurrentLogProbability = log(CurrentProbability);
	PathProbability = log(N_e/2) + log(CurrentProbability);
	cout << "Transition from: " << PenultimateAllele<< " to " << LastAllele << "\n";
	cout << "Current Probability: " << CurrentProbability << " CurrentLogProb: " << CurrentLogProbability << " PathProb: "<< PathProbability <<" Ne: "<<N_e << " X prime: "<< XPrime << " X: "<<X << "\n";

	// Denominator terms

	X = double(1) / double(N_e);
	XPrime = (-1*(1+S_Aa-X*2*S_Aa) + sqrt((1+S_Aa-X*2*S_Aa)*(1+S_Aa-X*2*S_Aa) - 4*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa)*(-1*X)))/(2*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa));

	binomial flip2(N_e, XPrime);
//		binomial flip(10, 0.5);
	CurrentProbability = pdf(flip2,0);
	CurrentLogProbability = log(CurrentProbability);
	PathProbability = PathProbability - log(CurrentProbability);

	cout << "Transition from: " << 1<< " to " << 0 << "\n";
	cout << "Current Probability: " << CurrentProbability << " CurrentLogProb: " << CurrentLogProbability << " PathProb: "<< PathProbability <<" Ne: "<<N_e << " X prime: "<< XPrime << " X: "<<1 << "\n";


	X = SecondAllele / double(N_e);
	XPrime = (-1*(1+S_Aa-X*2*S_Aa) + sqrt((1+S_Aa-X*2*S_Aa)*(1+S_Aa-X*2*S_Aa) - 4*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa)*(-1*X)))/(2*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa));

	binomial flip3(N_e, XPrime);
//		binomial flip(10, 0.5);
	CurrentProbability = pdf(flip3,1);
	CurrentLogProbability = log(CurrentProbability);
	PathProbability = PathProbability - log(CurrentProbability);

	cout << "Transition from: " << SecondAllele<< " to " << 1 << "\n";
	cout << "Current Probability: " << CurrentProbability << " CurrentLogProb: " << CurrentLogProbability << " PathProb: "<< PathProbability <<" Ne: "<<N_e << " X prime: "<< XPrime << " X: "<<X << "\n";

	// All the other terms

	for (i = 2; i <= (TotalSize - 1); i++){

		AlleleNumber = *(f + (i - 1));
		X = double(AlleleNumber) / double(N_e);
		XPrime = (X*(1 + S_AA*X + S_Aa*(1 - X)))/(1 + S_AA*X*X+ 2*S_Aa*X*(1-X));
		AlleleNumber = *(f + (i + 1));
		X = double(AlleleNumber) / double(N_e);
		YPrime = (-1*(1+S_Aa-X*2*S_Aa) + sqrt((1+S_Aa-X*2*S_Aa)*(1+S_Aa-X*2*S_Aa) - 4*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa)*(-1*X)))/(2*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa));
		RatioXY = XPrime / YPrime;
		AlleleNumber = *(f + i);
		CurrentValue = pow(RatioXY,AlleleNumber);
		CurrentLogValue = log(CurrentValue);
		PathProbability = PathProbability + CurrentLogValue;
//		cout << "List" << *(f + i) << " Ratio: "<< RatioXY << " AlleleNum: " <<AlleleNumber << " CurrentValue: "<<CurrentValue <<" CurrentLogValue: "<< CurrentLogValue << " PathProb: "<< PathProbability << " XPrime:" << XPrime << " YPrime: " <<YPrime <<"\n";

		
		RatioXY = (1 - XPrime) / ( 1- YPrime);
		AlleleNumber = N_e - *(f + i);
		CurrentValue = pow(RatioXY,AlleleNumber);
		CurrentLogValue = log(CurrentValue);
		PathProbability = PathProbability + CurrentLogValue;
//		cout << "List" << *(f + i) << " Ratio: "<< RatioXY << " AlleleNum: " <<AlleleNumber << " CurrentValue: "<<CurrentValue <<" CurrentLogValue: "<< CurrentLogValue << " PathProb: "<< PathProbability << " XPrime:" << XPrime << " YPrime: " <<YPrime <<"\n";
	}
	cout << "PathProb: " << PathProbability << "\n";
	return (PathProbability);
}




double ReverseProbability (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e)
{
//	cout<<"a: "<<a << "\n";
	int i, ElementsChecked, PreviousNumbersOfAlleles;
	double X, XPrime;
//	unsigned long long int choose(unsigned long long int n, unsigned long long int k);
	double CurrentProbability;
	double PathProbability;

//	cout << "Test\n";
	ElementsChecked = 0;
	PathProbability = 0;
	for(vector<int>::iterator p=AlleleSequence.begin(); p!= AlleleSequence.end();++p){
//	cout <<"X: "<< *p << '\n';
	if (ElementsChecked > 1 ){
		X = double(PreviousNumbersOfAlleles) / double(N_e);
		XPrime = (X*(1 + S_AA*X + S_Aa*(1 - X)))/(1 + S_AA*X*X+ 2*S_Aa*X*(1-X));
		binomial flip(N_e, XPrime);
//		binomial flip(10, 0.5);
		CurrentProbability = pdf(flip,*p);
//		CurrentProbability = pdf(flip,5);
//		cout << "Current Probability: " << CurrentProbability << "Ne: "<<N_e << " X prime: "<< XPrime << " X: "<<X << " Elements Checked: " << ElementsChecked << "\n";
		PathProbability = PathProbability + log(CurrentProbability);
//		cout << "Path Prob: " << PathProbability << "\n";
	}

	ElementsChecked = ElementsChecked + 1;
	PreviousNumbersOfAlleles = *p;
	}
//	cout << "Path Probability " << PathProbability << "\n";
	return (PathProbability);
}

double ReverseProbability2 (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e)
{
//	cout<<"a: "<<a << "\n";
	int i, ElementsChecked, PreviousNumbersOfAlleles, NewNumberOfAlleles;
	double X, XPrime;
//	unsigned long long int choose(unsigned long long int n, unsigned long long int k);
	double CurrentProbability;
	double PathProbability;
	double CurrentLogProbability;
//	cout << "Test\n";
	ElementsChecked = 0;
	PathProbability = 0;
//cout << "Da fuck Reverse: " << PreviousNumbersOfAlleles<<"\n";
//	PreviousNumbersOfAlleles = AlleleSequence.begin();
	for(vector<int>::iterator p=AlleleSequence.begin(); p!= AlleleSequence.end();++p){
//	cout <<"X: "<< *p << '\n';
		if (ElementsChecked == 0){
			PreviousNumbersOfAlleles = *p;
		}else{
		
		X = double(PreviousNumbersOfAlleles) / double(N_e);
		XPrime = (-1*(1+S_Aa-X*2*S_Aa) + sqrt((1+S_Aa-X*2*S_Aa)*(1+S_Aa-X*2*S_Aa) - 4*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa)*(-1*X)))/(2*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa));

		binomial flip(N_e, XPrime);
//		binomial flip(10, 0.5);
		NewNumberOfAlleles = *p;
		CurrentProbability = pdf(flip,NewNumberOfAlleles);
//		cout << " Probability: " << CurrentProbability << "\n";
//		CurrentProbability = pdf(flip,5);
//		cout << "Current Probability: " << CurrentProbability << "Ne: "<<N_e << " X prime: "<< XPrime << " X: "<<X <<" Alleles: "<<PreviousNumbersOfAlleles<< " Elements Checked: " << ElementsChecked << "\n";
		PathProbability = PathProbability + log(CurrentProbability);
		CurrentLogProbability = log(CurrentProbability);
//		cout << "Transition from: " << PreviousNumbersOfAlleles<< " to " << NewNumberOfAlleles << "\n";
//		cout << "Current Probability: " << CurrentProbability << " CurrentLogProb: " << CurrentLogProbability << " PathProb: "<< PathProbability <<" Ne: "<<N_e << " X prime: "<< XPrime << " X: "<<X <<" Allele: "<< PreviousNumbersOfAlleles<< " Elements Checked: " << ElementsChecked << "\n";

//		cout << "Path Prob: " << PathProbability << "\n";
}
	ElementsChecked = ElementsChecked + 1;
	PreviousNumbersOfAlleles = *p;
	}
//	cout << "Path Probability " << PathProbability << "\n";
	return (PathProbability);
}

double ReverseProbability3 (vector<int> AlleleSequence, double S_AA, double S_Aa, int N_e)
{
//	cout<<"a: "<<a << "\n";
	int i, ElementsChecked, PreviousNumbersOfAlleles, NewNumberOfAlleles;
	double X, XPrime;
//	unsigned long long int choose(unsigned long long int n, unsigned long long int k);
	double CurrentProbability;
	double PathProbability;
	double CurrentLogProbability;
//	cout << "Test\n";
	ElementsChecked = 0;
	PathProbability = 0;
//	S_AA = -1*S_AA;
//	S_Aa = -1*S_Aa;
//cout << "Da fuck Reverse: " << PreviousNumbersOfAlleles<<"\n";
//	PreviousNumbersOfAlleles = AlleleSequence.begin();
	for(vector<int>::iterator p=AlleleSequence.begin(); p!= AlleleSequence.end();++p){
//	cout <<"X: "<< *p << '\n';
		if (ElementsChecked == 0){
			PreviousNumbersOfAlleles = *p;
		}else{
		
		X = double(PreviousNumbersOfAlleles) / double(N_e);
		XPrime = (X*(1 + S_AA*X + S_Aa*(1 - X)))/(1 + S_AA*X*X+ 2*S_Aa*X*(1-X));
		binomial flip(N_e, XPrime);
//		binomial flip(10, 0.5);
		NewNumberOfAlleles = *p;
		CurrentProbability = pdf(flip,NewNumberOfAlleles);
//		cout << " Probability: " << CurrentProbability << "\n";
//		CurrentProbability = pdf(flip,5);
//		cout << "Current Probability: " << CurrentProbability << "Ne: "<<N_e << " X prime: "<< XPrime << " X: "<<X <<" Alleles: "<<PreviousNumbersOfAlleles<< " Elements Checked: " << ElementsChecked << "\n";
		PathProbability = PathProbability + log(CurrentProbability);
		CurrentLogProbability = log(CurrentProbability);
//		cout << "Transition from: " << PreviousNumbersOfAlleles<< " to " << NewNumberOfAlleles << "\n";
//		cout << "Current Probability: " << CurrentProbability << " CurrentLogProb: " << CurrentLogProbability << " PathProb: "<< PathProbability <<" Ne: "<<N_e << " X prime: "<< XPrime << " X: "<<X <<" Allele: "<< PreviousNumbersOfAlleles<< " Elements Checked: " << ElementsChecked << "\n";

//		cout << "Path Prob: " << PathProbability << "\n";
}
	ElementsChecked = ElementsChecked + 1;
	PreviousNumbersOfAlleles = *p;
	}
//	cout << "Path Probability " << PathProbability << "\n";
	return (PathProbability);
}


vector<int> BackWrightFisher (double Threshold, double S_AA, double S_Aa, int N_e, int random_seed)
{
//	cout<<"aWF: " <<Threshold << "\n";
	vector<int> BackWF;
	int NumberOfAlleles;
	std::tr1::mt19937 eng;
	NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
	double X, XPrime;
	BackWF.push_back(NumberOfAlleles);
//	cout << "Allele Number2: "<< NumberOfAlleles <<" "<< Threshold <<" "<< N_e << '\n';

	X = Threshold;


//	boost::binomial<> my_binomial(N_e,XPrime);
//std::tr1::minstd_rand gen;
//std::tr1::uniform_int<int> dist(0, 9);
//gen.seed((unsigned int)time(NULL));
//for(int i = 0; i < 10; ++i)
//{
 //  std::cout << dist(gen) << " ";
//}
//std::cout << std::endl;

    int seed = random_seed;
//    mt19937 int_engine(seed);
    ranlux_base_01 real_engine(seed);

int PreviousNumbersOfAlleles = NumberOfAlleles;
while ( NumberOfAlleles  > 0)
{
	XPrime = (X*(1 + S_AA*X + S_Aa*(1 - X)))/(1 + S_AA*X*X+ 2*S_Aa*X*(1-X));
	binomial_distribution<> n(N_e, XPrime);
	NumberOfAlleles = n(real_engine);
	if (NumberOfAlleles == 0){
		if (PreviousNumbersOfAlleles  != 1){
		while (!BackWF.empty())
		{
			BackWF.pop_back();
		}
//		cout << "Again" <<PreviousNumbersOfAlleles <<"\n";
		NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
		PreviousNumbersOfAlleles = NumberOfAlleles;
		}else{
			BackWF.push_back(0);
		}
	}else{
	BackWF.push_back(NumberOfAlleles);
	PreviousNumbersOfAlleles = NumberOfAlleles;
}
	X = double(NumberOfAlleles) / double(N_e);
//    cout << n(real_engine) << " This XP: " << XPrime << " X: " << X <<" N: "<< NumberOfAlleles << "Ne: "<< N_e <<"\n";
    }   
//    test_mean(binomial, "binomial", n*p, n*p*(1-p));

//	cout << "X: " << X << " XPrime: " << XPrime << "\n";
 	for(vector<int>::iterator p=BackWF.begin(); p!= BackWF.end();++p){
//		cout << "Allele Number: "<< *p << '\n';
	}

	return (BackWF);
}

vector<int> BackWrightFisher2 (double Threshold, double S_AA, double S_Aa, int N_e, int random_seed, double Margin, double UpperMargin)
{
//	cout<<"aWF: " <<Threshold << "\n";
	vector<int> BackWF;
	int NumberOfAlleles;
	std::tr1::mt19937 eng;
	NumberOfAlleles = (int ) floor(double(Threshold * N_e) + 0.5);
	double X, XPrime;
	Threshold = NumberOfAlleles / double (N_e);
	BackWF.push_back(0);
	BackWF.push_back(1);
//	cout << "Allele Number2: "<< NumberOfAlleles <<" "<< Threshold <<" "<< N_e << '\n';

	X = double(1) / float(N_e);


//	boost::binomial<> my_binomial(N_e,XPrime);
//std::tr1::minstd_rand gen;
//std::tr1::uniform_int<int> dist(0, 9);
//gen.seed((unsigned int)time(NULL));
//for(int i = 0; i < 10; ++i)
//{
 //  std::cout << dist(gen) << " ";
//}
//std::cout << std::endl;

    int seed = random_seed;
//    mt19937 int_engine(seed);
    ranlux_base_01 real_engine(seed);
int PreviousNumbersOfAlleles = NumberOfAlleles;
//cout << "Threshold: " << Threshold << " Margin: " << Margin << " X: " << X << "\n";
while ( abs(Threshold - X) >= abs(Margin))
{
//	cout << "Inside Loop\n";
	XPrime = (-1*(1+S_Aa-X*2*S_Aa) + sqrt((1+S_Aa-X*2*S_Aa)*(1+S_Aa-X*2*S_Aa) - 4*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa)*(-1*X)))/(2*(S_AA - S_Aa - X*S_Aa + 2*X*S_Aa));
//	cout << "X: "<< X << " XPrime: " << XPrime << "\n";
	binomial_distribution<> n(N_e, XPrime);
	NumberOfAlleles = n(real_engine);
	if (X > UpperMargin){
		while (!BackWF.empty())
		{
			BackWF.pop_back();
		}
//		cout << "Again1 " <<PreviousNumbersOfAlleles <<"\n";
		NumberOfAlleles = (int) double(1);
		PreviousNumbersOfAlleles = NumberOfAlleles;
	}else if (NumberOfAlleles == 0){
		while (!BackWF.empty())
		{
			BackWF.pop_back();
		}
//		cout << "Again2 " <<PreviousNumbersOfAlleles <<"\n";
		NumberOfAlleles = (int) double(1);
		PreviousNumbersOfAlleles = NumberOfAlleles;		
	}
	else{
	BackWF.push_back(NumberOfAlleles);
	PreviousNumbersOfAlleles = NumberOfAlleles;
//	cout << "Test: " << NumberOfAlleles << "\n";
}
	X = double(NumberOfAlleles) / double(N_e);
//    cout << n(real_engine) << " This XP: " << XPrime << " X: " << X <<" N: "<< NumberOfAlleles << "Ne: "<< N_e <<"\n";
    }   
//    test_mean(binomial, "binomial", n*p, n*p*(1-p));
//cout <<"VaWF\n";
//	cout << "X: " << X << " XPrime: " << XPrime << "\n";
 	for(vector<int>::iterator p=BackWF.begin(); p!= BackWF.end();++p){
//		cout << "Allele Number: "<< *p << '\n';
	}

	return (BackWF);
}


vector<int> BackWrightFisher3 (double Threshold, double S_AA, double S_Aa, int N_e, int random_seed, double Margin, double UpperMargin)
{
//	cout<<"aWF: " <<Threshold << "\n";
	vector<int> BackWF;
	int NumberOfAlleles;
	std::tr1::mt19937 eng;
	NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
	double X, XPrime, CurrentProbability, CurrentLogProbability, PathProbability;
//3	cout << "Number of alleles HERE WEY!: " << NumberOfAlleles <<"\n";
	BackWF.push_back(NumberOfAlleles);
//	cout << "Allele Number2: "<< NumberOfAlleles <<" "<< Threshold <<" "<< N_e << '\n';

	X = Threshold;


//	boost::binomial<> my_binomial(N_e,XPrime);
//std::tr1::minstd_rand gen;
//std::tr1::uniform_int<int> dist(0, 9);
//gen.seed((unsigned int)time(NULL));
//for(int i = 0; i < 10; ++i)
//{
 //  std::cout << dist(gen) << " ";
//}
//std::cout << std::endl;

    int seed = random_seed;
//    mt19937 int_engine(seed);
    ranlux_base_01 real_engine(seed);
	cout.precision( 10 );
int PreviousNumbersOfAlleles = NumberOfAlleles;
PathProbability = 0;
while ( NumberOfAlleles  > 0)
{
	XPrime = (-1*(1+S_Aa-X*2*S_Aa) + sqrt((1+S_Aa-X*2*S_Aa)*(1+S_Aa-X*2*S_Aa) - 4*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa)*(-1*X)))/(2*(S_AA - S_Aa - X*S_AA + 2*X*S_Aa));
	binomial_distribution<> n(N_e, XPrime);
	NumberOfAlleles = n(real_engine);
	binomial flip(N_e, XPrime);
	CurrentProbability = pdf(flip,NumberOfAlleles);
	CurrentLogProbability = log(CurrentProbability);
	PathProbability = PathProbability + CurrentLogProbability;
//	cout << "Allele Number: " << NumberOfAlleles << " X: "<<X << " X Prime: " << XPrime << " Prob: " << CurrentProbability<< " LogProb: " << CurrentLogProbability<<"\n";
	if (NumberOfAlleles == 0){
		if (PreviousNumbersOfAlleles  != 1){
		while (!BackWF.empty())
		{
			BackWF.pop_back();
		}
		PathProbability = 0;
//		cout << "Again" <<PreviousNumbersOfAlleles <<"\n";
		NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
		PreviousNumbersOfAlleles = NumberOfAlleles;
		BackWF.push_back(NumberOfAlleles);
		}else{
			BackWF.push_back(0);
		}
	}else if (NumberOfAlleles == N_e){
		while (!BackWF.empty())
		{
			BackWF.pop_back();
		}
//		cout << "Again" <<PreviousNumbersOfAlleles <<"\n";
		NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
		PreviousNumbersOfAlleles = NumberOfAlleles;
		BackWF.push_back(NumberOfAlleles);
		

	}else{
	BackWF.push_back(NumberOfAlleles);
	PreviousNumbersOfAlleles = NumberOfAlleles;
}
	X = double(NumberOfAlleles) / double(N_e);
//    cout << n(real_engine) << " This XP: " << XPrime << " X: " << X <<" N: "<< NumberOfAlleles << "Ne: "<< N_e <<"\n";
    }   
cout << "ReversePathProbability: " << PathProbability<< "\n";
//    test_mean(binomial, "binomial", n*p, n*p*(1-p));

//	cout << "X: " << X << " XPrime: " << XPrime << "\n";
// 	for(vector<int>::iterator p=BackWF.begin(); p!= BackWF.end();++p){
//		cout << *p << '\n';
//	}

	return (BackWF);
}

vector<int> BackWrightFisher4 (double Threshold, double S_AA, double S_Aa, int N_e, int random_seed, double Margin, double UpperMargin, vector <int> Ne_SizeChanges, double F_Beta, double Epsilon)
{
//	cout<<"aWF: " <<Threshold << "\n";
	vector<int> BackWF;
//	vector<double> AllBetaValues, AllXPrimes;
	int NumberOfAlleles;
	double GammaValue_1,GammaValue_2, BetaParam_1, BetaParam_2, random_uniform_number;
	std::tr1::mt19937 eng;
//	std::tr1::mt19937 eng;
	NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
	double X, XPrime, CurrentProbability, CurrentLogProbability, PathProbability, BetaValue, pdfBeta, cdfBeta, quantile50;
	double AlfaDist, BetaDist, BetaBinTerm1, BetaBinTerm2, BetaBinTerm3;
//	cout << "Number of alleles HERE WEY!: " << NumberOfAlleles <<"\n";
	BackWF.push_back(NumberOfAlleles);
//	cout << "Allele Number2: "<< NumberOfAlleles <<" "<< Threshold <<" "<< N_e << '\n';
//	int idum=random_seed;
//	double bnldev(double pp, int n, int *idum);
	X = Threshold;
	int MaximumTime = 100000, GenCounter = 1;
//	boost::binomial<> my_binomial(N_e,XPrime);
//std::tr1::minstd_rand gen;
//std::tr1::uniform_int<int> dist(0, 9);
//gen.seed((unsigned int)time(NULL));
//for(int i = 0; i < 10; ++i)
//{
 //  std::cout << dist(gen) << " ";
//}
//std::cout << std::endl;
//    mt19937 int_engine(seed);
//    ranlux_base_01 real_engine(seed);
	int seed = random_seed;
	//    mt19937 int_engine(seed);
    ranlux_base_01 real_engine(seed);
	
        cout << "RepSeed = " << random_seed<< " seedmem = " << &random_seed << "\n";
	cout.precision( 10 );
int PreviousNumbersOfAlleles = NumberOfAlleles;
PathProbability = 0;
	PathBetaProbability = 0;
	vector<int>::iterator Size_PointerBefore = Ne_SizeChanges.begin();
	vector<int>::iterator Size_PointerAfter = Ne_SizeChanges.begin();
	advance(Size_PointerAfter,1);
	uniform_real<> zeroone(0,1);
	cout << "Start: " << *Size_PointerBefore << " End: " << *Size_PointerAfter << "\n";
	PathBetaProbability = 0;
while ( NumberOfAlleles  > 0)
{
//	cout << "Here! " <<  "\n";
	if ((S_AA != 0) && (S_Aa != 0) && (F_Beta != 0)){
	XPrime = YPrime(-S_AA,-S_Aa, NumberOfAlleles, *Size_PointerBefore);
//		cout << "X Prime 1 = " << XPrime << "\n";
//		BetaParam_1 = ((1-F_Beta)/F_Beta)*XPrime;
//		BetaParam_2 = ((1-F_Beta)/F_Beta)*(1-XPrime);
//		gamma_distribution<> gamma(BetaParam_1);
		random_uniform_number = zeroone(real_engine);
		boost::math::beta_distribution<> beta_dis(((1-F_Beta)/F_Beta)*XPrime,((1-F_Beta)/F_Beta)*(1-XPrime));
		AlfaDist = ((1-F_Beta)/F_Beta)*XPrime;
		BetaDist = ((1-F_Beta)/F_Beta)*(1-XPrime);
		BetaValue = quantile(beta_dis,random_uniform_number);
//		GammaValue_1 = gamma(real_engine);
	//	random_uniform_number = rand();
	//	static uniform_01<>zeroone(eng);
//		random_uniform_number = zeroone(real_engine);
//		cout << "GammaValue1 = " << GammaValue_1 << "\n";
//		gamma_distribution<> gamma2(BetaParam_2);
//		GammaValue_2 = gamma2(real_engine);
//		cout << "GammaValue2 = " << GammaValue_2 << "\n";
//		cout << "Pre X Prime = " << XPrime << "\n";
//		XPrime = GammaValue_1 / (GammaValue_1 + GammaValue_2);
//		cout << "Gen counter = " << GenCounter << "\n";
/*		PathBetaProbability = PathBetaProbability + log ( cdf(beta_dis,min(BetaValue + Epsilon, 1.0)) - cdf(beta_dis,max(BetaValue - Epsilon, 0.0) )); 
*/		
		if (GenCounter == 1) {
//			cout << "Gen1 !!!!!!!!!!!!!!" << "\n";
//			pdfBeta = pdf(beta_dis,BetaValue);
//			cdfBeta = cdf(beta_dis,BetaValue);
//			cout << "Beta Value = " << XPrime << "\n";
//			cout << "pdf = " << pdfBeta << " cdf = " << cdfBeta << "\n";
//			PathBetaProbability = PathBetaProbability + log ( cdf(beta_dis,BetaValue + Epsilon) - cdf(beta_dis,BetaValue - Epsilon ));
//			cout << "cdf+ = " << PathBetaProbability << "\n";
//			pdfBeta = cdf(beta_dis,BetaValue - Epsilon);
//			quantile50 = quantile(beta_dis, 0.5);
//			cout << "quantile 50 = " << quantile50 << "\n";
//			quantile50 = mean(beta_dis);
//			cout << "mean = " << quantile50 << "\n";
//			quantile50 = mode(beta_dis);
//			cout << "mode = " << quantile50 <<  "\n";
//			cout << "X Prime = " << XPrime << "\n";
//			cout << "cdf- = " << pdfBeta << "\n";
//			cout << "Random Number = " << random_uniform_number << "\n";
			
		}
//		AllBetaValues.push_back(BetaValue);
//		AllXPrimes.push_back(XPrime);
		XPrime = BetaValue;
//		BackWF.push_back(NumberOfAlleles);
//		cout << "XPrime Gamma = " << XPrime << "\n";
	}else if (F_Beta != 0){
	XPrime = double(NumberOfAlleles) / double(*Size_PointerBefore);
//        BetaParam_1 = ((1-F_Beta)/F_Beta)*XPrime;
//        BetaParam_2 = ((1-F_Beta)/F_Beta)*(1-XPrime);
//        gamma_distribution<> gamma(BetaParam_1);
//        GammaValue_1 = gamma(real_engine);
//        gamma_distribution<> gamma2(BetaParam_2);
//        GammaValue_2 = gamma2(real_engine);
//        XPrime = GammaValue_1 / (GammaValue_1 + GammaValue_2);
	random_uniform_number = zeroone(real_engine);
	boost::math::beta_distribution<> beta_dis(((1-F_Beta)/F_Beta)*XPrime,((1-F_Beta)/F_Beta)*(1-XPrime));
	AlfaDist = ((1-F_Beta)/F_Beta)*XPrime;
        BetaDist = ((1-F_Beta)/F_Beta)*(1-XPrime);

	BetaValue = quantile(beta_dis,random_uniform_number);
/*	PathBetaProbability = PathBetaProbability + log ( cdf(beta_dis,min(BetaValue + Epsilon, 1.0)) - cdf(beta_dis,max(BetaValue - Epsilon, 0.0) ));
*/	if (GenCounter == 1) {
//	cout << "Random Number = " << random_uniform_number << "\n";
	} 
//	cout << "Random Number = " << random_uniform_number << "\n";
//	cout << "XPrime Gamma = " << XPrime << "\n";
//	AllBetaValues.push_back(BetaValue);
//	AllXPrimes.push_back(XPrime);
	XPrime = BetaValue; 
	}else if ((S_AA != 0) && (S_Aa != 0)){
	XPrime = YPrime(-S_AA,-S_Aa, NumberOfAlleles, *Size_PointerBefore);
	}
	else{
	XPrime = double(NumberOfAlleles) / double(*Size_PointerBefore);
	}

//	binomial_distribution<> n(*Size_PointerAfter, XPrime);
//	printf("Y prime = %f s1t = %f s2t = %f j = %i ne = %d ",XPrime,-S_AA,-S_Aa,NumberOfAlleles, *Size_PointerBefore);
	
	//// Calculate the probability of the path going backwards /////	
//	NumberOfAlleles = bnldev(XPrime,*Size_PointerAfter, &random_seed);
	if (F_Beta != 0){
	PathBetaProbability = PathBetaProbability + beta_binomial_pdf(NumberOfAlleles, AlfaDist, BetaDist, *Size_PointerAfter);
/*	BetaBinTerm1 = (Gamma (*Size_PointerAfter + 1) / ( Gamma(NumberOfAlleles + 1) * Gamma(*Size_PointerAfter - NumberOfAlleles + 1) ));
	BetaBinTerm2 = ( Gamma (NumberOfAlleles + AlfaDist) * Gamma(*Size_PointerAfter - NumberOfAlleles + BetaDist) )/ Gamma(*Size_PointerAfter + AlfaDist + BetaDist);
	BetaBinTerm3 = Gamma(AlfaDist + BetaDist) / (Gamma(AlfaDist) * Gamma(BetaDist));
//	BetaBinTerm1 = Gamma(3);
	PathBetaProbability = PathBetaProbability + (BetaBinTerm1 * BetaBinTerm2 * BetaBinTerm3); */
//	cout << "Beta Path = " << PathBetaProbability << ", Allele Copies = "<< NumberOfAlleles << ", SizeOfThings = " << *Size_PointerAfter << ", Alfa = " << AlfaDist << ", Beta = "<< BetaDist<< "\n";
	}
//	binomial flip(N_e, XPrime);
//	CurrentProbability = pdf(flip,NumberOfAlleles);
//	CurrentLogProbability = log(CurrentProbability);
//	PathProbability = PathProbability + CurrentLogProbability;
	X =  double(NumberOfAlleles) / double(*Size_PointerAfter);
//	printf("t = %d ttot = %d ne[t] = %d\n",GenCounter, NumberOfAlleles,*Size_PointerAfter);
//	cout << "Allele Number: " << NumberOfAlleles << " X: "<<X << " X Prime: " << XPrime << " Prob: " << CurrentProbability<< " LogProb: " << CurrentLogProbability<<"\n";
	if (NumberOfAlleles == 0){
		if (PreviousNumbersOfAlleles  != 1){
		while (!BackWF.empty())
		{
			BackWF.pop_back();
		}
/*                while (!AllXPrimes.empty())
                {
                        AllXPrimes.pop_back();
                }
                while (!AllBetaValues.empty())
                {
                        AllBetaValues.pop_back();
                } */
//		cout << "Repeat!\n";
		PathProbability = 0;
		PathBetaProbability = 0;
//		cout << "Again" <<PreviousNumbersOfAlleles <<"\n";
		NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
		PreviousNumbersOfAlleles = NumberOfAlleles;
		BackWF.push_back(NumberOfAlleles);
			GenCounter = 1;
			Size_PointerBefore = Ne_SizeChanges.begin();
			Size_PointerAfter = Ne_SizeChanges.begin();
                        advance(Size_PointerAfter,1);
		}else{
			BackWF.push_back(0);
			GenCounter++;
//			cout << "Repeat!\n";
	//		vector<double>::iterator AllXPrimesPointer = AllXPrimes.begin();
//			double PathProbability2;
//			for(vector<double>::iterator BetaPointer=AllBetaValues.begin(); BetaPointer != AllBetaValues.end();++BetaPointer){
	//			boost::math::beta_distribution<> beta_dis(((1-F_Beta)/F_Beta)* *AllXPrimesPointer,((1-F_Beta)/F_Beta)*(1- *AllXPrimesPointer));
	//			PathBetaProbability = PathBetaProbability + log ( cdf(beta_dis,min(*BetaPointer + Epsilon, 1.0)) - cdf(beta_dis,max(*BetaPointer - Epsilon, 0.0) ));	
//				advance(AllXPrimesPointer,1);
//			}
		}
	}else if (X == 1.0){
		while (!BackWF.empty())
		{
			BackWF.pop_back();
		}
            /*    while (!AllXPrimes.empty())
                {
                        AllXPrimes.pop_back();
                }
                while (!AllBetaValues.empty())
                {
                        AllBetaValues.pop_back();
                } */
//		cout << "Repeat!\n";
		GenCounter = 1;
		PathBetaProbability = 0;
//		cout << "Again" <<PreviousNumbersOfAlleles <<"\n";
		NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
		PreviousNumbersOfAlleles = NumberOfAlleles;
		BackWF.push_back(NumberOfAlleles);
		Size_PointerBefore = Ne_SizeChanges.begin();
		Size_PointerAfter = Ne_SizeChanges.begin();
                advance(Size_PointerAfter,1);
	}else{
	BackWF.push_back(NumberOfAlleles);
	GenCounter++;
	PreviousNumbersOfAlleles = NumberOfAlleles;
        advance(Size_PointerAfter,1);
        advance(Size_PointerBefore,1);
}
//	X = double(NumberOfAlleles) / double(*Size_PointerAfter);
//	advance(Size_PointerAfter,1);
//	advance(Size_PointerBefore,1);
//    cout << n(real_engine) << " This XP: " << XPrime << " X: " << X <<" N: "<< NumberOfAlleles << "Ne: "<< N_e <<"\n";
    }   
//cout << "ReversePathProbability: " << PathProbability<< "\n";
//    test_mean(binomial, "binomial", n*p, n*p*(1-p));

//	cout << "X: " << X << " XPrime: " << XPrime << "\n";
// 	for(vector<int>::iterator p=BackWF.begin(); p!= BackWF.end();++p){
//		cout << *p << '\n';
//	}
//	cout << "Total Beta Path Probability = " << PathBetaProbability << "\n";
	return (BackWF);
}


double BackWrightFisher4_XPrime (double CurrentF, double S_AA, double S_Aa, int GenNumber, int random_seed, double Margin, double UpperMargin, int CurrentNeSizeBefore, int CurrentNeSizeAfter, double F_Beta, double Epsilon)
{
//	return 8;
	int BackWF;
	int NumberOfAlleles;
	double GammaValue_1,GammaValue_2, BetaParam_1, BetaParam_2, random_uniform_number;
	std::tr1::mt19937 rng (random_seed);
	double X, XPrime, CurrentProbability, CurrentLogProbability, PathProbability, BetaValue, pdfBeta, cdfBeta, quantile50;
	double AlfaDist, BetaDist, BetaBinTerm1, BetaBinTerm2, BetaBinTerm3;
//	BackWF.push_back(NumberOfAlleles);
	X = CurrentF;
	int MaximumTime = 100000, GenCounter = 1;
	int seed = random_seed;
    ranlux_base_01 real_engine(seed);
//	cout << "Random seed = " << random_seed << "\n";
//	cout << "RepSeed = " << random_seed<< " seedmem = " << &random_seed << "\n";
	cout.precision( 10 );

	PathProbability = 0;
	PathBetaProbability = 0;

	NumberOfAlleles = (int) floor(double(CurrentF * CurrentNeSizeBefore + 0.5));
	int PreviousNumbersOfAlleles = NumberOfAlleles;
	int PastGenNumbersOfAlleles = PreviousNumbersOfAlleles;
	uniform_real<> zeroone(0,1);
//	cout << "Start: " << *Size_PointerBefore << " End: " << *Size_PointerAfter << "\n";
	PathBetaProbability = 0;
//	cout << "PrevNumberOfAlleles = " << PastGenNumbersOfAlleles << " NumberOfAlleles = " << NumberOfAlleles << "\n";
//	while(PastGenNumbersOfAlleles > 1000000){
		//	cout << "Here! " <<  "\n";
		if ((S_AA != 0) && (S_Aa != 0) && (F_Beta != 0)){
			XPrime = YPrime(-S_AA,-S_Aa, NumberOfAlleles, CurrentNeSizeBefore);

			random_uniform_number = zeroone(real_engine);
			boost::math::beta_distribution<> beta_dis(((1-F_Beta)/F_Beta)*XPrime,((1-F_Beta)/F_Beta)*(1-XPrime));
			AlfaDist = ((1-F_Beta)/F_Beta)*XPrime;
			BetaDist = ((1-F_Beta)/F_Beta)*(1-XPrime);
			BetaValue = quantile(beta_dis,random_uniform_number);
			if (GenCounter == 1) {
			}
			XPrime = BetaValue;
		}else if (F_Beta != 0){
			XPrime = double(NumberOfAlleles) / double(CurrentNeSizeBefore);
			random_uniform_number = zeroone(real_engine);
			boost::math::beta_distribution<> beta_dis(((1-F_Beta)/F_Beta)*XPrime,((1-F_Beta)/F_Beta)*(1-XPrime));
			AlfaDist = ((1-F_Beta)/F_Beta)*XPrime;
			BetaDist = ((1-F_Beta)/F_Beta)*(1-XPrime);
			
			BetaValue = quantile(beta_dis,random_uniform_number);
			if (GenCounter == 1) {
			 }
			XPrime = BetaValue; 
		}else if ((S_AA != 0) && (S_Aa != 0)){
			XPrime = YPrime(-S_AA,-S_Aa, NumberOfAlleles, CurrentNeSizeBefore);
		}
		else{
			XPrime = double(NumberOfAlleles) / double(CurrentNeSizeBefore);
		}
		//// Calculate the probability of the path going backwards /////
//		cout << "Another random seed print = " << random_seed << "\n";
//		NumberOfAlleles = bnldev(XPrime,CurrentNeSizeAfter, &random_seed);
//		std::tr1::binomial_distribution<> roll(CurrentNeSizeAfter, XPrime);
//		boost::variate_generator<boost::mt19937&, boost::binomial<> > next value (rng,binomial);
//		NumberOfAlleles = roll(rng);
//		cout << "X Prime: " << XPrime << " NumberOfAlleles: " << NumberOfAlleles << " Past Number of alleles: " << PastGenNumbersOfAlleles << " Current size after: "<< CurrentNeSizeAfter << " RepSeed = " << random_seed<< " seedmem = " << &random_seed << "\n";

/*		if (F_Beta != 0){
			PathBetaProbability = PathBetaProbability + beta_binomial_pdf(NumberOfAlleles, AlfaDist, BetaDist, CurrentNeSizeAfter);
		}
		X =  double(NumberOfAlleles) / double(CurrentNeSizeAfter);
 */
/*		if (NumberOfAlleles == 0){
			if (PreviousNumbersOfAlleles  != 1){
//				cout << "Repeat!\n";
				PathProbability = 0;
				PathBetaProbability = 0;
				NumberOfAlleles = floor(double(Threshold * CurrentNeSize));
				PreviousNumbersOfAlleles = NumberOfAlleles;
				BackWF = NumberOfAlleles;
				GenCounter = 1;

			}else{
				BackWF = 0;
				GenCounter++;
//				cout << "Repeat!\n";
			}
		}else if (X == 1.0){
//			cout << "Repeat!\n";
			GenCounter = 1;
			PathBetaProbability = 0;
			NumberOfAlleles = floor(double(Threshold * CurrentNeSize));
			PreviousNumbersOfAlleles = NumberOfAlleles;
			BackWF = NumberOfAlleles;

		}else{
			BackWF = NumberOfAlleles;
			GenCounter++;
			PreviousNumbersOfAlleles = NumberOfAlleles;
		} */
//	}
//	cout << "Now = PrevNumberOfAlleles = " << PastGenNumbersOfAlleles << " NumberOfAlleles = " << NumberOfAlleles << "\n";
	return (XPrime);
}

vector<int> BackWrightFisherBD (double Threshold, double S_AA, double S_Aa, int N_e, int random_seed, double Margin, double UpperMargin)
{
//	cout<<"aWF: " <<Threshold << "\n";
	vector<int> BackWF;
	int NumberOfAlleles;
	double GammaValue_1,GammaValue_2, BetaParam_1, BetaParam_2, F;
	std::tr1::mt19937 eng;
	NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
	double X, XPrime, CurrentProbability, CurrentLogProbability, PathProbability;
//3	cout << "Number of alleles HERE WEY!: " << NumberOfAlleles <<"\n";
	BackWF.push_back(NumberOfAlleles);
//	cout << "Allele Number2: "<< NumberOfAlleles <<" "<< Threshold <<" "<< N_e << '\n';

	X = Threshold;
 
//	boost::binomial<> my_binomial(N_e,XPrime);
//std::tr1::minstd_rand gen;
//std::tr1::uniform_int<int> dist(0, 9);
//gen.seed((unsigned int)time(NULL));
//for(int i = 0; i < 10; ++i)
//{
 //  std::cout << dist(gen) << " ";
//}
//std::cout << std::endl;

    int seed = random_seed;
//    mt19937 int_engine(seed);
    ranlux_base_01 real_engine(seed);
	cout.precision( 15 );
int PreviousNumbersOfAlleles = NumberOfAlleles;
PathProbability = 0;
F = 1/double(N_e);
while ( NumberOfAlleles  > 0)
{
	XPrime = (X*(1 + S_AA*X + S_Aa*(1 - X)))/(1 + S_AA*X*X+ 2*S_Aa*X*(1-X));
//	binomial_distribution<> n(N_e, XPrime);
//	NumberOfAlleles = n(real_engine);
//	XPrime = double(NumberOfAlleles) / double(N_e);
	cout << "First X Prime: " <<XPrime << "\n";
	BetaParam_1 = ((1-F)/F)*XPrime;
	BetaParam_2 = ((1-F)/F)*(1-XPrime);
	gamma_distribution<> gamma(BetaParam_1);
	GammaValue_1 = gamma(real_engine);
	gamma_distribution<> gamma2(BetaParam_2);
	GammaValue_2 = gamma2(real_engine);
	XPrime = GammaValue_1 / (GammaValue_1 + GammaValue_2);
	cout << "GammaValue_1: " << GammaValue_1 << " GammaValue_2: " << GammaValue_2 << "\n";
	binomial_distribution<> n2(N_e, XPrime);
	NumberOfAlleles = n2(real_engine);
	binomial flip(N_e, XPrime);
	CurrentProbability = pdf(flip,NumberOfAlleles);
	CurrentLogProbability = log(CurrentProbability);
	PathProbability = PathProbability + CurrentLogProbability;
	cout << "Allele Number: " << NumberOfAlleles << " X: "<<X << " X Prime: " << XPrime << " Prob: " << CurrentProbability<< " LogProb: " << CurrentLogProbability<<" Current Path: " << PathProbability << "\n";
	if (NumberOfAlleles == 0){
		if (PreviousNumbersOfAlleles  != 1){
		while (!BackWF.empty())
		{
			BackWF.pop_back();
		}
		PathProbability = 0;
//		cout << "Again" <<PreviousNumbersOfAlleles <<"\n";
		NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
		PreviousNumbersOfAlleles = NumberOfAlleles;
		BackWF.push_back(NumberOfAlleles);
		}else{
			BackWF.push_back(0);
		}
	}else if (NumberOfAlleles == N_e){
		while (!BackWF.empty())
		{
			BackWF.pop_back();
		}
//		cout << "Again" <<PreviousNumbersOfAlleles <<"\n";
		NumberOfAlleles = (int) floor(double(Threshold * N_e) + 0.5);
		PreviousNumbersOfAlleles = NumberOfAlleles;
		BackWF.push_back(NumberOfAlleles);
		

	}else{
	BackWF.push_back(NumberOfAlleles);
	PreviousNumbersOfAlleles = NumberOfAlleles;
}
	X = double(NumberOfAlleles) / double(N_e);
//    cout << n(real_engine) << " This XP: " << XPrime << " X: " << X <<" N: "<< NumberOfAlleles << "Ne: "<< N_e <<"\n";
    }   
//cout << "ReversePathProbability: " << PathProbability<< "\n";
//    test_mean(binomial, "binomial", n*p, n*p*(1-p));

//	cout << "X: " << X << " XPrime: " << XPrime << "\n";
// 	for(vector<int>::iterator p=BackWF.begin(); p!= BackWF.end();++p){
//		cout << *p << '\n';
//	}
	return (BackWF);
}

vector<int> SampleFromList (vector <double> NormalizedList)
{
	vector <int> List; 
	double SumList = NormalizedList[NormalizedList.size() - 1];
//	cout << "Sum list = " << SumList << "\n";
//	cout << "Length of list = " << NormalizedList.size() << "\n";
	int i_counter, j_counter;
	vector <double>::iterator Index;
	vector <double> TemporalList;
//	cout << "Previous weights\n";
	for (i_counter = 0; i_counter < NormalizedList.size() ; i_counter++){	
//		cout << NormalizedList[i_counter] << "\n";
//		TemporalList.push_back(NormalizedList[i_counter]);
	}
//	return 0;
/*	for (i_counter = 0; i_counter < NormalizedList.size() ; i_counter++){
		for (j_counter = 0; j_counter < i_counter; j_counter++) {
			NormalizedList[i_counter] = NormalizedList[i_counter] + TemporalList[j_counter];
		}
		cout << "Summed weight = " << NormalizedList[i_counter] << "\n";
	}
	*/
	for (i_counter = 0; i_counter < NormalizedList.size() ; i_counter++){
		double r2 = static_cast <double> (rand()) / (static_cast <double> (RAND_MAX/SumList));
//		cout << "Random number " << i_counter << " = " << r2;
		Index = lower_bound(NormalizedList.begin(), NormalizedList.end(), r2);
//		cout << " Position = " << (Index - NormalizedList.begin()) << "\n";
		List.push_back(Index - NormalizedList.begin());
	}
	
	
	
	return (List);

}

void test_mean(int TestRepetition, int ThisSeed)
{	
	int i, BinomialSum, ToSum;
	int N = 10000;
	double p = 0.5;
    int seed = ThisSeed;
    double ActualMean;
//    mt19937 int_engine(seed);
//    ranlux_base_01 real_engine(seed);

		binomial_distribution<> n(N, p);

	for (i = 0; i < TestRepetition; i ++){

/*		ToSum = n(real_engine); */
		BinomialSum = BinomialSum + ToSum;
	}
	BinomialSum = BinomialSum / TestRepetition;
	ActualMean = N * p;
//	cout << "BinomialSum: " << BinomialSum << "\n";
//	cout << "ActualMean: " << ActualMean << "\n";
}


// Knuth's the Art of Computer Programming
unsigned long long int choose(unsigned long long int n, unsigned long long int k) {
    if (k > n) {
        return 0;
    }
    unsigned long long r = 1;
    for (unsigned long long d = 1; d <= k; ++d) {
        r *= n--;
        r /= d;
    }
    return r;
}



#define IA 16807
#define IM 2147483647
#define AM (1.0/IM)
#define IQ 127773
#define IR 2836
#define NTAB 32
#define NDIV (1+(IM-1)/NTAB)
#define EPS 1.2e-7
#define RNMX (1.0-EPS)
#define PI 3.141592654

double bnldev(double pp, int n, int *idum)
{
	double gammln(double xx);
	double ran1(int *idum);
//	cout << "idum value = " << *idum << "\n";
	int j;
	static int nold=(-1);
	double am,em,g,angle,p,bnl,sq,t,y;
	static double pold=(-1.0),pc,plog,pclog,en,oldg;
	
	p=(pp <= 0.5 ? pp : 1.0-pp);
	am=n*p;
	if (n < 25) {
		bnl=0.0;
		for (j=1;j<=n;j++)
			if (ran1(idum) < p) ++bnl;
	} else if (am < 1.0) {
		g=exp(-am);
		t=1.0;
		for (j=0;j<=n;j++) {
			t *= ran1(idum);
			if (t < g) break;
		}
		bnl=(j <= n ? j : n);
	} else {
		if (n != nold) {
			en=n;
			oldg=gammln(en+1.0);
			nold=n;
		} if (p != pold) {
			pc=1.0-p;
			plog=log(p);
			pclog=log(pc);
			pold=p;
		}
		sq=sqrt(2.0*am*pc);
		do {
			do {
//				cout << "And idum value = " << *idum << "\n";
				angle=PI*ran1(idum);
//				cout << "After loop idum value = " << *idum << "\n";
				y=tan(angle);
				em=sq*y+am;
			} while (em < 0.0 || em >= (en+1.0));
			em=floor(em);
			t=1.2*sq*(1.0+y*y)*exp(oldg-gammln(em+1.0)
								   -gammln(en-em+1.0)+em*plog+(en-em)*pclog);
		} while (ran1(idum) > t);
		bnl=em;
	}
//	cout << "Still, idum value = " << *idum << "\n";
	if (p != pp) bnl=n-bnl;
	return bnl;
}

double gammln(double xx)
{
	double x,y,tmp,ser;
	static double cof[6]={76.18009172947146,-86.50532032941677,
		24.01409824083091,-1.231739572450155,
		0.1208650973866179e-2,-0.5395239384953e-5};
	int j;
	
	y=x=xx;
	tmp=x+5.5;
	tmp -= (x+0.5)*log(tmp);
	ser=1.000000000190015;
	for (j=0;j<=5;j++) ser += cof[j]/++y;
	return -tmp+log(2.5066282746310005*ser/x);
}

double ran1(int *idum)  {
	int j;
	int k;
	static int iy=0;
	static int iv[NTAB];
	double temp;
	
	if (*idum <= 0 || !iy) {
		if (-(*idum) < 1) *idum=1;
		else *idum = -(*idum);
		for (j=NTAB+7;j>=0;j--) {
			k=(*idum)/IQ;
			*idum=IA*(*idum-k*IQ)-IR*k;
			if (*idum < 0) *idum += IM;
			if (j < NTAB) iv[j] = *idum;
		}
		iy=iv[0];
	}
	k=(*idum)/IQ;
	*idum=IA*(*idum-k*IQ)-IR*k;
	if (*idum < 0) *idum += IM;
	j=iy/NDIV;
	iy=iv[j];
	iv[j] = *idum;
	if ((temp=AM*iy) > RNMX) return RNMX;
	else return temp;
}



/*
 template <typename TDistribution>
 double sample_mean(TDistribution dist, int sample_size = 10000)
 {
 std::tr1::mt19937 mt; // Mersenne Twister generator
 double sum = 0;
 for (int i = 0; i < sample_size; ++i)
 sum += dist(mt);
 return sum / sample_size;
 }
 
 template <typename TDistribution>
 void test_mean(TDistribution dist, std::string name, double true_mean, double true_variance)
 {
 double true_stdev = sqrt(true_variance);
 std::cout << "Testing " << name << " distribution\n";
 int sample_size = 10000;
 double mean = sample_mean(dist, sample_size);
 std::cout << "Computed mean: " << mean << "\n";
 double lower = true_mean - true_stdev/sqrt((double)sample_size);
 double upper = true_mean + true_stdev/sqrt((double)sample_size);
 std::cout << "Expected a value between " << lower << " and " << upper << "\n\n";
 }
 
 */



