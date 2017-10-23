/* KEL; 10/19/06 */
/* This program will do Wright Fisher forward simulations */
/* A linked-list structure is employed where each mutation is a node in the list */
/* 		       Input parameters: */
/*        pop size, num epochs, num gen, theta */


/* This program is like "fwd_sim_sel_clust_epoc.c" except it also will take a specified sample of sets of individuals, output the number of snps in each individual, and then output the selection coefficients for the sample */

//this program will also use a log-normal distribution of selective effects:



/*UPDATE
/
/ 1/26/07: draw h from beta distribution; gamma from new, updated log-normal
/ don't subtract # fixed diffs from # het genotypes/indv.
/
/1/28/07: changed floats to doubles, use GSL for all random number generation;
*/



/*UPDATE
/
/
/This code has been updated in June 2012.  Only features that have changed relate to the output
/Two different output functions:
/	/1) full_output() This one outputs all teh summary info for each snp: 1) pop freq 2) s 3) age.  This one will be called at the end of the ismulation

	/2) short_output() This one will only output the number of SNPs, average MAF, average s, freq. weighted s.  This will be a good one to call every few generations to see how things change over time
*/

/*UPDATE: use this version to help debug why it won't run on Bruin or linux machines.....March 2014*/


//UPDATE 2: May 5, 2014
/*This version now runs on Linux and on bruin! YAY! Here, I'm also including inbreeding and domiance. INbreeding is being accounted for by 1) taking in an F, 2) adjusting the Ns for this value of F, 3) using F in modeling selection. This version will also take in the dominance param (h) from the cmd line!*/


//UPDAATE 3: May 6, 2014
/*Major update: have now gutted the drift_sel function. This should fix subtle segfaults that soemtimes seem to occur. I did a major recoding to make the function work simpler*/

#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <ctype.h>

//include GSL library stuff:
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include <gsl/gsl_integration.h>

/*define global variables:*/
int fix = 0;
int total_mut = 0;
int count_mut=0;
double GammaInIntegrableFunction;
int jInIntegrableFunction;
int BurnInPopSizeInIntegrableFunction;
double PointSelInIntegrableFunction;
int SampleSizeInIntegrableFunction;
double ThetaInIntegrableFunction;

/*define the data structure*/
  struct linked_list
  {
    double count; //the frequency of the mutation
    double sel_coef; //the selection coefficient of the mutation
    double h; //the dominance factor
    int count_samp; //count of the mutation in the sample
    int age; //the age that teh mutation has arisen
    int num; //number of mutation--added for debugging purposes
    struct linked_list *next_ptr;
  };
struct linked_list *first_ptr = NULL;
//now define the funtions that use structures
struct linked_list *add_mutation(struct linked_list *head_ptr, double mut_rate, int N, gsl_rng * r, int age, char *type_sel, double sel_mult, double h , double PointSel, int *ListOfAllelesToKeep, int FlagTrajToPrint, FILE *EXITTRAJFILE , int FlagRelaxationSel, double SelThreshold, double NewSelCoef , double ParamOne, double ParamTwo,  double ParamThree, int TypeRelaxedSelection, double *VecSelParamOne, double *VecSelParamTwo, double *VecSelParamThree, int NumberOfSelPars);
struct linked_list *add_mutation_BurnIn(struct linked_list *head_ptr, double mut_rate, int N, gsl_rng * r, int age, char *type_sel, double sel_mult, double h , double PointSel, int *ListOfAllelesToKeep, int FlagTrajToPrint, FILE *EXITTRAJFILE , int FlagRelaxationSel, double SelThreshold, double NewSelCoef , double ParamOne, double ParamTwo,  double ParamThree, int TypeRelaxedSelection, double *VecSelParamOne, double *VecSelParamTwo, double *VecSelParamThree, int NumberOfSelPars, double SFSBasedAlleleFrequency);

struct linked_list *drift_sel(struct linked_list *head_ptr, int N, gsl_rng * r, double F, int FlagTrajToPrint, int *ListOfAllelesToKeep, FILE *EXITTRAJFILE, FILE *FIXEDSITESFILE, int ShortFlag , int SampleFlag, int ModuloFixedSitesToPrint, int fixed_sitesFlag);
void short_output(struct linked_list *head_ptr, FILE *S_OUT, FILE *NUM_SNP_OUT, FILE *WEIGHT_S_OUT,  FILE *MAF_OUT, FILE *GEN_LOAD, int num, int run, int n, gsl_rng * r, int num_snpFlag , int s_outFlag , int average_mafFlag , int s_weightFlag , int genloadFlag, int sfs_outFlag);
void full_output(struct linked_list *head_ptr, FILE *FULL_OUT,  int num, int run);
void dog_output(struct linked_list *head_ptr, FILE *DOG_OUT,  int num, int run, double F, gsl_rng * r);
void sfs_output(struct linked_list *head_ptr, FILE *SFS_OUT, int num, int run, int n, gsl_rng * r);
struct linked_list *relax_selection(struct linked_list *head_ptr, double NewSelCoef, double SelThreshold , int TypeRelaxedSelection);

// Define the function to be integrated

double f_of_q_lambda (double x, void * params) {
	
	GammaInIntegrableFunction = BurnInPopSizeInIntegrableFunction * PointSelInIntegrableFunction;
	double f;
	if (abs (GammaInIntegrableFunction) > 1.0e-7){
		
		double SFSFunctionTermOne = (1-exp(-2*BurnInPopSizeInIntegrableFunction*(-PointSelInIntegrableFunction)*(1-x)))/(1-exp(-2*BurnInPopSizeInIntegrableFunction*(-PointSelInIntegrableFunction)));
		double SFSFunctionTermTwo = (2/(x*(1-x)));
		double BinomialValue = gsl_ran_binomial_pdf(jInIntegrableFunction,x,SampleSizeInIntegrableFunction);
		
		f = ThetaInIntegrableFunction/2 * SFSFunctionTermOne * SFSFunctionTermTwo * BinomialValue;
		//	return (a * x + b) * x + c;
	}else{
		f = ThetaInIntegrableFunction/2 * 2/x * gsl_ran_binomial_pdf(jInIntegrableFunction,x,SampleSizeInIntegrableFunction);
	}
	return  f;
	
	//	double alpha = *(double *) params;
}


int main(int argc, char *argv[])
{
  int* N, TempN;
  int* gen, Tempgen;
  long seed;
  int g;
  double mut_rate = 0;
  int num = 1;
  int poly = 0;
  int run = 1;
 int age;
 char *type_sel, *type_f;
type_sel= malloc(1000*sizeof(char));

	if(!type_sel){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
 char *path; //path where to put stuff
char *AllelesToKeep; //name of the file from where we will read the alleles whose allele frequency trajectories you want to store
char *NameExitTrajFile; //name of the file where I will write the trajectories
AllelesToKeep = malloc(1000*sizeof(char));
NameExitTrajFile = malloc(1000*sizeof(char));
	if(!AllelesToKeep){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
	if(!NameExitTrajFile){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
int AllelesToKeepFlag = 0; // Flag in case you read alleles to keep allele frequency trajectories
int N_F; //N adjusted for inbreeding
int N_F_1; //N adjusted for inbreeding, next epoch
double F = 0.0; //inbreeding coefficient
double h = 0.5; //dominance coefficient
int Short=1; //int read in from the cmd line to decide whether or not to do the short output. Iff==1, then get the short output. Else, skip it. Short output are the time-course results of genetic variation.
double sel_mult=1.0; //this is a mutliplier for the strength of selection to allow for rescaling poupaltion sizes.
int k; //counter
int n=20; //sample size for SFS and short output
double PointSel = 0; // Here I will store the value of selection in case I have a specific value for it.
	//int n=200; //this is the sample size to be drawn in the short otuput function //now read in n from cmd line 
FILE *InputAlleles, *EXITTRAJFILE, *NeTrajFile, *FValuesFile,  *SelParFile, *FIXEDSITESFILE, *PARFILE;
int *ListOfAllelesToKeep;
int AlleleRead, NumberOfAlleles = 0, ch, NumberOfSelParameters = 0, MinusNumber = 0;
	double NumberOfMutationsToAdd;
int IntegrationInterval = 1000;
int BurnInPopSize = 10000, SFSBurnInFlag = 0, SFSIntIntervalFlag = 0;
double *TheoreticalSFS, CurrentTheoreticalSFSValue, FunctionValueToEvaluate, BinomialValue, SFSFunctionTermOne, SFSFunctionTermTwo, InsideSFSTerms;
int FlagTrajToPrint = 0, NumberOfEpochs = 0, StringPart, StringParPart, NumberOfEpochs_F = 0, FlagRelaxationSelection = 0, TypeOfRelaxedSelection = 0, EpochOfRelaxation = 0, PrintingInterval = 1, DotNumber = 0;
	int DFEUnifBoundsFlag = 0, DFEPointProbFlag = 0, DFEUnifBoundsNeFlag = 0, EpochOfRelaxationFlag = 0, RelSelCoefFlag = 0, RelSelThresFlag = 0, RelSelTypeFlag = 0, SelMultFlag = 0, FixedFFlag = 0, ChangedFFlag = 0, F_FixedOptionflag = 0, hFlag = 0, nFlag = 0, PrintSNPNumberFlag = 0, ShortOutFreqFlag = 0, PrintSNPOfSFlag = 0, PrintAverageDAFFlag = 0, PrintWeightSumFlag = 0, PrintGenLoadFlag = 0, PrintFixedSitesFlag = 0, PrintSegSiteFlag = 0, PrintSampledGenFlag = 0, PrintSFSFlag = 0, FilePrefixFlag = 0;
double NewSelectionCoefficient = 0.0, SelectionThreshold = 1.0;
char *DemographicTrajectory, *TrajLine, *FValuesFileName, *SelParFileName, *ParLine, *SingleCharacter;
	int j; // counter
DemographicTrajectory = malloc(1000*sizeof(char));
	if(!DemographicTrajectory){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
FValuesFileName = malloc(1000*sizeof(char));
	if(!FValuesFileName){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
SelParFileName = malloc(1000*sizeof(char));
	if(!SelParFileName){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
ssize_t read;
size_t len = 0, parlen = 0;
char *pch, *LinePart;
pch = malloc(1000*sizeof(char));
	if(!pch){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
LinePart = malloc(1000*sizeof(char));
	if(!LinePart){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
int SampleSize = 20, DerivedAllelesInSample, SampleFlag = 0 , F_fixedflag = 1, StringLengthOne, StringLengthTwo;
double F_Temp;
double* F_Epochs;
double *VectorSelParamOne, *VectorSelParamTwo, *VectorSelParamThree;
double DistParamOne = 0.5, DistParamTwo = 0.5, DistParamThree = 100;
TrajLine = malloc(1000*sizeof(char));
ParLine = malloc(1000*sizeof(char));
	char *ParameterFile, *SubString, *SubStringTwo, *ParSubString , *ParameterFileArgument, *OutputFilePrefix, *ArgumentLastElement;
ArgumentLastElement = malloc(1*sizeof(char));	
	if(!ArgumentLastElement){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
	ParameterFile = malloc(1000*sizeof(char));
	if(!ParameterFile){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
SubString = malloc(1000*sizeof(char));
	if(!SubString){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
SubStringTwo = malloc(1000*sizeof(char));
	if(!SubStringTwo){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
ParSubString = malloc(1000*sizeof(char));
	if(!ParSubString){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
ParameterFileArgument = malloc(1000*sizeof(char));
	if(!ParameterFileArgument){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
OutputFilePrefix = malloc(1000*sizeof(char));
	if(!ParameterFileArgument){
		fprintf(stderr, "Not enough memory to run program\n");
        exit(8);
	}
SingleCharacter = malloc(1*sizeof(char));
	if(!SingleCharacter){
		fprintf(stderr, "Not enough memory to run program\n");
		exit(8);
	}
	
strcpy(OutputFilePrefix, "Output");
	int num_snpFlag = 0, s_outFlag = 0, average_mafFlag = 0, s_weightFlag = 0, genloadFlag = 0, sfs_outFlag = 0, het_outFlag = 0, full_outFlag = 0, fixed_sitesFlag = 0 ; 
	int ModuloFixedSitesToPrint = 0;

// InputFlags
	int AlleleTrajsInputFlag = 0, AlleleTrajsOutputFlag = 0, DemographicHistoryFlag = 0, ParamOneFlag = 0, ParamTwoFlag = 0, ParamThreeFlag = 0, MutationRateFlag = 0 , RepNumberFlag = 0 , RunNumberFlag = 0, DFETypeFlag = 0, ParamOneSelCoefFlag = 0, DFEPointProbFileFlag = 0;
/*N = malloc(4*sizeof(int));
gen = malloc(4*sizeof(int));
	for(k=0; k<4; k++)
	{
		N[k]=0;	
		gen[k]=0;
	}
*/ 

//	printf("%s\n",argv[1]);
	ParameterFile = argv[1];
//	printf("%s\n",ParameterFile);
	num = atoi(argv[2]);
	
	printf("\nParameter List\n\n");
/*	NeTrajFile = fopen (ParameterFile,"r");
	NumberOfEpochs = 0;
	do {
		ch = fgetc(NeTrajFile);
		if (ch == '\n')
			NumberOfEpochs++;
	} while (ch != EOF);
	if (ch != '\n' && NumberOfEpochs != 0)
		NumberOfEpochs++;
	fclose(NeTrajFile); */
	
	PARFILE = fopen (ParameterFile,"r");
	while (fgets(ParLine, 1000, PARFILE)) {
//		printf("Reading... %s\n",ParLine);
//		ParLine[strlen(ParLine) -1] = '\0';
		LinePart = strtok (ParLine," \t\r");
		StringParPart = 0;
		
		while (LinePart != NULL){
//			printf("%s\n",pch);
			StringLengthOne = strspn(LinePart, " \t\r");
			if (StringLengthOne != 0){
				LinePart = strtok (NULL, " \t\r");
				continue;
			}
			
			if (StringParPart == 0){
//				printf("Part One = %s\n",LinePart);
				strcpy(ParameterFileArgument,LinePart);
//				ParameterFileArgument = LinePart;
//				printf("%s",ParameterFileArgument);	
				strncpy(ArgumentLastElement,&ParameterFileArgument[strlen(ParameterFileArgument) -1],1);
				if (strcasecmp(ArgumentLastElement,":") != 0 ){
					strcat(ParameterFileArgument,":");
//					printf(":");
				}
//				printf(" ");
				
			}else{
				strcpy(ParSubString,"");
//				ParSubString = LinePart;
				for (j = 0; j < strlen(LinePart); j++){
					strncpy(SubStringTwo,LinePart+j,1);
					if (isspace((int) SubStringTwo[0])){
//						printf("%i %c %i \n",j,LinePart[j],strlen(LinePart));
						break;
					}else{
//						SubString = LinePart[j]
//						printf("%i %c %i \n",j,LinePart[j],strlen(LinePart));
						strcat(ParSubString,SubStringTwo);
					}
				}
//				strcat(ParSubString,'\0');
//				ParSubString[strlen(ParSubString) -1] = '\0';
//				exit(8);
				// Below we read the options from the parameter file
				// Allele frequency trajectories
				if (strcasecmp(ParameterFileArgument,"AlleleTrajsInput:") == 0){
//					AllelesToKeep = ParSubString;
					if (AlleleTrajsInputFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option AlleleTrajsInput in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					strcpy(AllelesToKeep,ParSubString);
					printf("AlleleTrajsInput: ");
					char file_AlleleTrajInput[1000];
					sprintf(file_AlleleTrajInput, "%s_%d.txt",AllelesToKeep,num);
					printf("%s\n",file_AlleleTrajInput);
					InputAlleles = fopen(file_AlleleTrajInput,"r");
					if (InputAlleles == NULL)
					{
						fprintf(stderr, "\nError: unable to read input file %s from option AlleleTrajsInput\n",AllelesToKeep);
						exit(8);
					}
					
					do {
						ch = fgetc(InputAlleles);
						if (ch == '\n')
							NumberOfAlleles++;
					} while (ch != EOF);
					if (ch != '\n' && NumberOfEpochs != 0)
						NumberOfAlleles++;
					fclose(InputAlleles);
					
					
/*					while (fscanf(InputAlleles, "%d",&AlleleRead) != EOF){
						//		printf("Allele = %d\n",AlleleRead);
						NumberOfAlleles++;
					}
					fclose(InputAlleles); */
//					printf("NumberOfAlleles = %d\n", NumberOfAlleles);
					ListOfAllelesToKeep = malloc(NumberOfAlleles*sizeof(int));
					InputAlleles = fopen(file_AlleleTrajInput,"r");
					NumberOfAlleles = 0;
					if (InputAlleles == NULL)
					{
						fprintf(stderr, "\nError: unable to read input file %s from option AlleleTrajsInput\n",AllelesToKeep);
						exit(8);
					}
					
					NumberOfAlleles = 0;
					printf("Alleles ID to follow: ");
					while (fgets(TrajLine, 1000, InputAlleles)) {

						pch = strtok (TrajLine," \t\r");
						while (pch != NULL){
							strcpy(SubString,"");
							for (j = 0; j < strlen(pch); j++){
								strncpy(SingleCharacter,pch+j,1);
								if (isspace((int) pch[j])){
									break;
								}else{
									strcat(SubString,SingleCharacter);
								}
							}
							for (j=0; j<strlen(SubString); j++) {
								strncpy(SingleCharacter,SubString+j,1);
								if (!isdigit((int) SingleCharacter[0]) ){
									fprintf(stderr, "\nError: One of the elements in the AlleleTrajsInput file is not a nonnegative integer number %s (no dots or commas allowed)\n", SubString);
									exit(8);
								}
							}
							if (strlen(SubString) > 0){
							ListOfAllelesToKeep[NumberOfAlleles] = atoi(pch);
							printf("%d\t",ListOfAllelesToKeep[NumberOfAlleles]);
							NumberOfAlleles++;
							}
							break;	
						}
					}
					fclose(InputAlleles);
					printf("\n");
/*					while (fscanf(InputAlleles, "%d",&AlleleRead) != EOF){
					//	printf("Allele = %d\n",AlleleRead);
						ListOfAllelesToKeep[NumberOfAlleles] = AlleleRead;
					//	printf("Array %d %d\n", NumberOfAlleles , ListOfAllelesToKeep[NumberOfAlleles]);
						NumberOfAlleles++;
					}
					fclose(InputAlleles); */
		
				/*	NameExitTrajFile = &argv[1][0];
					printf("ExitFile = %s\n", NameExitTrajFile );
					EXITTRAJFILE = fopen(NameExitTrajFile,"w");
					//	fprintf(EXITTRAJFILE, "Here I come!\n");
					//	fclose(EXITTRAJFILE);
					FlagTrajToPrint = NumberOfAlleles;	 */	
					AlleleTrajsInputFlag = 1;
				}
				else if (strcasecmp(ParameterFileArgument,"AlleleTrajsOutput:") == 0){
					if (AlleleTrajsOutputFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option AlleleTrajsOutput in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					
					strcpy(NameExitTrajFile,ParSubString);
//					NameExitTrajFile = ParSubString;
					printf("AlleleTrajsOutput: ");
                                        char file_AlleleTrajOutput[1000];
                                        sprintf(file_AlleleTrajOutput, "%s_%d.txt",NameExitTrajFile,num);
					printf("%s\n", NameExitTrajFile );
					EXITTRAJFILE = fopen(file_AlleleTrajOutput,"w");
					if (EXITTRAJFILE == NULL)
					{
						fprintf(stderr, "\nError: unable to create output file %s from option AlleleTrajsOutput\n",NameExitTrajFile);
						exit(8);
					}
					
					FlagTrajToPrint = NumberOfAlleles;
					AlleleTrajsOutputFlag = 1;
				}

				else if (strcasecmp(ParameterFileArgument,"DemographicHistory:") == 0){
					if (DemographicHistoryFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option DemographicHistory in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					
					strcpy(DemographicTrajectory,ParSubString);
//					DemographicTrajectory = ParSubString;
					printf("DemographicHistory: ");
					printf("%s\n",DemographicTrajectory);
					NumberOfEpochs = 0;
					NeTrajFile = fopen (DemographicTrajectory,"r");
					if (NeTrajFile == NULL)
					{
						fprintf(stderr, "\nError: unable to read input file %s from option DemographicHistory\n", DemographicTrajectory);
						exit(8);
					}					
					do {
						ch = fgetc(NeTrajFile);
						if (ch == '\n')
							NumberOfEpochs++;
					} while (ch != EOF);
					if (ch != '\n' && NumberOfEpochs != 0)
						NumberOfEpochs++;
					fclose(NeTrajFile);
					//	printf("Number of epochs = %i\n", NumberOfEpochs);
					/*	NumberOfEpochs = 0;
					 while(1){
					 if(fgets(TrajLine,150,NeTrajFile) == NULL) break;
					 NumberOfEpochs++;
					 }
					 fclose(NeTrajFile);
					 printf("Epochs = %i\n",NumberOfEpochs);*/
					N = malloc(NumberOfEpochs*sizeof(int));
					gen = malloc(NumberOfEpochs*sizeof(int)); 
					NumberOfEpochs = 0;
					NeTrajFile = fopen (DemographicTrajectory,"r");
					// fgets(ParLine, 1000, PARFILE)
					if (NeTrajFile == NULL)
					{
						fprintf(stderr, "\nError: unable to read input file %s from option DemographicHistory\n", DemographicTrajectory);
						exit(8);
					}
					
					while (fgets(TrajLine, 1000, NeTrajFile)) {
						//		printf("Retrieve line of length %zu :\n", read);
						//		printf("%s", TrajLine);
						pch = strtok (TrajLine," \t\r");
						
						if ( NumberOfEpochs == 0 ){
							//		N = malloc(1*sizeof(int));
							//		gen = malloc(1*sizeof(int));
						}else{
							//		N = (int*) realloc(N , (NumberOfEpochs + 1 )* sizeof(int) );
							//		gen = (int*) realloc(gen , (NumberOfEpochs + 1 )* sizeof(int) );
						} 
						//		N = (int*) TempN;
						//		Tempgen = (int*) gen;
						StringPart = 0;
						//		printf("str part 1 %s and 2 %s\n",pch[0],pch[1]);
						while (pch != NULL){
//									printf ("CurrentLine = %s %i\n",pch, StringPart);
							
							//			pch = strtok (NULL, " ");
							StringLengthOne = strspn(pch, " \t\r");
							StringLengthTwo = strlen(pch);
							if (StringLengthOne != 0){
								pch = strtok (NULL, " \t\r");
								continue;
							}
//							printf ("String length one %d and two %d\n",StringLengthOne,StringLengthTwo);
							if (StringPart == 0){
								for (j=0; j<strlen(pch); j++) {
									strncpy(SingleCharacter,pch+j,1);
									// && strcmp(SingleCharacter,".")!=0
									if (!isdigit((int) SingleCharacter[0]) ){
										fprintf(stderr, "\nError: One of the elements in the row %i of the DemographicHistory file is not a nonnegative integer number (no dots or commas allowed) or there are not two numbers in that row.\n", NumberOfEpochs+1);
										exit(8);
									}
								}
								
								N[NumberOfEpochs] = atoi(pch);
								//				printf("String1 = %i %i\n",N[NumberOfEpochs], NumberOfEpochs);
							}else if (StringPart == 1){
								//				gen[NumberOfEpochs] = atoi (pch);
								strcpy(SubString,"");
								
								//				ParSubString = LinePart;
								for (j = 0; j < strlen(pch); j++){
	//								strncpy(SubString,pch+j,1);
									strncpy(SingleCharacter,pch+j,1);
									if (isspace((int) pch[j])){
				//												printf("%i %c %i \n",j,SubString[0],strlen(pch));
										break;
									}else{
										//						SubString = LinePart[j]
										//						printf("%i %c %i \n",j,LinePart[j],strlen(LinePart));
//										strcat(SubString,SubString);
										strcat(SubString,SingleCharacter);
									}
								}
//								printf("j = %i",j);
//								strncpy(SubString,pch,j);
//								SubString = pch;
//								SubString[strlen(SubString) -1] = '\0';
//								printf("String length = %d\n",strlen(SubString));
								if (strlen(SubString) == 0){
									fprintf(stderr, "\nError: One of the elements in the row %i of the DemographicHistory file is not a nonnegative integer number (no dots or commas allowed) or there are not two numbers in that row.\n", NumberOfEpochs+1);
									exit(8);
								}
								for (j=0; j<strlen(SubString); j++) {
//									printf("%c",SubString[j]);
									strncpy(SingleCharacter,SubString+j,1);
									// && strcmp(SingleCharacter,".")!=0
									if (!isdigit((int) SingleCharacter[0]) ){
										fprintf(stderr, "\nError: One of the elements in the DemographicHistory file is not a nonnegative integer number %s (no dots or commas allowed)\n", SubString);
										exit(8);
									}
								}								
								gen[NumberOfEpochs] = atoi (SubString);
//												printf("String2 = %i %i\n",gen[NumberOfEpochs], NumberOfEpochs);
							}
							pch = strtok (NULL, " \t\r");
							StringPart++;
						}
						NumberOfEpochs++;
					}
					fclose(NeTrajFile);
					DemographicHistoryFlag = 1;
				}
				
				else if (strcasecmp(ParameterFileArgument,"MutationRate:") == 0){
					
					if (MutationRateFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option MutationRate in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					
					printf("MutationRate: ");
					DotNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 ){
							fprintf(stderr, "\nError: The value %s given in the option MutationRate is not a nonnegative decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option MutationRate is not a nonnegative decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}
					mut_rate = atof(ParSubString);
					printf("%lf\n",mut_rate);
					MutationRateFlag = 1;
				}

				else if (strcasecmp(ParameterFileArgument,"RepNumber:") == 0){
					if (RepNumberFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option RepNumber in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					
					printf("RepNumber: ");
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option RepNumber is not a nonnegative integer number (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					
					num = atoi(ParSubString);
					printf("%d\n",num);
					RepNumberFlag = 1;
				}
				
				else if (strcasecmp(ParameterFileArgument,"RunNumber:") == 0){
					if (RunNumberFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option RunNumber in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					
					printf("RunNumber: ");
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option RunNumber is not a nonnegative integer number (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					run = atoi(ParSubString);
					printf("%d\n",run);
					RunNumberFlag = 1;
				}

				else if (strcasecmp(ParameterFileArgument,"DFEType:") == 0){
					if (DFETypeFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option DFEType in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					
					printf("DFEType: ");
					strcpy(type_sel,ParSubString);
//					type_sel = ParSubString;
					printf("%s\n",type_sel);
					DFETypeFlag = 1;
				}

				else if (strcasecmp(ParameterFileArgument,"DFEPointSelectionCoefficient:") == 0){
					if (ParamOneSelCoefFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option DFEPointSelectionCoefficient in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}					
					printf("DFEPointSelectionCoefficient: ");
					DotNumber = 0;
					MinusNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 && strcmp(SingleCharacter,"-")!=0 ){
							fprintf(stderr, "\nError: The value %s given in the option DFEPointSelectionCoefficient is not a decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}						
						if (strcmp(SingleCharacter,"-")==0 ){
							MinusNumber++;
						}												
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option DFEPointSelectionCoefficient is not a decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}
					if (MinusNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option DFEPointSelectionCoefficient is not a decimal number (more than one negative sign was found)\n", ParSubString);
						exit(8);
					}					
					
					PointSel = atof(ParSubString);
					printf("%lf\n",PointSel);
					ParamOneFlag = 1;
					ParamOneSelCoefFlag = 1;
				}

				else if (strcasecmp(ParameterFileArgument,"DFEParameterOne:") == 0){
					if (ParamOneFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option DFEParameterOne in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}					
					
					printf("DFEParameterOne: ");
					DotNumber = 0;
					MinusNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0  && strcmp(SingleCharacter,"-")!=0){
							fprintf(stderr, "\nError: The value %s given in the option DFEParameterOne is not a decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}
						if (strcmp(SingleCharacter,"-")==0 ){
							MinusNumber++;
						}																		
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option DFEParameterOne is not a decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}					
					if (MinusNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option DFEPointSelectionCoefficient is not a decimal number (more than one negative sign was found)\n", ParSubString);
						exit(8);
					}					
					DistParamOne = atof(ParSubString);
					printf("%lf\n",DistParamOne);
					ParamOneFlag = 1;
				}

				else if (strcasecmp(ParameterFileArgument,"DFEParameterTwo:") == 0){
					if (ParamTwoFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option DFEParameterTwo in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}					
					
					printf("DFEParameterTwo: ");
					DotNumber = 0;
					MinusNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 && strcmp(SingleCharacter,"-")!=0){
							fprintf(stderr, "\nError: The value %s given in the option DFEParameterTwo is not a decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}
						if (strcmp(SingleCharacter,"-")==0 ){
							MinusNumber++;
						}						
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option DFEParameterTwo is not a decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}	
					if (MinusNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option DFEPointSelectionCoefficient is not a decimal number (more than one negative sign was found)\n", ParSubString);
						exit(8);
					}					
					
					DistParamTwo = atof(ParSubString);
					printf("%lf\n",DistParamTwo);
					ParamTwoFlag = 1;
				}
				
				else if (strcasecmp(ParameterFileArgument,"DFEParameterThree:") == 0){
					if (ParamThreeFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option DFEParameterThree in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}					
					
					printf("DFEParameterThree: ");
					DotNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 ){
							fprintf(stderr, "\nError: The value %s given in the option DFEParameterThree is not a nonnegative decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option DFEParameterThree is not a nonnegative decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}
					DistParamThree = atof(ParSubString);
					printf("%lf\n",DistParamThree);
					ParamThreeFlag = 1;
				}

				else if (strcasecmp(ParameterFileArgument,"DFEPointProbSelectionFile:") == 0){
					if (DFEPointProbFileFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option DFEPointProbSelectionFile in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}					
					
					printf("DFEPointProbSelectionFile: ");
					ParamOneFlag = 1;
					strcpy(SelParFileName,ParSubString);
					printf("%s\n",SelParFileName);
					SelParFile = fopen (SelParFileName,"r");
					if (SelParFile == NULL)
					{
						fprintf(stderr, "\nError: unable to read input file %s from option DFEPointProbSelectionFile\n", SelParFileName);
						exit(8);
					}
					
					NumberOfSelParameters = 0;
					do {
						ch = fgetc(SelParFile);
						if (ch == '\n')
							NumberOfSelParameters++;
					} while (ch != EOF);
					if (ch != '\n' && NumberOfSelParameters != 0)
						NumberOfSelParameters++;
					fclose(SelParFile);
				
					VectorSelParamOne = malloc(NumberOfSelParameters * sizeof(double));
					VectorSelParamTwo = malloc(NumberOfSelParameters * sizeof(double));
					VectorSelParamThree = malloc(NumberOfSelParameters * sizeof(double));
					NumberOfSelParameters = 0;
					SelParFile = fopen (SelParFileName,"r");
					// fgets(ParLine, 1000, PARFILE)
					if (SelParFile == NULL)
					{
						fprintf(stderr, "\nError: unable to read input file %s from option DFEPointProbSelectionFile\n", SelParFileName);
						exit(8);
					}					
					while (fgets(TrajLine, 1000, SelParFile)) {
						pch = strtok (TrajLine," \t\r");
						StringPart = 0;
						while (pch != NULL){
							
							StringLengthOne = strspn(pch, " \t\r");
							StringLengthTwo = strlen(pch);
							if (StringLengthOne != 0){
								pch = strtok (NULL, " \t\r");
								continue;
							}
							
							if (StringPart == 0){
								DotNumber = 0;
								MinusNumber = 0;
								for (j=0; j<strlen(pch); j++) {
									strncpy(SingleCharacter,pch+j,1);
									// && strcmp(SingleCharacter,".")!=0
									if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 && strcmp(SingleCharacter,"-")!=0){
										fprintf(stderr, "\nError: The value %s given in the DFEPointProbSelectionFile file is not a decimal number (commas are not allowed)\n", pch);
										exit(8);
									}
									if (strcmp(SingleCharacter,".")==0 ){
										DotNumber++;
									}
									if (strcmp(SingleCharacter,"-")==0 ){
										MinusNumber++;
									}									
								}
								if (DotNumber > 1) {
									fprintf(stderr, "\nError: The value %s given in the DFEPointProbSelectionFile file is not a decimal number (more than one dot was found)\n", pch);
									exit(8);
								}
								if (MinusNumber > 1) {
									fprintf(stderr, "\nError: The value %s given in the DFEPointProbSelectionFile file is not a decimal number (more than one negative sign was found)\n", pch);
									exit(8);
								}								
								
								VectorSelParamOne[NumberOfSelParameters] = atof(pch);
								printf("Parameter One = %f\t",VectorSelParamOne[NumberOfSelParameters]);
							}
							else if (StringPart == 1){
									char *SubString2;
									SubString2 = malloc(1000*sizeof(char));
									strcpy(SubString2,"");
									for (j = 0; j < strlen(pch); j++){
										strncpy(SingleCharacter,pch+j,1);
									if (isspace((int) pch[j])){
										break;
									}else{
										strcat(SubString2,SingleCharacter);
									}
									}
								
									// strcpy(SubString2, pch);
									// SubString2[strlen(SubString2) -1] = '\0';
								DotNumber = 0;
								for (j=0; j<strlen(SubString2); j++) {
									strncpy(SingleCharacter,SubString2+j,1);
									// && strcmp(SingleCharacter,".")!=0
									if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 ){
										fprintf(stderr, "\nError: The value %s given in the DFEPointProbSelectionFile file is not a nonnegative decimal number bounded between 0 and 1 (commas are not allowed)\n", SubString2);
										exit(8);
									}
									if (strcmp(SingleCharacter,".")==0 ){
										DotNumber++;
									}																		
								}
								if (strlen(SubString2) == 0){
									fprintf(stderr, "\nError: One of the elements in the row %i of the DFEPointProbSelectionFile file is not a nonnegative decimal number (no dots or commas allowed) or there are not two numbers in that row.\n", NumberOfSelParameters+1);
									exit(8);
								}
								
								if (DotNumber > 1) {
									fprintf(stderr, "\nError: The value %s given in the DFEPointProbSelectionFile file is not a nonnegative decimal number bounded between 0 and 1 (more than one dot was found)\n", SubString2);
									exit(8);
								}								
									VectorSelParamTwo[NumberOfSelParameters] = atof (SubString2);
									printf("Parameter Two = %f\n",VectorSelParamTwo[NumberOfSelParameters]);
							}

							pch = strtok (NULL, " \t\r");
							StringPart++;
						}
						NumberOfSelParameters++;
					}
					DFEPointProbFileFlag = 1;
				}

				else if (strcasecmp(ParameterFileArgument,"DFEUnifBoundsSelectionFile:") == 0){
					if (DFEUnifBoundsFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option DFEUnifBoundsSelectionFile in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					DFEUnifBoundsFlag = 1;
					printf("DFEUnifBoundsSelectionFile: ");
					ParamOneFlag = 1;
					SelParFileName = ParSubString;
					printf("%s\n",SelParFileName);
					SelParFile = fopen (SelParFileName,"r");
					if (SelParFile == NULL)
					{
						fprintf(stderr, "\nError: unable to read input file %s from option DFEUnifBoundsSelectionFile\n", SelParFileName);
						exit(8);
					}
					
					NumberOfSelParameters = 0;
					do {
						ch = fgetc(SelParFile);
						if (ch == '\n')
							NumberOfSelParameters++;
					} while (ch != EOF);
					if (ch != '\n' && NumberOfSelParameters != 0)
						NumberOfSelParameters++;
					fclose(SelParFile);
					
					VectorSelParamOne = malloc(NumberOfSelParameters * sizeof(double));
					VectorSelParamTwo = malloc(NumberOfSelParameters * sizeof(double));
					VectorSelParamThree = malloc(NumberOfSelParameters * sizeof(double));
					NumberOfSelParameters = 0;
					SelParFile = fopen (SelParFileName,"r");
					if (SelParFile == NULL)
					{
						fprintf(stderr, "\nError: unable to read input file %s from option DFEUnifBoundsSelectionFile\n", SelParFileName);
						exit(8);
					}
					
					
					while (fgets(TrajLine, 1000, SelParFile)) {
						pch = strtok (TrajLine," \t\r");
						StringPart = 0;
						while (pch != NULL){
							StringLengthOne = strspn(pch, " \t\r");
							StringLengthTwo = strlen(pch);
							if (StringLengthOne != 0){
								pch = strtok (NULL, " \t\r");
								continue;
							}
							
							if (StringPart == 0){
								DotNumber = 0;
								MinusNumber = 0;
								for (j=0; j<strlen(pch); j++) {
									strncpy(SingleCharacter,pch+j,1);
									// && strcmp(SingleCharacter,".")!=0
									if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 && strcmp(SingleCharacter,"-")!=0){
										fprintf(stderr, "\nError: The value %s given in the DFEUnifBoundsSelectionFile file is not a decimal number (commas are not allowed)\n", pch);
										exit(8);
									}
									if (strcmp(SingleCharacter,".")==0 ){
										DotNumber++;
									}																		
									if (strcmp(SingleCharacter,"-")==0 ){
										MinusNumber++;
									}																		
								}
								if (DotNumber > 1) {
									fprintf(stderr, "\nError: The value %s given in the DFEUnifBoundsSelectionFile file is not a decimal number (more than one dot was found)\n", pch);
									exit(8);
								}
								if (MinusNumber > 1) {
									fprintf(stderr, "\nError: The value %s given in the DFEUnifBoundsSelectionFile is not a decimal number (more than one negative sign was found)\n", pch);
									exit(8);
								}					
								
								
								VectorSelParamOne[NumberOfSelParameters] = atof(pch);
								printf("Parameter One = %f\t",VectorSelParamOne[NumberOfSelParameters]);
							}
							else if (StringPart == 1){
								DotNumber = 0;
								MinusNumber = 0;
								for (j=0; j<strlen(pch); j++) {
									strncpy(SingleCharacter,pch+j,1);
									// && strcmp(SingleCharacter,".")!=0
									if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 && strcmp(SingleCharacter,"-")!=0){
										fprintf(stderr, "\nError: The value %s given in the DFEUnifBoundsSelectionFile file is not a decimal number (commas are not allowed)\n", pch);
										exit(8);
									}
									if (strcmp(SingleCharacter,".")==0 ){
										DotNumber++;
									}	
									if (strcmp(SingleCharacter,"-")==0 ){
										MinusNumber++;
									}									
								}
								if (DotNumber > 1) {
									fprintf(stderr, "\nError: The value %s given in the DFEUnifBoundsSelectionFile file is not a decimal number (more than one dot was found)\n", pch);
									exit(8);
								}
								if (MinusNumber > 1) {
									fprintf(stderr, "\nError: The value %s given in the DFEUnifBoundsSelectionFile is not a decimal number (more than one negative sign was found)\n", pch);
									exit(8);
								}					
								if (strlen(pch) == 0){
									fprintf(stderr, "\nError: One of the elements in the row %i of the DFEUnifBoundsSelectionFile file is not a decimal number (no dots or commas allowed) or there are not two numbers in that row.\n", NumberOfSelParameters+1);
									exit(8);
								}
								
								VectorSelParamTwo[NumberOfSelParameters] = atof(pch);
								printf("Parameter Two = %f\t",VectorSelParamTwo[NumberOfSelParameters]);
							}
							else if (StringPart == 2){
								char *SubString3;
								SubString3 = malloc(1000*sizeof(char));
								strcpy(SubString3,"");
								for (j = 0; j < strlen(pch); j++){
									strncpy(SingleCharacter,pch+j,1);
									if (isspace((int) pch[j])){
										break;
									}else{
										strcat(SubString3,SingleCharacter);
									}
								}
								DotNumber = 0;
								for (j=0; j<strlen(SubString3); j++) {
									strncpy(SingleCharacter,SubString3+j,1);
									// && strcmp(SingleCharacter,".")!=0
									if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 ){
										fprintf(stderr, "\nError: The value %s given in the DFEUnifBoundsSelectionFile file is not a decimal number (commas are not allowed)\n", SubString3);
										exit(8);
									}
									if (strcmp(SingleCharacter,".")==0 ){
										DotNumber++;
									}																		
								}
								if (DotNumber > 1) {
									fprintf(stderr, "\nError: The value %s given in the DFEUnifBoundsSelectionFile file is not a decimal number (more than one dot was found)\n", SubString3);
									exit(8);
								}								
								
//								SubString3 = pch;
//								SubString3[strlen(SubString3) -1] = '\0';
								VectorSelParamThree[NumberOfSelParameters] = atof (SubString3);
								printf("Parameter Three = %f\n",VectorSelParamThree[NumberOfSelParameters]);
								
								if (strlen(SubString3) == 0){
									fprintf(stderr, "\nError: One of the elements in the row %i of the DFEUnifBoundsSelectionFile file is not a decimal number (no dots or commas allowed) or there are not two numbers in that row.\n", NumberOfSelParameters+1);
									exit(8);
								}
								
							}
							pch = strtok (NULL, " \t\r");
							StringPart++;
						}
						NumberOfSelParameters++;
					}
					
				
				}
				
				else if (strcasecmp(ParameterFileArgument,"DFEPointProbNe:") == 0){
					if (DFEPointProbFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option DFEPointProbNe in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					DFEPointProbFlag = 1;
					
					printf("DFEPointProbNe: ");
					DotNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 ){
							fprintf(stderr, "\nError: The value %s given in the option DFEPointProbNe is not a nonnegative decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}																														
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option DFEPointProbNe is not a nonnegative decimal number (more than one dot was found)\n", ParSubString);
					}										
					
					ParamThreeFlag = 1;
					DistParamThree = atof(ParSubString);
					printf("%lf\n",DistParamThree);
				}

				else if (strcasecmp(ParameterFileArgument,"DFEUnifBoundsNe:") == 0){
					if (DFEUnifBoundsNeFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option DFEUnifBoundsNe in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					DFEUnifBoundsNeFlag = 1;
					
					printf("DFEUnifBoundsNe: ");
					DotNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 ){
							fprintf(stderr, "\nError: The value %s given in the option DFEUnifBoundsNe is not a nonnegative decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}																																				
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option DFEUnifBoundsNe is not a nonnegative decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}															
					ParamThreeFlag = 1;
					DistParamThree = atof(ParSubString);
					printf("%lf\n",DistParamThree);
				}

				else if (strcasecmp(ParameterFileArgument,"EpochOfRelaxation:") == 0){
					if (FlagRelaxationSelection == 1){
						fprintf(stderr, "\nError: At least two occurences of the option EpochOfRelaxation in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					
					printf("EpochOfRelaxation: ");
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option EpochOfRelaxation is not a nonnegative integer number (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					
					EpochOfRelaxation = atoi(ParSubString);
					printf("%d\n",EpochOfRelaxation);
					FlagRelaxationSelection = 1;
				}
				
				else if (strcasecmp(ParameterFileArgument,"RelaxationSelectionCoefficient:") == 0){
					if (RelSelCoefFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option RelaxationSelectionCoefficient in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					RelSelCoefFlag = 1;
					
					printf("RelaxationSelectionCoefficient: ");
					DotNumber = 0;
					MinusNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0  && strcmp(SingleCharacter,"-")!=0){
							fprintf(stderr, "\nError: The value %s given in the option RelaxationSelectionCoefficient is not a decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}																																										
						if (strcmp(SingleCharacter,"-")==0 ){
							MinusNumber++;
						}						
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option RelaxationSelectionCoefficient is not a decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}
					if (MinusNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option RelaxationSelectionCoefficient is not a decimal number (more than one negative sign was found)\n", ParSubString);
						exit(8);
					}					
					
					NewSelectionCoefficient = atof(ParSubString);
					printf("%lf\n",NewSelectionCoefficient);
				}

				else if (strcasecmp(ParameterFileArgument,"RelaxationSelectionThreshold:") == 0){
					if (RelSelThresFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option RelaxationSelectionThreshold in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					RelSelThresFlag = 1;
					
					printf("RelaxationSelectionThreshold: ");
					DotNumber = 0;
					MinusNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 && strcmp(SingleCharacter,"-")!=0){
							fprintf(stderr, "\nError: The value %s given in the option RelaxationSelectionThreshold is not a decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}
						if (strcmp(SingleCharacter,"-")==0 ){
							MinusNumber++;
						}						
						
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option RelaxationSelectionThreshold is not a decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}
					if (MinusNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option RelaxationSelectionThreshold is not a decimal number (more than one negative sign was found)\n", ParSubString);
						exit(8);
					}					
					
					SelectionThreshold = atof(ParSubString);
					printf("%lf\n",SelectionThreshold);
				}			

				else if (strcasecmp(ParameterFileArgument,"RelaxationSelectionType:") == 0){
					if (RelSelTypeFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option RelaxationSelectionType in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					RelSelTypeFlag = 1;
					
					printf("RelaxationSelectionType: ");
					DotNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option RelaxationSelectionType is not a integer number equal to 0 or 1. (commas and dots are not allowed)\n", ParSubString);
							exit(8);
						}
					}
				
					TypeOfRelaxedSelection = atoi(ParSubString);
					if (TypeOfRelaxedSelection != 0 && TypeOfRelaxedSelection != 1){
						fprintf(stderr, "\nError: The value %s given in the option RelaxationSelectionType is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					
					printf("%lf\n",TypeOfRelaxedSelection);
				}			

				else if (strcasecmp(ParameterFileArgument,"LastGenerationAFSamplingValue:") == 0){
					if (SampleFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option LastGenerationAFSamplingValue in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					
					printf("LastGenerationAFSamplingValue: ");
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option LastGenerationAFSamplingValue is not a nonnegative integer number (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					SampleSize = atoi(ParSubString);
					printf("%d\n",SampleSize);
					SampleFlag = 1;
				}			

				else if (strcasecmp(ParameterFileArgument,"SelectionMultiplier:") == 0){
					if (SelMultFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option SelectionMultiplier in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					SelMultFlag = 1;
					
					printf("SelectionMultiplier: ");
					DotNumber = 0;
					MinusNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 && strcmp(SingleCharacter,"-")!=0 ){
							fprintf(stderr, "\nError: The value %s given in the option SelectionMultiplier is not a decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}	
						if (strcmp(SingleCharacter,"-")==0 ){
							MinusNumber++;
						}						
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option SelectionMultiplier is not a decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}		
					if (MinusNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option SelectionMultiplier is not a decimal number (more than one negative sign was found)\n", ParSubString);
						exit(8);
					}								
					sel_mult = atof(ParSubString);
					printf("%d\n",sel_mult);
				}			

				else if (strcasecmp(ParameterFileArgument,"FixedFValue:") == 0){
					if (F_FixedOptionflag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option FixedFValue in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					F_FixedOptionflag = 1;
					printf("FixedFValue: ");
					DotNumber = 0;
					MinusNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 && strcmp(SingleCharacter,"-")!=0){
							fprintf(stderr, "\nError: The value %s given in the option FixedFValue is not a decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}
						if (strcmp(SingleCharacter,"-")==0 ){
							MinusNumber++;
						}						
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option FixedFValue is not a decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}
					if (MinusNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option FixedFValue is not a decimal number (more than one negative sign was found)\n", ParSubString);
						exit(8);
					}					
					F = atof(ParSubString) ;
					printf("%lf\n",F);
					F_fixedflag = 1;
				}							

				else if (strcasecmp(ParameterFileArgument,"ChangedFValue:") == 0){
					if (ChangedFFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option ChangedFValue in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					ChangedFFlag = 1;
					
					printf("ChangedFValue: ");
					F_fixedflag = 0;
					FValuesFileName = ParSubString;
					printf("%s\n",FValuesFileName);
					FValuesFile = fopen (FValuesFileName,"r");
					if (FValuesFile == NULL)
					{
						fprintf(stderr, "\nError: unable to read input file %s from option ChangedFValue\n", FValuesFileName);
						exit(8);
					}
					NumberOfEpochs_F = 0;
//					printf("All well here...\n");
					do {
						ch = fgetc(FValuesFile);
						if (ch == '\n')
							NumberOfEpochs_F++;
					} while (ch != EOF);
					if (ch != '\n' && NumberOfEpochs_F != 0)
						NumberOfEpochs_F++;
					fclose(FValuesFile);
//					NumberOfEpochs_F= NumberOfEpochs_F - 1;
					F_Epochs = malloc(NumberOfEpochs_F*sizeof(double));
//					printf("Number of F epochs = %d\n",NumberOfEpochs_F);
					FValuesFile = fopen (FValuesFileName,"r");
					if (FValuesFile == NULL)
					{
						fprintf(stderr, "\nError: unable to read input file %s from option ChangedFValue\n", FValuesFileName);
						exit(8);
					}					
					
					
					NumberOfEpochs_F = 0;
					while (fgets(TrajLine, 1000, FValuesFile)) {
						
						pch = strtok (TrajLine," \t\r");
						while (pch != NULL){
							strcpy(SubString,"");
							
							for (j = 0; j < strlen(pch); j++){
								strncpy(SingleCharacter,pch+j,1);
								if (isspace((int) pch[j])){
									break;
								}else{
									strcat(SubString,SingleCharacter);
								}
							}
							DotNumber = 0;
							MinusNumber = 0;
							for (j=0; j<strlen(SubString); j++) {
								strncpy(SingleCharacter,SubString+j,1);
								if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 && strcmp(SingleCharacter,"-")!=0){
									fprintf(stderr, "\nError: One of the elements in the ChangedFValue file is not a decimal number %s (commas are not allowed)\n", SubString);
									exit(8);
								}
								if (strcmp(SingleCharacter,".")==0 ){
									DotNumber++;
								}
								if (strcmp(SingleCharacter,"-")==0 ){
									MinusNumber++;
								}								
							}
							if (DotNumber > 1) {
								fprintf(stderr, "\nError: The value %s given in the option ChangedFValue is not a decimal number (more than one dot was found)\n", ParSubString);
								exit(8);
							}
							if (MinusNumber > 1) {
								fprintf(stderr, "\nError: The value %s given in the option ChangedFValue is not a decimal number (more than one negative sign was found)\n", ParSubString);
								exit(8);
							}							
//							F_Epochs[NumberOfEpochs_F] = atoi(pch);
							NumberOfEpochs_F++;
							break;	
						}
					}
					fclose(InputAlleles);
					
					NumberOfEpochs_F = 0;
					FValuesFile = fopen (FValuesFileName,"r");
					while (fscanf(FValuesFile, "%lf",&F_Temp) != EOF){
						//		printf("Allele = %d\n",AlleleRead);
						F_Epochs[NumberOfEpochs_F] = F_Temp;
//						printf("Array %lf %d\n", F_Temp, NumberOfEpochs_F);
						NumberOfEpochs_F++;
					}
					fclose(FValuesFile);
//					printf("Make it here? %d\n", NumberOfEpochs_F);
					F = 0.0;
				}							

				else if (strcasecmp(ParameterFileArgument,"h:") == 0){
					if (hFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option h in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					hFlag = 1;
					
					printf("h: ");
					DotNumber = 0;
					MinusNumber = 0;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) && strcmp(SingleCharacter,".")!=0 && strcmp(SingleCharacter,"-")!=0){
							fprintf(stderr, "\nError: The value %s given in the option h is not a decimal number (commas are not allowed)\n", ParSubString);
							exit(8);
						}
						if (strcmp(SingleCharacter,".")==0 ){
							DotNumber++;
						}
						if (strcmp(SingleCharacter,"-")==0 ){
							MinusNumber++;
						}						
					}
					if (DotNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option h is not a decimal number (more than one dot was found)\n", ParSubString);
						exit(8);
					}	
					if (MinusNumber > 1) {
						fprintf(stderr, "\nError: The value %s given in the option h is not a decimal number (more than one negative sign was found)\n", ParSubString);
						exit(8);
					}											
					h = atof(ParSubString) ;
					printf("%lf\n",h);
				}
				else if (strcasecmp(ParameterFileArgument,"SFSFrequencyIntegrationInterval:") == 0){
					if (SFSIntIntervalFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option SFSFrequencyIntegrationInterval in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					SFSIntIntervalFlag = 1;
					
					printf("SFSFrequencyIntegrationInterval: ");					

					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option SFSFrequencyIntegrationInterval is not a nonnegative integer number (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}					
					IntegrationInterval = atoi(ParSubString);
					printf("%d\n",IntegrationInterval);
					
				}
				else if (strcasecmp(ParameterFileArgument,"SFSNoBurnIn:") == 0){
					if (SFSBurnInFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option SFSNoBurnIn in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					SFSBurnInFlag = 1;
					
					printf("SFSNoBurnIn: ");
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option SFSNoBurnIn is not a nonnegative integer number (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}					
					BurnInPopSize = atoi(ParSubString) ;
					printf("%d\n",BurnInPopSize);
				}							
								
				else if (strcasecmp(ParameterFileArgument,"n:") == 0){
					if (nFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option n in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					nFlag = 1;
					
					printf("n: ");
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option n is not a nonnegative integer number (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					n  = atoi(ParSubString) ;
					printf("%d\n",n);
				}							

				else if (strcasecmp(ParameterFileArgument,"ShortOutputFrequency:") == 0){
					if (ShortOutFreqFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option ShortOutputFrequency in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					ShortOutFreqFlag = 1;
					printf("ShortOutputFrequency: ");
					Short  = 1 ;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option ShortOutputFrequency is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					PrintingInterval = atoi(ParSubString);
					if (PrintingInterval != 0 && PrintingInterval != 1){
						fprintf(stderr, "\nError: The value %s given in the option ShortOutputFrequency is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					printf("%d\n",PrintingInterval);
				}
				
				else if (strcasecmp(ParameterFileArgument,"PrintSNPNumber:") == 0){
					if (PrintSNPNumberFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option PrintSNPNumber in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					PrintSNPNumberFlag = 1;
					printf("PrintSNPNumber: ");
					Short  = 1;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option PrintSNPNumber is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					num_snpFlag = atoi(ParSubString) ;
					if ((num_snpFlag != 0) && (num_snpFlag != 1)){
						fprintf(stderr, "\nError: The value %s given in the option PrintSNPNumber is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					printf("%d\n",num_snpFlag);
				}

				else if (strcasecmp(ParameterFileArgument,"PrintSumOfS:") == 0){
					if (PrintSNPOfSFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option PrintSumOfS in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					PrintSNPOfSFlag = 1;
					
					printf("PrintSumOfS: ");
					Short  = 1;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option PrintSumOfS is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					s_outFlag = atoi(ParSubString) ;
					if (s_outFlag != 0 && s_outFlag != 1){
						fprintf(stderr, "\nError: The value %s given in the option PrintSumOfS is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					printf("%d\n",s_outFlag);
				}

				else if (strcasecmp(ParameterFileArgument,"PrintAverageDAF:") == 0){
					if (PrintAverageDAFFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option PrintAverageDAF in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					PrintAverageDAFFlag = 1;
					
					printf("PrintAverageDAF: ");
					Short  = 1;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option PrintAverageDAF is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					average_mafFlag = atoi(ParSubString) ;
					if (average_mafFlag != 0 && average_mafFlag != 1){
						fprintf(stderr, "\nError: The value %s given in the option PrintAverageDAF is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					
					printf("%d\n",average_mafFlag);
				}

				else if (strcasecmp(ParameterFileArgument,"PrintWeightedSumOfS:") == 0){
					if (PrintWeightSumFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option PrintWeightedSumOfS in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					PrintWeightSumFlag = 1;
					
					printf("PrintWeightedSumOfS: ");
					Short  = 1;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option PrintWeightedSumOfS is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					s_weightFlag = atoi(ParSubString) ;
					if (s_weightFlag != 0 && s_weightFlag != 1){
						fprintf(stderr, "\nError: The value %s given in the option PrintWeightedSumOfS is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					printf("%d\n",s_weightFlag);
				}

				else if (strcasecmp(ParameterFileArgument,"PrintGenLoad:") == 0){
					if (PrintGenLoadFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option PrintGenLoad in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					PrintGenLoadFlag = 1;
					
					printf("PrintGenLoad: ");
					Short  = 1;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option PrintGenLoad is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					genloadFlag = atoi(ParSubString) ;
					if (genloadFlag != 0 && genloadFlag != 1){
						fprintf(stderr, "\nError: The value %s given in the option PrintGenLoad is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					printf("%d\n",genloadFlag);
				}
				
				else if (strcasecmp(ParameterFileArgument,"PrintFixedSites:") == 0){
					if (PrintFixedSitesFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option PrintFixedSites in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					PrintFixedSitesFlag = 1;
					
					printf("PrintFixedSites: ");
					Short  = 1;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option PrintFixedSites is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					fixed_sitesFlag = atoi(ParSubString) ;
					if (fixed_sitesFlag != 0 && fixed_sitesFlag != 1){
						fprintf(stderr, "\nError: The value %s given in the option PrintFixedSites is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					printf("%d\n",fixed_sitesFlag);
				}

				else if (strcasecmp(ParameterFileArgument,"PrintSegSiteInfo:") == 0){
					if (PrintSegSiteFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option PrintSegSiteInfo in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					PrintSegSiteFlag = 1;
					
					printf("PrintSegSiteInfo: ");
					Short  = 1;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option PrintSegSiteInfo is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					full_outFlag = atoi(ParSubString) ;
					if (full_outFlag != 0 && full_outFlag != 1){
						fprintf(stderr, "\nError: The value %s given in the option PrintSegSiteInfo is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					
					printf("%d\n",full_outFlag);
				}
				
				else if (strcasecmp(ParameterFileArgument,"PrintSampledGenotypes:") == 0){
					if (PrintSampledGenFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option PrintSampledGenotypes in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					PrintSampledGenFlag = 1;
					
					printf("PrintSampledGenotypes: ");
					Short  = 1;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option PrintSampledGenotypes is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					het_outFlag = atoi(ParSubString) ;
					if (het_outFlag != 0 && het_outFlag != 1){
						fprintf(stderr, "\nError: The value %s given in the option PrintSampledGenotypes is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					
					printf("%d\n",het_outFlag);
				}
				
				else if (strcasecmp(ParameterFileArgument,"PrintSFS:") == 0){
					if (PrintSFSFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option PrintSFS in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					PrintSFSFlag = 1;
					
					printf("PrintSFS: ");
					Short  = 1;
					for (j=0; j<strlen(ParSubString); j++) {
						strncpy(SingleCharacter,ParSubString+j,1);
						// && strcmp(SingleCharacter,".")!=0
						if (!isdigit((int) SingleCharacter[0]) ){
							fprintf(stderr, "\nError: The value %s given in the option PrintSFS is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
							exit(8);
						}
					}
					sfs_outFlag = atoi(ParSubString) ;
					if (sfs_outFlag != 0 && sfs_outFlag != 1){
						fprintf(stderr, "\nError: The value %s given in the option PrintSFS is not an integer number equal to 0 or 1 (no dots or commas allowed)\n", ParSubString);
						exit(8);						
					}
					printf("%d\n",sfs_outFlag);
				}

				else if (strcasecmp(ParameterFileArgument,"FilePrefix:") == 0){
					if (FilePrefixFlag == 1){
						fprintf(stderr, "\nError: At least two occurences of the option FilePrefix in the parameter file. Use that option only once in the parameter file.\n");
						exit(8);
					}
					FilePrefixFlag = 1;
					
					printf("FilePrefix: ");
					strcpy(OutputFilePrefix,ParSubString);
//					OutputFilePrefix = ParSubString ;
					printf("%s\n",ParSubString);
//					printf("%s\n",OutputFilePrefix);
				}
				else {
					fprintf(stderr, "Error: Option %s not found.\n",ParameterFileArgument);
					exit(8);
				}

				break;
				
//				int num_snpFlag = 0, s_outFlag = 0, average_mafFlag = 0, s_weightFlag = 0, genloadFlag = 0, sfs_outFlag = 0, het_outFlag = 0, full_outFlag = 0, fixed_sitesFlag = 0 ; 

				
			}
			LinePart = strtok (NULL, " \t\r");
			StringParPart++;
		} 
	} 
	fclose(PARFILE);
//	return 0;
// 	path=argv[1]; 

//	printf("num: %d\n",num);
//	printf("DFE Type %s \n",type_sel);
//	printf("DFE Type %s %d\n",type_sel, ParamOneFlag);
	//     fprintf(stderr,"%d\t%d\t%d\t%d\t%d\t%d\t%ld\t%lf\t%d\t%d\t%s\t%d\t%d\t%lf\t%lf\n", N[0], gen[0], N[1], gen[1], N[2], gen[2], seed, mut_rate,num, run, type_sel, N[3], gen[3], F, h);
//	fprintf(stderr,"%s\n",path);
	if (MutationRateFlag == 0){
		fprintf(stderr, "Error: Please add the option MutationRate and give a particular value for it.\n");
		exit(8);	
	}
	
	if (DFETypeFlag == 0){
		fprintf(stderr, "Error: Please add the option DFEType and select a particular distribution (\"point\", \"gamma\", \"lognormal\", \"beta\", \"pointprob\", \"unifbounds\").\n");
		exit(8);	
	}
	
	if (AlleleTrajsInputFlag == 0 && AlleleTrajsOutputFlag == 1){
		fprintf(stderr, "Error: Please add AlleleTrajsInput option with an input file.\n");
		exit(8);
	}
	
	if (AlleleTrajsInputFlag == 1 && AlleleTrajsOutputFlag == 0){
		fprintf(stderr, "Error: Please add AlleleTrajsOutput option with an output file.\n");
		exit(8);
	}
	
	if (DemographicHistoryFlag == 0){
		fprintf(stderr, "Error: Please add DemographicHistory option with a demographic history file.\n");
		exit(8);		
	}
	
	if ((strcasecmp(type_sel,"point") != 0) && (strcasecmp(type_sel,"gamma") != 0) && (strcasecmp(type_sel,"lognormal") != 0) && (strcasecmp(type_sel,"beta") != 0) && (strcasecmp(type_sel,"pointprob") != 0) && (strcasecmp(type_sel,"unifbounds") != 0)){
		fprintf(stderr, "Error: The distribution type DFEType was not correctly written %s .\n",type_sel);
		exit(8);
	}
	
	if ((strcasecmp(type_sel,"point") == 0) && (ParamOneFlag == 0) ){
		fprintf(stderr, "Error: The DFE point requires one parameter given by DFEPointSelectionCoefficient\n");
		exit(8);
	}

	if ((strcasecmp(type_sel,"gamma") == 0) && ((ParamOneFlag == 0) || (ParamTwoFlag == 0) || (ParamThreeFlag == 0) )){
		fprintf(stderr, "Error: The DFE gamma requires three parameters given by the three options DFEParameterOne , DFEParameterTwo and DFEParameterThree\n");
		exit(8);
	}

	if ((strcasecmp(type_sel,"lognormal") == 0) && ((ParamOneFlag == 0) || (ParamTwoFlag == 0) || (ParamThreeFlag == 0) )){
		fprintf(stderr, "Error: The DFE lognormal requires three parameters given by the three options DFEParameterOne , DFEParameterTwo and DFEParameterThree\n");
		exit(8);
	}

	if ((strcasecmp(type_sel,"beta") == 0) && ((ParamOneFlag == 0) || (ParamTwoFlag == 0)  )){
		fprintf(stderr, "Error: The DFE beta requires three parameters given by the two options DFEParameterOne , DFEParameterTwo and DFEParameterThree\n");
		exit(8);
	}

	if ((strcasecmp(type_sel,"pointprob") == 0) && ((ParamOneFlag == 0) || (ParamThreeFlag == 0) )){
		fprintf(stderr, "Error: The DFE pointprob requires two parameters given by the three options DFEParameterOne and DFEParameterThree. In DFEParameterOne you must add a file as described in the manual\n");
		exit(8);
	}

	if ((strcasecmp(type_sel,"unifbounds") == 0) && ((ParamOneFlag == 0) || (ParamThreeFlag == 0) )){
		fprintf(stderr, "Error: The DFE unifbounds requires two parameters given by DFEParameterOne and DFEParameterThree. In DFEParameterOne you must add a file as described in the manual\n");
		exit(8);
	}

	if ((strcasecmp(type_sel,"gamma") == 0) ){
		if (DistParamOne <= 0){
		fprintf(stderr, "Error: The shape parameter of the gamma distribution must be bigger than zero. Modify this on the value given in the option DFEParameterOne\n");
		exit(8);
		}
		if (DistParamTwo <= 0){
			fprintf(stderr, "Error: The scale parameter of the gamma distribution must be bigger than zero. Modify this on the value given in the option DFEParameterTwo\n");
			exit(8);
		}
	}	

	if ((strcasecmp(type_sel,"lognormal") == 0) ){
		if (DistParamTwo < 0){
			fprintf(stderr, "Error: The standard deviation of the lognormal distribution must have a nonnegative value.  Modify this on the value given in the option DFEParameterTwo.\n");
			exit(8);
		}
	}	

	if ((strcasecmp(type_sel,"beta") == 0) ){
		if (DistParamOne <= 0){
			fprintf(stderr, "Error: The alpha parameter of the beta distribution must be bigger than zero. Modify this on the value given in the option DFEParameterOne\n");
			exit(8);
		}
		if (DistParamTwo <= 0){
			fprintf(stderr, "Error: The beta parameter of the beta distribution must be bigger than zero. Modify this on the value given in the option DFEParameterTwo\n");
			exit(8);
		}
	}	
	
	if ((strcasecmp(type_sel,"pointprob") == 0) ){
		for (j = 0; j < NumberOfSelParameters; j++){
			if (j == 0 ){
				if ((VectorSelParamTwo[j] < 0) || (VectorSelParamTwo[j] > 1)){
					fprintf(stderr, "Error: The values from the second column of the file from the parameter DFEPointProbSelectionFile must be bounded between 0 and 1 and must be given in an ascendent order. The value %lf from the row %i is not bounded between 0 and 1.\n",VectorSelParamTwo[j],j);
					exit(8);
				}
			}
			
			if (VectorSelParamTwo[j-1] > VectorSelParamTwo[j] ){
				fprintf(stderr, "Error: The values from the second column of the file from the parameter DFEPointProbSelectionFile must be bounded between 0 and 1 and must be given in an ascendent order. The value %lf from the row %i is smaller than $lf\n",VectorSelParamTwo[j],j,VectorSelParamTwo[j-1]);
				exit(8);
			}
		}
		if (VectorSelParamTwo[NumberOfSelParameters-1] != 1.0){
			fprintf(stderr, "Error: The last row of the value from the second column of the file from the parameter DFEPointProbSelectionFile must be equal to 1.\n");
			exit(8);

		}
	}
	
	if ((strcasecmp(type_sel,"unifbounds") == 0) ){
		for (j = 0; j < NumberOfSelParameters; j++){
			if (j == 0 ){
				if ((VectorSelParamThree[j] < 0) || (VectorSelParamThree[j] > 1)){
					fprintf(stderr, "Error: The values from the third column of the file from the parameter DFEUnifBoundsSelectionFile must be bounded between 0 and 1 and must be given in an ascendent order. The value %lf from the row %i is not bounded between 0 and 1.\n",VectorSelParamThree[j],j);
					exit(8);
				}
			}
			
			if (VectorSelParamThree[j-1] > VectorSelParamThree[j] ){
				fprintf(stderr, "Error: The values from the third column of the file from the parameter DFEUnifBoundsSelectionFile must be bounded between 0 and 1 and must be given in an ascendent order. The value %lf from the row %i is smaller than $lf\n",VectorSelParamThree[j],j,VectorSelParamThree[j-1]);
				exit(8);
			}
		}
		if (VectorSelParamThree[NumberOfSelParameters-1] != 1.0){
			fprintf(stderr, "Error: The last row of the value from the second column of the file from the parameter DFEUnifBoundsSelectionFile must be equal to 1.\n");
			exit(8);
			
		}
	}
	
  //float N = 1000; /*size for binom dist*/
  float rv; /*binom rv straight from draw*/
  int i, TempGenCounter; /*counter*/
  //struct linked_list *kl;

  int e; /*epoch counter*/			
  
  FILE *MAF_OUT;
  FILE *S_OUT;
  FILE *NUM_SNP_OUT;
  FILE *WEIGHT_S_OUT;
  FILE *GEN_LOAD;

printf ("\nDemographic History ( %i epochs )\n\n", NumberOfEpochs);
if (F_fixedflag == 1){
F_Epochs = malloc(NumberOfEpochs*sizeof(double));
}
for (e = 0; e < NumberOfEpochs; e++){
printf("Ne = %i\tgenerations = %i\t", N[e], gen[e]);
if (F_fixedflag == 1){
F_Epochs[e] = F;
}
	printf("F = %lf\n",F_Epochs[e]);
}
	printf("\n");
//printf("Here?\n");
// return 0;
//set up GSL:
   const gsl_rng_type * T;
   gsl_rng * r;
   gsl_rng_env_setup();
   T = gsl_rng_default;
   r = gsl_rng_alloc (T);

  //open  files for the condensed output:
if(Short==1)
{
	
//	int num_snpFlag = 0, s_outFlag = 0, average_mafFlag = 0, s_weightFlag = 0, genloadFlag = 0, sfs_outFlag = 0, het_outFlag = 0, full_outFlag = 0, fixed_sitesFlag = 0 ; 
//first for s:
	if (s_outFlag==1){
char file_out[1000];
 sprintf(file_out, "%s.%d.s_out.txt",OutputFilePrefix,num);
//  FILE *S_OUT;
  S_OUT = fopen(file_out, "w"); /*output file for s, with no scaling*/
  if (S_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to read output file\n");
      exit(8);
	}
	}
  
//now for num snps:
	if (num_snpFlag==1){
char file_out_num[1000];
 sprintf(file_out_num, "%s.%d.num_snp_out.txt",OutputFilePrefix,num);
  //FILE *NUM_SNP_OUT;
  NUM_SNP_OUT = fopen(file_out_num, "w"); /*output file for num snps*/
  if (NUM_SNP_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to create output file %s\n",file_out_num);
      exit(8);
	}}
 

//now for freq weighted S:
	if(s_weightFlag==1){
char file_out_weight[1000];
 sprintf(file_out_weight, "%s.%d.s_weight_out.txt",OutputFilePrefix,num);
  //FILE *WEIGHT_S_OUT;
  WEIGHT_S_OUT = fopen(file_out_weight, "w"); /*output file for freq weighted s*/
  if (WEIGHT_S_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to create output file %s\n",file_out_weight);
      exit(8);
	}}


//now for average maf:
	if(average_mafFlag==1){
char file_out_maf[1000];
 sprintf(file_out_maf, "%s.%d.average_maf_out.txt",OutputFilePrefix,num);
  //FILE *MAF_OUT;
  MAF_OUT = fopen(file_out_maf, "w"); /*output file for average maf*/
  if (WEIGHT_S_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to create output file %s\n",file_out_maf);
      exit(8);
	}}

//now for number of fixed sites:
	if(fixed_sitesFlag==1){
	char file_out_fixed[1000];
	sprintf(file_out_fixed, "%s.%d.fixed_sites_out.txt",OutputFilePrefix,num);
	//FILE *MAF_OUT;
	FIXEDSITESFILE = fopen(file_out_fixed, "w"); /*output file for average maf*/
	if (FIXEDSITESFILE == NULL)
    {
		fprintf(stderr, "Error: unable to create output file %s\n",file_out_fixed);
		exit(8);
	}}

//now for genetic load
	if(genloadFlag==1){
	char file_out_genload[1000];
	sprintf(file_out_genload, "%s.%d.gen_load_out.txt",OutputFilePrefix,num);
	//FILE *MAF_OUT;
	GEN_LOAD = fopen(file_out_genload, "w"); /*output file for average maf*/
	if (GEN_LOAD == NULL)
    {
		fprintf(stderr, "Error: unable to create output file %s\n",file_out_genload);
		exit(8);
	}}
	

} //close if statement around short.


//now actually run evolution!
//note, here we can look at 4 epochs!
	
if ((SFSBurnInFlag==1) && ((strcasecmp(type_sel,"point") == 0)) && (h == 0.5)){

	TheoreticalSFS = malloc(BurnInPopSize*sizeof(double));
	gsl_integration_workspace * w = gsl_integration_workspace_alloc (1000);
	double result, error, SFSBasedAlleleFrequency;

	gsl_function IntegrableFunction;
	IntegrableFunction.function = &f_of_q_lambda;

	BurnInPopSizeInIntegrableFunction = BurnInPopSize;
	PointSelInIntegrableFunction = PointSel;
	SampleSizeInIntegrableFunction = BurnInPopSize;
	ThetaInIntegrableFunction = mut_rate * 2;
	
	for (jInIntegrableFunction = 1; jInIntegrableFunction< BurnInPopSize; jInIntegrableFunction++){
		gsl_integration_qags (&IntegrableFunction, 0, 1, 0, 1e-9, 1000, w, &result, &error); 
		TheoreticalSFS[jInIntegrableFunction-1] = result;
		SFSBasedAlleleFrequency = (float) jInIntegrableFunction / (float) BurnInPopSize;
		NumberOfMutationsToAdd = TheoreticalSFS[jInIntegrableFunction-1];
//		printf ("%d\t%.18f\t%lf\n", jInIntegrableFunction, TheoreticalSFS[jInIntegrableFunction-1], NumberOfMutationsToAdd);
	// struct linked_list *add_mutation_BurnIn(struct linked_list *head_ptr, double mut_rate, int N, gsl_rng * r, int age, char *type_sel, double sel_mult, double h , double PointSel, int *ListOfAllelesToKeep, int FlagTrajToPrint, FILE *EXITTRAJFILE , int FlagRelaxationSel, double SelThreshold, double NewSelCoef , double ParamOne, double ParamTwo,  double ParamThree, int TypeRelaxedSelection, double *VecSelParamOne, double *VecSelParamTwo, double *VecSelParamThree, int NumberOfSelPars, double SFSBasedAlleleFrequency);
	first_ptr = add_mutation_BurnIn(first_ptr,NumberOfMutationsToAdd, BurnInPopSize, r, -1, type_sel, sel_mult, h, PointSel, ListOfAllelesToKeep, FlagTrajToPrint, EXITTRAJFILE, 0, SelectionThreshold, NewSelectionCoefficient, DistParamOne, DistParamTwo, DistParamThree, TypeOfRelaxedSelection, VectorSelParamOne , VectorSelParamTwo , VectorSelParamThree, NumberOfSelParameters, SFSBasedAlleleFrequency);	

	}		
//	exit(8);

}
	
  for (e=0; e<NumberOfEpochs; e++)
    {
 
	N_F=(double)N[e]/(1.0+F_Epochs[e]); //this adjusts Ne for inbreeding
     printf("Currently in epoch = %i ; Mutations before epoch's beginning = %i\n", e ,count_mut);
	if (FlagRelaxationSelection == 1 && EpochOfRelaxation == e){
		printf("Relaxation here Flag %i Epoch %i\n", FlagRelaxationSelection , EpochOfRelaxation);
		first_ptr = relax_selection(first_ptr, NewSelectionCoefficient, SelectionThreshold, TypeOfRelaxedSelection);
	}
      for (g=0; g<gen[e]; g++)
	{
	
		//now need to figure out the age of the mutation:

		if(e==0)
		{
			//means we're in the earliest epoch
			age=g;
		}

		else
		{
			//means we're in the middle epoch
			//
			TempGenCounter = 0;
			for (j = 0; j < e ; j++){
				TempGenCounter = TempGenCounter + gen[j];
			}
			age=TempGenCounter+g;
		}
/*		else if (e==2)
		{
			//mean's we're in teh 2nd most recent epoch 
			age=gen[0]+gen[1]+g;
		}
		else if (e==3)
		{
			//mean's we're in teh most recent epoch
			age=gen[0]+gen[1]+gen[2]+g;
		}
*/
		if(e==0 && (g % PrintingInterval)==0 && Short==1)
		{
			//means we should do the timed sampling

			short_output(first_ptr, S_OUT, NUM_SNP_OUT, WEIGHT_S_OUT,  MAF_OUT, GEN_LOAD,num, run, n, r,num_snpFlag , s_outFlag , average_mafFlag , s_weightFlag , genloadFlag, sfs_outFlag);
		}
		else if(e>0 && (g % PrintingInterval)==0 && Short==1)
		{
			//means we should do the timed sampling

			short_output(first_ptr, S_OUT, NUM_SNP_OUT, WEIGHT_S_OUT,  MAF_OUT, GEN_LOAD, num, run, n, r,num_snpFlag , s_outFlag , average_mafFlag , s_weightFlag , genloadFlag, sfs_outFlag);
		}
		
		if (age == 39999){
//			printf("Exit at generation 39999!\n");
		}
//	printf("age = %i %lf\n", age , mut_rate);
//	fprintf(stderr,"Generation:\t%d\n",g);
//	 fprintf(EXITTRAJFILE,"Age = %d\n",age);
		ModuloFixedSitesToPrint = g % PrintingInterval;
	  first_ptr = drift_sel(first_ptr,N_F, r, F_Epochs[e], FlagTrajToPrint, ListOfAllelesToKeep, EXITTRAJFILE, FIXEDSITESFILE, Short,  0, ModuloFixedSitesToPrint, fixed_sitesFlag);
	if (FlagRelaxationSelection == 1 && e >= EpochOfRelaxation){
	first_ptr = add_mutation(first_ptr,mut_rate, N_F, r, age, type_sel, sel_mult, h, PointSel, ListOfAllelesToKeep, FlagTrajToPrint, EXITTRAJFILE, FlagRelaxationSelection, SelectionThreshold, NewSelectionCoefficient, DistParamOne, DistParamTwo, DistParamThree, TypeOfRelaxedSelection, VectorSelParamOne , VectorSelParamTwo , VectorSelParamThree, NumberOfSelParameters);	
	}else{
	  first_ptr = add_mutation(first_ptr,mut_rate, N_F, r, age, type_sel, sel_mult, h, PointSel, ListOfAllelesToKeep, FlagTrajToPrint, EXITTRAJFILE, 0, SelectionThreshold, NewSelectionCoefficient, DistParamOne, DistParamTwo, DistParamThree, TypeOfRelaxedSelection, VectorSelParamOne , VectorSelParamTwo , VectorSelParamThree , NumberOfSelParameters);
	}
//	return 0;
	  /*struct linked_list *current_ptr;
	  current_ptr = first_ptr;
	  while (current_ptr != NULL)
	    {
	      (*current_ptr).count= ((*current_ptr).count);
	      //printf("%f\n", (*current_ptr).count);
	      current_ptr = current_ptr ->next_ptr;
	      }*/
	}

      if (e< (NumberOfEpochs - 1 ))
	{

	  //mut_rate = ((mut_rate*(double)N[(e+1)])/(double)N[e]); //old one!

	N_F_1=(double)N[e+1]/(1.0+F_Epochs[e+1]);  
	mut_rate = ((mut_rate*(double)N_F_1)/(double)N_F);

	}
	 
	
    

}

printf("\nTotal number of mutations = %i\n", count_mut);

if (SampleFlag == 1){
first_ptr = drift_sel(first_ptr,SampleSize, r, F_Epochs[e-1], FlagTrajToPrint, ListOfAllelesToKeep, EXITTRAJFILE, FIXEDSITESFILE ,Short, SampleFlag, 1, 0);
}

  //open a file with the full output:
	  FILE *FULL_OUT;
	if (full_outFlag == 1){

char file_out_full[1000];
 sprintf(file_out_full, "%s.%d.full_out.txt",OutputFilePrefix,num);
  FULL_OUT = fopen(file_out_full, "w"); //output file for sfs
  if (FULL_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to create output file %s\n",file_out_full);
      exit(8);
	}
	}
 
//now create dog output
	  FILE *DOG_OUT;
	if (het_outFlag == 1) {
char file_out_dog[1000];
 sprintf(file_out_dog, "%s.%d.dog_out.txt",OutputFilePrefix,num);
  DOG_OUT = fopen(file_out_dog, "w"); //output file for dog stuff
  if (DOG_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to create output file %s\n",file_out_dog);
      exit(8);
      }
		}
 
//now create sfs output
	  FILE *SFS_OUT;
	if (sfs_outFlag == 1){
char file_out_sfs[1000];
 sprintf(file_out_sfs, "%s.%d.sfs_out.txt",OutputFilePrefix,num);
  SFS_OUT = fopen(file_out_sfs, "w"); //output file for sfs stuff
  if (SFS_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to create output file %s\n",file_out_sfs);
      exit(8);
      }
	}
 
 
	if(Short==1)
	{ 
		short_output(first_ptr, S_OUT, NUM_SNP_OUT, WEIGHT_S_OUT,  MAF_OUT, GEN_LOAD, num, run, n, r,num_snpFlag , s_outFlag , average_mafFlag , s_weightFlag , genloadFlag, sfs_outFlag);
 
	//num_snpFlag = 0, s_outFlag = 0, average_mafFlag = 0, s_weightFlag = 0, genloadFlag = 0, sfs_outFlag = 0, het_outFlag = 0, full_outFlag = 0, fixed_sitesFlag = 0 ; 
		
		if(s_outFlag==1){
		fprintf(S_OUT, "\n");
		}
		if(num_snpFlag==1){
		fprintf(NUM_SNP_OUT, "\n");
		}
		if(s_weightFlag==1){
		fprintf(WEIGHT_S_OUT, "\n");
		}
		if(average_mafFlag==1){
		fprintf(MAF_OUT, "\n");
		}
		if(genloadFlag==1){
		fprintf(GEN_LOAD, "\n");
		}
	}
	if (full_outFlag == 1){
	 full_output(first_ptr, FULL_OUT,num, run);
	}
	if (het_outFlag == 1) {
	 dog_output(first_ptr, DOG_OUT,num, run, F_Epochs[e-1],r);
	}
	if (sfs_outFlag == 1){
	sfs_output(first_ptr, SFS_OUT,  num,  run,  n, r);
	}

   gsl_rng_free (r);
 return(0);
}



struct linked_list *add_mutation(struct linked_list *head_ptr, double mut_rate, int N, gsl_rng * r, int age, char *type_sel, double sel_mult, double h, double PointSel, int *ListOfAllelesToKeep, int FlagTrajToPrint, FILE *EXITTRAJFILE, int FlagRelaxationSel, double SelThreshold, double NewSelCoef, double ParamOne, double ParamTwo,  double ParamThree, int TypeRelaxedSelection, double *VecSelParamOne, double *VecSelParamTwo, double *VecSelParamThree , int NumberOfSelPars)
{
  //now add the rv to the linked list

  //pick how many mutations to add:
  unsigned int num_mut;
  int x;
  int SelIterator;
  double gamma, randomvar;
  double sel;
  double CurSelThreshold;
  int arrayiterator;
  num_mut=gsl_ran_poisson(r, mut_rate);
  total_mut = total_mut + num_mut;
  //printf("num mutations: %f\n", num_mut);
  CurSelThreshold = SelThreshold;
  for(x=0; x<(int)num_mut; x++)
    {
      
	//old boyko log normal--note, this wasn't even teh final parameters
      // gamma = gsl_ran_lognormal(r,5.22,6.88);
      //sel=gamma/(44520.0);


	//new gamma distribution
 


//Use this for gamma distribution in Boyko 2008:
//     gamma = gsl_ran_gamma(r,0.184,319.8626); //note, this is scale for a Nanc=1000, using the boyko params
 //     sel=gamma/(2000.0);






//Set a fixed s:

	if(strcasecmp(type_sel,"point")==0)
	{ 
	//sel=0.005;
	//sel=0.001331913;
	sel= PointSel;
	}

	else if(strcasecmp(type_sel,"dist")==0)	
	{

	//Use this for gamma distribution in Boyko 2008:
    	 gamma = gsl_ran_gamma(r,0.184,319.8626*sel_mult); //note, this is scale for a Nanc=1000, using the boyko params
    	  sel=gamma/(2000.0);
 	}else if (strcasecmp(type_sel,"gamma")==0){
          gamma = gsl_ran_gamma(r,ParamOne,ParamTwo*sel_mult);
           sel=gamma/(2 * ParamThree);
	}else if (strcasecmp(type_sel,"beta")==0){
         randomvar = gsl_ran_beta(r,ParamOne,ParamTwo*sel_mult); 
           sel=randomvar;
	}else if (strcasecmp(type_sel,"lognormal")==0){
	 randomvar = gsl_ran_lognormal(r,ParamOne,ParamTwo*sel_mult);
	 sel=randomvar/(2 * ParamThree);
	}else if (strcasecmp(type_sel,"pointprob")==0 ){
	 randomvar = gsl_ran_flat(r,0,1);
	for (SelIterator = 0; SelIterator < NumberOfSelPars; SelIterator++){
	 if (randomvar <= VecSelParamTwo[SelIterator]){
	break;
	}
	}	
	sel = VecSelParamOne[SelIterator] / ( 2 * ParamThree);
//	printf("Current sel = %f %f %i %f\n", VecSelParamOne[SelIterator], randomvar, SelIterator, VecSelParamTwo[SelIterator]);
	}else if ( strcasecmp(type_sel,"unifbounds")==0 ){
	 randomvar = gsl_ran_flat(r,0,1);
        for (SelIterator = 0; SelIterator < NumberOfSelPars; SelIterator++){
         if (randomvar <= VecSelParamThree[SelIterator]){
        break;
        }
        }
	if (SelIterator == 0){
		sel = (randomvar/ (VecSelParamThree[SelIterator])) * (VecSelParamTwo[SelIterator] - VecSelParamOne[SelIterator]) + VecSelParamOne[SelIterator];
	}else{
		sel = (( randomvar - VecSelParamThree[SelIterator-1]) / (VecSelParamThree[SelIterator] - VecSelParamThree[SelIterator-1])) * (VecSelParamTwo[SelIterator] - VecSelParamOne[SelIterator]) + VecSelParamOne[SelIterator];	
	}
	sel = sel / (2 * ParamThree);
	}
	else
	{
		sel=0;
	}




      if (sel>0.5)
	{
	  sel=0.5;
	}


	if (FlagRelaxationSel == 0){
    	 sel = sel*2.0;
	}else{
	if ( sel <= CurSelThreshold && TypeRelaxedSelection == 0 ){
	 sel = NewSelCoef * 2.0;
	}else if ( sel <= CurSelThreshold && TypeRelaxedSelection == 1 ){
	 sel = (sel*2.0)*NewSelCoef;
	}
	}
//      sel=0.01;
	
	  //draw h from a beta distribution:
	  //double h_beta = gsl_ran_beta(r, 1.0,4.0);
	  double h_beta = h; //this takes in h from cmnd line
	  //printf("%f\n",sel);
       
	  struct linked_list *new_item_ptr;
	  new_item_ptr = malloc(sizeof(struct linked_list));
	  (*new_item_ptr).count = (1.0/(double)N);
	  (*new_item_ptr).h = h_beta;
	  (*new_item_ptr).sel_coef = sel;
	  (*new_item_ptr).count_samp = 0.0;
	  (*new_item_ptr).next_ptr = head_ptr;
	  (*new_item_ptr).age = age;
	  (*new_item_ptr).num = count_mut;
	  head_ptr = new_item_ptr;

	for (arrayiterator = 0; arrayiterator < FlagTrajToPrint ; arrayiterator++){
		if ( count_mut == ListOfAllelesToKeep[arrayiterator]){
		fprintf(EXITTRAJFILE,"%d\t%lf\n", count_mut, (1.0/(double)N));
		}
	}

	count_mut++;
	
    }
  return(head_ptr);
}



struct linked_list *add_mutation_BurnIn(struct linked_list *head_ptr, double mut_rate, int N, gsl_rng * r, int age, char *type_sel, double sel_mult, double h, double PointSel, int *ListOfAllelesToKeep, int FlagTrajToPrint, FILE *EXITTRAJFILE, int FlagRelaxationSel, double SelThreshold, double NewSelCoef, double ParamOne, double ParamTwo,  double ParamThree, int TypeRelaxedSelection, double *VecSelParamOne, double *VecSelParamTwo, double *VecSelParamThree , int NumberOfSelPars, double SFSBasedAlleleFrequency)
{
	//now add the rv to the linked list
	
	//pick how many mutations to add:
	unsigned int num_mut;
	int x;
	int SelIterator;
	double gamma, randomvar;
	double sel;
	double CurSelThreshold;
	int arrayiterator;
	num_mut=gsl_ran_poisson(r, mut_rate);

//	num_mut=mut_rate;
	total_mut = total_mut + num_mut;
	//printf("num mutations: %f\n", num_mut);
	CurSelThreshold = SelThreshold;
	for(x=0; x<(int)num_mut; x++)
    {
		
		//old boyko log normal--note, this wasn't even teh final parameters
		// gamma = gsl_ran_lognormal(r,5.22,6.88);
		//sel=gamma/(44520.0);
		
		
		//new gamma distribution
		
		
		
		//Use this for gamma distribution in Boyko 2008:
		//     gamma = gsl_ran_gamma(r,0.184,319.8626); //note, this is scale for a Nanc=1000, using the boyko params
		//     sel=gamma/(2000.0);
		
		
		
		
		
		
		//Set a fixed s:
		
		if(strcasecmp(type_sel,"point")==0)
		{ 
			//sel=0.005;
			//sel=0.001331913;
			sel= PointSel;
		}
		
		else if(strcasecmp(type_sel,"dist")==0)	
		{
			
			//Use this for gamma distribution in Boyko 2008:
			gamma = gsl_ran_gamma(r,0.184,319.8626*sel_mult); //note, this is scale for a Nanc=1000, using the boyko params
			sel=gamma/(2000.0);
		}else if (strcasecmp(type_sel,"gamma")==0){
			gamma = gsl_ran_gamma(r,ParamOne,ParamTwo*sel_mult);
			sel=gamma/(2 * ParamThree);
		}else if (strcasecmp(type_sel,"beta")==0){
			randomvar = gsl_ran_beta(r,ParamOne,ParamTwo*sel_mult); 
			sel=randomvar;
		}else if (strcasecmp(type_sel,"lognormal")==0){
			randomvar = gsl_ran_lognormal(r,ParamOne,ParamTwo*sel_mult);
			sel=randomvar/(2 * ParamThree);
		}else if (strcasecmp(type_sel,"pointprob")==0 ){
			randomvar = gsl_ran_flat(r,0,1);
			for (SelIterator = 0; SelIterator < NumberOfSelPars; SelIterator++){
				if (randomvar <= VecSelParamTwo[SelIterator]){
					break;
				}
			}	
			sel = VecSelParamOne[SelIterator] / ( 2 * ParamThree);
			//	printf("Current sel = %f %f %i %f\n", VecSelParamOne[SelIterator], randomvar, SelIterator, VecSelParamTwo[SelIterator]);
		}else if ( strcasecmp(type_sel,"unifbounds")==0 ){
			randomvar = gsl_ran_flat(r,0,1);
			for (SelIterator = 0; SelIterator < NumberOfSelPars; SelIterator++){
				if (randomvar <= VecSelParamThree[SelIterator]){
					break;
				}
			}
			if (SelIterator == 0){
				sel = (randomvar/ (VecSelParamThree[SelIterator])) * (VecSelParamTwo[SelIterator] - VecSelParamOne[SelIterator]) + VecSelParamOne[SelIterator];
			}else{
				sel = (( randomvar - VecSelParamThree[SelIterator-1]) / (VecSelParamThree[SelIterator] - VecSelParamThree[SelIterator-1])) * (VecSelParamTwo[SelIterator] - VecSelParamOne[SelIterator]) + VecSelParamOne[SelIterator];	
			}
			sel = sel / (2 * ParamThree);
		}
		else
		{
			sel=0;
		}
		
		
		
		
		if (sel>0.5)
		{
			sel=0.5;
		}
		
		
		if (FlagRelaxationSel == 0){
			sel = sel*2.0;
		}else{
			if ( sel <= CurSelThreshold && TypeRelaxedSelection == 0 ){
				sel = NewSelCoef * 2.0;
			}else if ( sel <= CurSelThreshold && TypeRelaxedSelection == 1 ){
				sel = (sel*2.0)*NewSelCoef;
			}
		}
		//      sel=0.01;
		
		//draw h from a beta distribution:
		//double h_beta = gsl_ran_beta(r, 1.0,4.0);
		double h_beta = h; //this takes in h from cmnd line
		//printf("%f\n",sel);
		
		struct linked_list *new_item_ptr;
		new_item_ptr = malloc(sizeof(struct linked_list));
		(*new_item_ptr).count = SFSBasedAlleleFrequency;
		(*new_item_ptr).h = h_beta;
		(*new_item_ptr).sel_coef = sel;
		(*new_item_ptr).count_samp = 0.0;
		(*new_item_ptr).next_ptr = head_ptr;
		(*new_item_ptr).age = age;
		(*new_item_ptr).num = count_mut;
		head_ptr = new_item_ptr;
//		printf("Allele frequency = %lf\n",(*new_item_ptr).count);
		for (arrayiterator = 0; arrayiterator < FlagTrajToPrint ; arrayiterator++){
			if ( count_mut == ListOfAllelesToKeep[arrayiterator]){
				fprintf(EXITTRAJFILE,"%d\t%lf\n", count_mut, (1.0/(double)N));
			}
		}
		
		count_mut++;
		
    }
	return(head_ptr);
}


struct linked_list *drift_sel(struct linked_list *head_ptr, int N, gsl_rng * r, double F, int FlagTrajToPrint, int *ListOfAllelesToKeep, FILE *EXITTRAJFILE, FILE *FIXEDSITESFILE, int ShortFlag, int SampleFlag, int ModuloFixedSitesToPrint, int fixed_sitesFlag)
{
	int DerivedSitesFixed = 0, ReferenceSitesFixed = 0;
	double sumfixeds = 0.0;
  if (head_ptr != NULL)
    {
  
 struct linked_list *lag_current_ptr = head_ptr; //lab_current_ptr will point to the address of the previous node. Initialize to the head ptr
  struct linked_list *lead_current_ptr; //this is the ptr for the current element.
  struct linked_list *temp_ptr; //this is a temporary pt a temporary ptrr 
  double freq_head; //freq of head node
  double freq; //freq of any node of list other than head
  int test = 0;
  double s;
  double h;
  int freq_count;
  unsigned int freq_count_head;
 int count_use;
int ArrayIterator, ArrayCounter, MaxArrayNumber;
int Iterator;
/* for (ArrayIterator = 0; ArrayIterator < FlagTrajToPrint; ArrayIterator++){
printf("%d\t%d\n", ArrayIterator, ListOfAllelesToKeep[ArrayIterator]);
} */

  freq_head = ((*head_ptr).count); //convert count into proportion
  if (SampleFlag == 1){
	s = 0.0;
	printf("Random sampling works!\n");
  }else{
  s = ((*head_ptr).sel_coef);
  }
  h = ((*head_ptr).h);
  //freq_head = (freq_head*freq_head*(1-s)+(freq_head)*(1-freq_head)*(1-(h*s)))/(1-s*freq_head*(2*h*(1-freq_head)+freq_head)); //change freq for selection

	freq_head=(((1.0-s)*(freq_head*freq_head+F*freq_head*(1.0-freq_head)))+((1.0-h*s)*freq_head*(1.0-freq_head)*(1.0-F)))/(((1.0-freq_head)*(1.0-freq_head)+(1.0-freq_head)*F*freq_head)+((1.0-h*s)*2.0*freq_head*(1.0-freq_head)*(1.0-F))+((1.0-s)*(freq_head*freq_head+F*freq_head*(1.0-freq_head)))); //freq change with inbreeding


	count_use=(*head_ptr).num;
//  fprintf(stderr,"count:\t%d\tfreq:\theadprebinom: %f\t", count_use,freq_head);


  freq_count_head = gsl_ran_binomial(r, freq_head, N);//do binom sampling
  freq_head = (double)freq_count_head/(double)N; //turn back to freq
  (*head_ptr).count= freq_head;

  count_use=(*head_ptr).num;
   //fprintf(stderr,"freq_head: %f\n", freq_head);
//  counter=(*current_ptr).num;  Diego's stuff
	//lag_is_alredy set
	lead_current_ptr=(*head_ptr).next_ptr;
	ArrayIterator = FlagTrajToPrint - 1;
	ArrayCounter = 0;
//	printf("Current Count = %d %d %d\n",count_use, ListOfAllelesToKeep[ArrayIterator], ArrayIterator);
// printf("Counter = %d %d %d\n", ArrayCounter, ArrayIterator , ListOfAllelesToKeep[ArrayCounter] );

if (ArrayCounter <= ArrayIterator){

MaxArrayNumber = ArrayIterator;
for (Iterator = ArrayIterator; Iterator >= 0 ; Iterator--){
if (ListOfAllelesToKeep[Iterator] <= count_use){
MaxArrayNumber = Iterator;
}
}

//printf("Current Count! = %d %d %d %d %d %d\n",count_use, ListOfAllelesToKeep[ArrayIterator], ArrayIterator, ArrayCounter, MaxArrayNumber , ListOfAllelesToKeep[MaxArrayNumber]);
if (count_use == ListOfAllelesToKeep[MaxArrayNumber]){
if (SampleFlag == 0){
fprintf(EXITTRAJFILE,"%d\t%lf\n", count_use, freq_head); 
}
ArrayCounter = ArrayCounter + 1;
}
}
	
	while(lead_current_ptr != NULL)
	{

	
		//do drift and sel:
		  if (SampleFlag == 1){
		        s = 0.0;
		  }else{
	      s = ((*lead_current_ptr).sel_coef);
			}
	      freq = ((*lead_current_ptr).count);
	      h = ((*lead_current_ptr).h);
	      count_use=(*lead_current_ptr).num;
	
  	//fprintf(stderr,"count:\t%d\tfreq:\tlaterprebinom: %f\t", count_use,freq);


		freq=(((1.0-s)*(freq*freq+F*freq*(1.0-freq)))+((1.0-h*s)*freq*(1.0-freq)*(1.0-F)))/(((1.0-freq)*(1.0-freq)+(1.0-freq)*F*freq)+((1.0-h*s)*2.0*freq*(1.0-freq)*(1.0-F))+((1.0-s)*(freq*freq+F*freq*(1.0-freq)))); //freq change with inbreeding

	      freq_count = gsl_ran_binomial(r, freq, N);//do binom sampling
	      freq = (double)freq_count/(double)N; //turn back to freq
	      (*lead_current_ptr).count = freq;

   //fprintf(stderr,"freq: %f\n", freq);
		//now have 2 cases to decide what to do with the ptrs to move through the list:
		//case 1: we keep the SNP
		if(freq>0.0 && freq<1.0)
		{
				if (ArrayCounter <= ArrayIterator){
					if (count_use == ListOfAllelesToKeep[MaxArrayNumber+ArrayCounter]){
//						fprintf(EXITTRAJFILE,"%d\t%lf\t%d\t%d\n", count_use, freq , ArrayIterator , ArrayCounter);
						if (SampleFlag == 0){
						fprintf(EXITTRAJFILE,"%d\t%lf\n",  count_use, freq);
						}
						ArrayCounter = ArrayCounter + 1;
				}
			}

			lag_current_ptr=lead_current_ptr; //move up lag ptr
			lead_current_ptr=(*lag_current_ptr).next_ptr; //move up lead ptr
		}
		//case 2: we delete snp
		else
		{
			if (ShortFlag == 1){
			if (freq == 0.0) {
					ReferenceSitesFixed++;
			}
			if (freq == 1.0) {
				DerivedSitesFixed++;
				sumfixeds = sumfixeds + s;
			}
			}



			(*lag_current_ptr).next_ptr=(*lead_current_ptr).next_ptr; //this moves teh "next" address on teh previous ptr to point to the next node
			temp_ptr=lead_current_ptr; //this creates a temp ptr to poitn to the current one
			lead_current_ptr=(*temp_ptr).next_ptr; //this moves us to the next node
			free(temp_ptr); //frees the mtuation that has been lost/fixed
		}//clsoe aroudn else statment to remove monomorphic SNPs
			
	}//close while loop aroudn all teh nodes after the head node (close while (lead_ptr !=NULL))

}//close if loop around whether head ptr is null or not
	if (ShortFlag == 1){
//		ReferenceSitesFixed++;
//		printf("%d\t%d\n",ReferenceSitesFixed,DerivedSitesFixed);
			if(fixed_sitesFlag==1 && ModuloFixedSitesToPrint == 0){
	fprintf(FIXEDSITESFILE,"%d\t%d\t%lf\n",ReferenceSitesFixed,DerivedSitesFixed,sumfixeds);
			}
	}
      return(head_ptr);

}

void full_output(struct linked_list *head_ptr, FILE *FULL_OUT,  int num, int run)

{

	double pop_freq, s;
	int age, j , counter;      

struct linked_list *current_ptr;
      current_ptr = head_ptr;
      while (current_ptr != NULL)
	{

	  pop_freq=((*current_ptr).count);
	  s=((*current_ptr).sel_coef);
	age=((*current_ptr).age);
	j=(*current_ptr).num;
	counter=(*current_ptr).num;
	//fprintf(stderr,"fulL_out:\t%d\t%lf\n",j,pop_freq);

	if(pop_freq<1.0 && pop_freq>0.)
	{
       		fprintf(FULL_OUT, "%d\t%d\t%e\t%e\t%d\t%d\n",run,num, pop_freq,s,age,counter); 
	}


	  current_ptr = current_ptr ->next_ptr;
	}

 
}

void short_output(struct linked_list *head_ptr, FILE *S_OUT, FILE *NUM_SNP_OUT, FILE *WEIGHT_S_OUT,  FILE *MAF_OUT, FILE *GEN_LOAD, int num, int run, int n, gsl_rng * r, int num_snpFlag , int s_outFlag , int  average_mafFlag , int  s_weightFlag , int  genloadFlag, int  sfs_outFlag)

{

	int num_snp_count=0;
	double sum_s=0;
	double freq_weight_s=0;
	double c=0;
	double y=0;
	double t=0;
	double total_maf=0;
	int samp_count;
	double samp_freq;
	double genloadsum = 0;
	double pop_freq, s, h;


      struct linked_list *current_ptr;
      current_ptr = head_ptr;
     
 
	//Here loop through all mutations, tabulate the appropriate summary stats
	while (current_ptr != NULL)
	{

	  	pop_freq=((*current_ptr).count);
		samp_count=gsl_ran_binomial(r,pop_freq,n);
		samp_freq=(double)samp_count/(double)n;
	if(samp_freq>0 && samp_freq<1.0)
	{  

		s=((*current_ptr).sel_coef);
		h=((*current_ptr).h);
       		num_snp_count++;
		sum_s=sum_s+s;


		//now, do the sum of the weighted selection coefficients using Kahan summation:
		y=s*samp_freq-c;
		t=freq_weight_s+y;
		c = (t - freq_weight_s) - y;
		freq_weight_s=t;	

		genloadsum = genloadsum + 2*h*s*(samp_freq*(1-samp_freq)) + s*(samp_freq*samp_freq);
		total_maf=total_maf+samp_freq;
	}	 


 current_ptr = current_ptr ->next_ptr;
	}
	
	//loop thorugh all snps, only print out one set of numbers for a particular time pooint
	genloadsum = 1 - exp(-genloadsum);
	
//	num_snpFlag = 0, s_outFlag = 0, average_mafFlag = 0, s_weightFlag = 0, genloadFlag = 0, sfs_outFlag = 0, het_outFlag = 0, full_outFlag = 0, fixed_sitesFlag = 0 ; 
	if (s_outFlag==1){
	fprintf(S_OUT, "%lf\t",sum_s);
	}
	if(num_snpFlag==1){
	fprintf(NUM_SNP_OUT, "%d\t",num_snp_count);
	}
	if(s_weightFlag==1){
	fprintf(WEIGHT_S_OUT, "%lf\t",freq_weight_s);
	}
	if(average_mafFlag==1){
	fprintf(MAF_OUT, "%lf\t",total_maf);
	}
	if (genloadFlag==1) {
	fprintf(GEN_LOAD, "%lf\t",genloadsum);
	}
	
}


void dog_output(struct linked_list *head_ptr, FILE *DOG_OUT,  int num, int run, double F, gsl_rng * r)

{

	double pop_freq; 

	double geno_prob[3];
	double prob_1=0.0;
	double prob_2=0.0;
	int geno_1[3];
	int geno_2[3];
	int dog_1=0; //single alleel from 1 dog
	int dog_2=0; //single alleel from other dog

	int count_het_1=0;
	int count_het_2=0;
	int count_het_both=0;
	int count_hom_anc_1=0;
	int count_hom_der_1=0;
	int count_hom_anc_2=0;
	int count_hom_der_2=0;
struct linked_list *current_ptr;
      current_ptr = head_ptr;
	int count=0;     
 while (current_ptr != NULL)
	{

	  pop_freq=((*current_ptr).count);
		if(pop_freq<1.0 && pop_freq>0.)
		{

	//now compute dog genotype frequencies with inbreeding:
	geno_prob[2]=pop_freq*pop_freq+pop_freq*F*(1.0-pop_freq);
	geno_prob[1]=2*pop_freq*(1.0-pop_freq)*(1.0-F);
	geno_prob[0]=1.0-geno_prob[1]-geno_prob[2];

	gsl_ran_multinomial(r, 3,1,geno_prob,geno_1);
	gsl_ran_multinomial(r, 3,1,geno_prob,geno_2);


	//fprintf(stderr,"count:%d\tdog_1:\t%d\t%d\t%d\n",count,geno_1[0],geno_1[1],geno_1[2]);
	//fprintf(stderr,"count:%d\tdog_2:\t%d\t%d\t%d\n",count,geno_2[0],geno_2[1],geno_2[2]);


	if(geno_1[1]==1)
	{
		count_het_1++;
	}
	else if(geno_1[0]==1)
	{
		count_hom_anc_1++;
	}
	else if(geno_1[2]==1)
	{

		count_hom_der_1++;
	}
	if(geno_2[1]==1)
	{
		count_het_2++;
	}
	else if(geno_2[0]==1)
	{
		count_hom_anc_2++;
	}
	else if(geno_2[2]==1)
	{

		count_hom_der_2++;
	}


	prob_1=(double)geno_1[1]/2.0+(double)geno_1[2]; //gets allele freq in dog 1;
	prob_2=(double)geno_2[1]/2.0+(double)geno_2[2]; //gets allele freq in dog 2;

	//fprintf(stderr,"count:%d\tdog_probs:\t%lf\t%lf\n",count,prob_1,prob_2);

	//now draw 1 allele from dog 1:
	dog_1=gsl_ran_binomial(r,prob_1,1);
	dog_2=gsl_ran_binomial(r,prob_2,1);

	if(dog_1 != dog_2)
	{
		count_het_both++;
	}
	}
	//fprintf(stderr,"count:%d\tdog_diff:\t%d\t%d\n",count,dog_1,dog_2);
	count++;
	  current_ptr = current_ptr ->next_ptr;
	}
	
	fprintf(DOG_OUT, "%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\t%d\n",run, num, count_hom_anc_1,count_het_1,count_hom_der_1,count_hom_anc_2,count_het_2,count_hom_der_2,count_het_both);
 
}


void sfs_output(struct linked_list *head_ptr, FILE *SFS_OUT, int num, int run, int n, gsl_rng * r)

{

	int num_snp_count=0;
	double sum_s=0;
	double freq_weight_s=0;
	double c=0;
	double y=0;
	double t=0;
	double total_maf=0;
	int samp_count;
	double samp_freq;
	int sfs[n];
	int i;
	int i_use;


	double pop_freq, s;




	for (i=0; i<n; i++)
	{
		sfs[i]=0;
	}


      struct linked_list *current_ptr;
      current_ptr = head_ptr;
     
 
	//Here loop through all mutations, tabulate the appropriate summary stats
	while (current_ptr != NULL)
	{

	  	pop_freq=((*current_ptr).count);
		samp_count=gsl_ran_binomial(r,pop_freq,n);
		samp_freq=(double)samp_count/(double)n;



		if(samp_freq>0 && samp_freq<1.0)
		{  
	
			i_use=samp_count-1;
			sfs[i_use]++;
		}

	


 current_ptr = current_ptr ->next_ptr;
	}
	
	//loop thorugh all snps, only print out one set of numbers for a particular time pooint


	for (i=0; i<n; i++)
	{
		fprintf(SFS_OUT,"%d\t",sfs[i]);
	}

	fprintf(SFS_OUT, "\n");

}

struct linked_list *relax_selection(struct linked_list *head_ptr, double NewSelCoef, double SelThreshold , int TypeRelaxedSelection)
{

double CurSelThreshold;
CurSelThreshold = SelThreshold;
if (head_ptr != NULL)
	{
	struct linked_list *current_ptr;
	current_ptr = head_ptr;
	 while (current_ptr != NULL)
        {
	if ((((*current_ptr).sel_coef)/2) <= CurSelThreshold  && TypeRelaxedSelection == 0){
	(*current_ptr).sel_coef = NewSelCoef*2;
	}else if ((((*current_ptr).sel_coef)/2) <= CurSelThreshold  && TypeRelaxedSelection == 1){
	(*current_ptr).sel_coef = (*current_ptr).sel_coef*NewSelCoef;
	}
	 current_ptr = current_ptr ->next_ptr;
	}
	}

return(head_ptr);
}
