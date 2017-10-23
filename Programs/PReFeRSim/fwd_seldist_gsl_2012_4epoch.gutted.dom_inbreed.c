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

//include GSL library stuff:
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>

/*define global variables:*/
int fix = 0;
int total_mut = 0;
int count_mut=0;

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
struct linked_list *drift_sel(struct linked_list *head_ptr, int N, gsl_rng * r, double F, int FlagTrajToPrint, int *ListOfAllelesToKeep, FILE *EXITTRAJFILE, FILE *FIXEDSITESFILE, int ShortFlag , int SampleFlag);
void short_output(struct linked_list *head_ptr, FILE *S_OUT, FILE *NUM_SNP_OUT, FILE *WEIGHT_S_OUT,  FILE *MAF_OUT, FILE *GEN_LOAD, int num, int run, int n, gsl_rng * r);
void full_output(struct linked_list *head_ptr, FILE *FULL_OUT,  int num, int run);
void dog_output(struct linked_list *head_ptr, FILE *DOG_OUT,  int num, int run, double F, gsl_rng * r);
void sfs_output(struct linked_list *head_ptr, FILE *SFS_OUT, int num, int run, int n, gsl_rng * r);
struct linked_list *relax_selection(struct linked_list *head_ptr, double NewSelCoef, double SelThreshold , int TypeRelaxedSelection);

int main(int argc, char *argv[])
{
  int* N, TempN;
  int* gen, Tempgen;
  long seed;
  int g;
  double mut_rate;
  int num;
  int poly = 0;
  int run;
 int age;
char *type_sel, *type_f;
 char *path; //path where to put stuff
char *AllelesToKeep; //name of the file from where we will read the alleles whose allele frequency trajectories you want to store
char *NameExitTrajFile; //name of the file where I will write the trajectories
int AllelesToKeepFlag = 0; // Flag in case you read alleles to keep allele frequency trajectories
int N_F; //N adjusted for inbreeding
int N_F_1; //N adjusted for inbreeding, next epoch
double F; //inbreeding coefficient
double h; //dominance coefficient
int Short=1; //int read in from the cmd line to decide whether or not to do the short output. Iff==1, then get the short output. Else, skip it. Short output are the time-course results of genetic variation.
double sel_mult=1.0; //this is a mutliplier for the strength of selection to allow for rescaling poupaltion sizes.
int k; //counter
int n=0; //sample size for SFS and short output
double PointSel = 0; // Here I will store the value of selection in case I have a specific value for it.
	//int n=200; //this is the sample size to be drawn in the short otuput function //now read in n from cmd line 
FILE *InputAlleles, *EXITTRAJFILE, *NeTrajFile, *FValuesFile,  *SelParFile, *FIXEDSITESFILE;
int *ListOfAllelesToKeep;
int AlleleRead, NumberOfAlleles = 0, ch, NumberOfSelParameters = 0;
int FlagTrajToPrint = 0, NumberOfEpochs = 0, StringPart, NumberOfEpochs_F = 0, FlagRelaxationSelection = 0, TypeOfRelaxedSelection = 0, EpochOfRelaxation, PrintingInterval = 1;
double NewSelectionCoefficient = 0.0, SelectionThreshold;
char *DemographicTrajectory, *TrajLine, *FValuesFileName, *SelParFileName;
ssize_t read;
size_t len = 0;
char *pch, *LinePart;
int SampleSize, DerivedAllelesInSample, SampleFlag = 0 , F_fixedflag = 1;
double F_Temp;
double* F_Epochs;
double *VectorSelParamOne, *VectorSelParamTwo, *VectorSelParamThree;
double DistParamOne = 0, DistParamTwo = 0, DistParamThree = 0;
TrajLine = malloc(100*sizeof(char));
/*N = malloc(4*sizeof(int));
gen = malloc(4*sizeof(int));
	for(k=0; k<4; k++)
	{
		N[k]=0;	
		gen[k]=0;
	}
*/ 
    while ((argc > 1) && (argv[1] [0] == '-'))
    {
      //arg[1] [2] is the first option character, N in this case
      printf("Argument = %s %s\n",&argv[1][1] , &argv[1][2]);
	switch (argv [1] [1])
	{  
/*	case 'A':
	  N[0] = atoi(&argv[1] [2]);
	  break;
	case 'a':
	  gen[0] = atoi(&argv[1] [2]);
	  break;
	case 'B':
	  N[1] = atoi(&argv[1] [2]);
	  break;
	case 'b':
	   gen[1] = atoi(&argv[1] [2]);
	   break;
	case 'C':
	  N[2] = atoi(&argv[1] [2]);
	  break;
	case 'c':
	   gen[2] = atoi(&argv[1] [2]);
	   break;
	case 'D':
	  N[3] = atoi(&argv[1] [2]);
	  break;
	case 'd':
	   gen[3] = atoi(&argv[1] [2]);
	   break; */
	case 'T':
	AllelesToKeep = &argv[1][2];
	printf("FileToTakeAllelesFrom = %s\n",AllelesToKeep);
	InputAlleles = fopen(AllelesToKeep,"r");
	while (fscanf(InputAlleles, "%d",&AlleleRead) != EOF){
//		printf("Allele = %d\n",AlleleRead);
		NumberOfAlleles++;
	}
	fclose(InputAlleles);
	printf("NumberOfAlleles = %d\n", NumberOfAlleles);
	ListOfAllelesToKeep = malloc(NumberOfAlleles*sizeof(int));
        InputAlleles = fopen(AllelesToKeep,"r");
	NumberOfAlleles = 0;
	while (fscanf(InputAlleles, "%d",&AlleleRead) != EOF){
//		printf("Allele = %d\n",AlleleRead);
		ListOfAllelesToKeep[NumberOfAlleles] = AlleleRead;
//		printf("Array %d %d\n", NumberOfAlleles , ListOfAllelesToKeep[NumberOfAlleles]);
		NumberOfAlleles++;
        }
        fclose(InputAlleles);
        ++argv;
        --argc;
        NameExitTrajFile = &argv[1][0];
        printf("ExitFile = %s\n", NameExitTrajFile );
	EXITTRAJFILE = fopen(NameExitTrajFile,"w");
//	fprintf(EXITTRAJFILE, "Here I come!\n");
//	fclose(EXITTRAJFILE);
	FlagTrajToPrint = NumberOfAlleles;
//	return 0;
	break;
	case 'R':
	DemographicTrajectory = &argv[1][2];
	printf("DemographicTrajectoryFile = %s\n",DemographicTrajectory);
	NumberOfEpochs = 0;
	NeTrajFile = fopen (DemographicTrajectory,"r");
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
	while ((read = getline(&TrajLine, &len, NeTrajFile)) != -1) {
//		printf("Retrieve line of length %zu :\n", read);
//		printf("%s", TrajLine);
		pch = strtok (TrajLine," ");
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
//			printf ("CurrentLine = %s %i\n",pch, StringPart);
			
//			pch = strtok (NULL, " ");
			if (StringPart == 0){
				N[NumberOfEpochs] = atoi(pch);
//				printf("String1 = %i %i\n",N[NumberOfEpochs], NumberOfEpochs);
			}else if (StringPart == 1){
//				gen[NumberOfEpochs] = atoi (pch);
				char *SubString = pch;
				SubString[strlen(SubString) -1] = '\0';
				gen[NumberOfEpochs] = atoi (SubString);
//				printf("String2 = %i %i\n",gen[NumberOfEpochs], NumberOfEpochs);
			}
			pch = strtok (NULL, " ");
			StringPart++;
		}
	NumberOfEpochs++;
	}
	fclose(NeTrajFile);
//	printf("Number of epochs = %i\n",NumberOfEpochs);
//	return 0;
	break;
	case 'm':
	  mut_rate = atof(&argv[1] [2]);
	  break; 

	  case 's':
	  seed = atol(&argv[1] [2]);
	  break;
	  
	case 't':
	  num = atoi(&argv[1] [2]);
	  break;
	  
	case 'z':
	  run = atoi(&argv[1] [2]);
	  break;
	case 'g':
	  type_sel = &argv[1][2] ;
	  if(strcmp(type_sel,"point")==0)
        {
	++argv;
	--argc;
	PointSel = atof(&argv[1][0]);
	printf("Sel = %s %lf\n", &argv[1][0] , PointSel );
//	return 0;
        //sel=0.005;
        //        //sel=0.001331913;
        //                sel=0.00125;
                                }
	if( ( strcmp(type_sel,"gamma")==0) || ( strcmp(type_sel,"beta")==0) || ( strcmp(type_sel,"lognormal")==0) ){
        ++argv;
        --argc;
        DistParamOne = atof(&argv[1][0]);
        printf("Sel = %s %lf\n", &argv[1][0] , DistParamOne );
        ++argv;
        --argc;
        DistParamTwo = atof(&argv[1][0]);
        printf("Sel = %s %lf\n", &argv[1][0] , DistParamTwo );
        ++argv;
        --argc;
        DistParamThree = atof(&argv[1][0]);
        printf("Sel = %s %lf\n", &argv[1][0] , DistParamThree );	
	}
	if ( ( strcmp(type_sel,"pointprob")==0 ) || ( strcmp(type_sel,"unifbounds")==0  ) ){
        ++argv;
        --argc;
	SelParFileName = &argv[1][0];
	SelParFile = fopen (SelParFileName,"r");
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
	while ((read = getline(&TrajLine, &len, SelParFile)) != -1) {
		pch = strtok (TrajLine," ");
		StringPart = 0;
		while (pch != NULL){
			if (StringPart == 0){
				VectorSelParamOne[NumberOfSelParameters] = atof(pch);
				printf("Parameter One = %f\n",VectorSelParamOne[NumberOfSelParameters]);
			}
			else if (StringPart == 1){
				if (strcmp(type_sel,"pointprob")==0){
					char *SubString2 = pch;
					SubString2[strlen(SubString2) -1] = '\0';
					VectorSelParamTwo[NumberOfSelParameters] = atof (SubString2);
					printf("Parameter Two = %f\n",VectorSelParamTwo[NumberOfSelParameters]);
				}else{
					VectorSelParamTwo[NumberOfSelParameters] = atof(pch);
					printf("Parameter Two = %f\n",VectorSelParamTwo[NumberOfSelParameters]);
				}
			}
			else if (StringPart == 2){
				char *SubString3 = pch;
				SubString3[strlen(SubString3) -1] = '\0';
				VectorSelParamThree[NumberOfSelParameters] = atof (SubString3);
				printf("Parameter Three = %f\n",VectorSelParamThree[NumberOfSelParameters]);
			}
			pch = strtok (NULL, " ");
			StringPart++;
		}
	NumberOfSelParameters++;
	}
        ++argv;
        --argc;
	DistParamThree = atof(&argv[1][0]);
	}
	  break;
	case 'r':
        ++argv;
        --argc;
	FlagRelaxationSelection = 1;
	EpochOfRelaxation = atoi(&argv[1] [0]);
        ++argv;
        --argc;
	NewSelectionCoefficient = atof(&argv[1][0]);
        ++argv;
        --argc;
	SelectionThreshold = atof(&argv[1][0]);
//	printf("Epoch %i new selection %lf selThreshold %lf\n", EpochOfRelaxation, NewSelectionCoefficient, SelectionThreshold);
        ++argv;
        --argc;
	TypeOfRelaxedSelection = atoi(&argv[1] [0]);
	printf("Epoch %i new selection %lf selThreshold %lf TypeRelSel = %i\n", EpochOfRelaxation, NewSelectionCoefficient, SelectionThreshold, TypeOfRelaxedSelection); 
	break;
	case 'N':
	  SampleSize = atoi(&argv[1] [2]); 
	  SampleFlag = 1;
	  printf("Sample Size = %i , Sample Flag = %i\n", SampleSize , SampleFlag);
//	  return 0;
	  break;
        case 'f':
          sel_mult = atof(&argv[1][2]) ;
	  break;
	case 'F':
		  type_f = &argv[1][2];
			if(strcmp(type_f,"fixed")==0)
			{
				++argv;
				--argc;
			F = atof(&argv[1][0]) ;
			F_fixedflag = 1;
			}else if (strcmp(type_f,"changed") == 0) {
				++argv;
				--argc;
				F_fixedflag = 0;
				FValuesFileName = &argv[1][0];
				FValuesFile = fopen (FValuesFileName,"r");
				NumberOfEpochs_F = 0;
				printf("All well here...\n");
				do {
					ch = fgetc(FValuesFile);
					if (ch == '\n')
						NumberOfEpochs_F++;
				} while (ch != EOF);
				if (ch != '\n' && NumberOfEpochs_F != 0)
					NumberOfEpochs_F++;
				fclose(FValuesFile);
				NumberOfEpochs_F= NumberOfEpochs_F - 1;
				F_Epochs = malloc(NumberOfEpochs_F*sizeof(double));
				printf("Number of epochs = %d\n",NumberOfEpochs_F);
				NumberOfEpochs_F = 0;
				FValuesFile = fopen (FValuesFileName,"r");
				while (fscanf(FValuesFile, "%lf",&F_Temp) != EOF){
					//		printf("Allele = %d\n",AlleleRead);
					F_Epochs[NumberOfEpochs_F] = F_Temp;
							printf("Array %lf %d\n", F_Temp, NumberOfEpochs_F);
							NumberOfEpochs_F++;
				}
				fclose(FValuesFile);
				printf("Make it here? %d\n", NumberOfEpochs_F);
				F = 0.0;
			}
	  break;
	case 'h':
          h = atof(&argv[1][2]) ;
	  break;
	case 'n':
          n  = atoi(&argv[1][2]) ;
	  break;
	case 'S':
          Short = atoi(&argv[1][2]) ;
			if (Short == 1){
			++argv;
			--argc;
		  PrintingInterval = atoi(&argv[1][0]) ;
			}

	}
//	printf("Argument = %s %s\n",&argv[1][1] , &argv[1][2]);
      ++argv;
      --argc;
      }

//	return 0;
 	path=argv[1]; 

     fprintf(stderr,"%d\t%d\t%d\t%d\t%d\t%d\t%ld\t%lf\t%d\t%d\t%s\t%d\t%d\t%lf\t%lf\n", N[0], gen[0], N[1], gen[1], N[2], gen[2], seed, mut_rate,num, run, type_sel, N[3], gen[3], F, h);
	fprintf(stderr,"%s\n",path);

  //float N = 1000; /*size for binom dist*/
  float rv; /*binom rv straight from draw*/
  int i, j, TempGenCounter; /*counter*/
  //struct linked_list *kl;

  int e; /*epoch counter*/			
  
  FILE *MAF_OUT;
  FILE *S_OUT;
  FILE *NUM_SNP_OUT;
  FILE *WEIGHT_S_OUT;
  FILE *GEN_LOAD;

printf ("Ne values\n");
if (F_fixedflag == 1){
F_Epochs = malloc(NumberOfEpochs*sizeof(double));
}
for (e = 0; e < NumberOfEpochs; e++){
printf("Ne = %i gen = %i NumberOfEpochs = %i ", N[e], gen[e], NumberOfEpochs);
if (F_fixedflag == 1){
F_Epochs[e] = F;
}
	printf("F = %lf\n",F_Epochs[e]);
}
printf("Here?\n");
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
//first for s:
char file_out[1000];
 sprintf(file_out, "%s/run.%d/s_out.run.%d.num.%d.N.%d.h.%f.F.%f.txt",path,run, run,num,N[0],h,F_Epochs[NumberOfEpochs-1]);
//  FILE *S_OUT;
  S_OUT = fopen(file_out, "w"); /*output file for s, with no scaling*/
  if (S_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to read output file\n");
      exit(8);
      }
  
//now for num snps:
char file_out_num[1000];
 sprintf(file_out_num, "%s/run.%d/num_snp_out.run.%d.num.%d.N.%d.h.%f.F.%f.txt",path,run, run,num,N[0],h,F_Epochs[NumberOfEpochs-1]);
  //FILE *NUM_SNP_OUT;
  NUM_SNP_OUT = fopen(file_out_num, "w"); /*output file for num snps*/
  if (NUM_SNP_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to read output file\n");
      exit(8);
      }
 

//now for freq weighted S:
char file_out_weight[1000];
 sprintf(file_out_weight, "%s/run.%d/s_weight_out.run.%d.num.%d.N.%d.h.%f.F.%f.txt",path,run, run,num,N[0],h,F_Epochs[NumberOfEpochs-1]);
  //FILE *WEIGHT_S_OUT;
  WEIGHT_S_OUT = fopen(file_out_weight, "w"); /*output file for freq weighted s*/
  if (WEIGHT_S_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to read output file\n");
      exit(8);
      }


//now for average maf:
char file_out_maf[1000];
 sprintf(file_out_maf, "%s/run.%d/average_maf_out.run.%d.num.%d.N.%d.h.%f.F.%f.txt",path,run, run,num,N[0],h,F_Epochs[NumberOfEpochs-1]);
  //FILE *MAF_OUT;
  MAF_OUT = fopen(file_out_maf, "w"); /*output file for average maf*/
  if (WEIGHT_S_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to read output file\n");
      exit(8);
      }

//now for number of fixed sites:
	char file_out_fixed[1000];
	sprintf(file_out_fixed, "%s/run.%d/fixed_sites_out.run.%d.num.%d.N.%d.h.%f.F.%f.txt",path,run, run,num,N[0],h,F_Epochs[NumberOfEpochs-1]);
	//FILE *MAF_OUT;
	FIXEDSITESFILE = fopen(file_out_fixed, "w"); /*output file for average maf*/
	if (FIXEDSITESFILE == NULL)
    {
		fprintf(stderr, "Error: unable to read output file\n");
		exit(8);
	}

//now for genetic load
	char file_out_genload[1000];
	sprintf(file_out_genload, "%s/run.%d/gen_load_out.run.%d.num.%d.N.%d.h.%f.F.%f.txt",path,run, run,num,N[0],h,F_Epochs[NumberOfEpochs-1]);
	//FILE *MAF_OUT;
	GEN_LOAD = fopen(file_out_genload, "w"); /*output file for average maf*/
	if (GEN_LOAD == NULL)
    {
		fprintf(stderr, "Error: unable to read output file\n");
		exit(8);
	}
	

} //close if statement around short.


//now actually run evolution!
 //note, here we can look at 4 epochs! 
  for (e=0; e<NumberOfEpochs; e++)
    {
 
	N_F=(double)N[e]/(1.0+F_Epochs[e]); //this adjusts Ne for inbreeding
     printf("epoch = %i mutcounter = %i\n", e ,count_mut);
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

			short_output(first_ptr, S_OUT, NUM_SNP_OUT, WEIGHT_S_OUT,  MAF_OUT, GEN_LOAD,num, run, n, r);
		}
		else if(e>0 && (g % PrintingInterval)==0 && Short==1)
		{
			//means we should do the timed sampling

			short_output(first_ptr, S_OUT, NUM_SNP_OUT, WEIGHT_S_OUT,  MAF_OUT, GEN_LOAD, num, run, n, r);
		}
		
		if (age == 39999){
//			printf("Exit at generation 39999!\n");
		}
//	printf("age = %i %lf\n", age , mut_rate);
//	fprintf(stderr,"Generation:\t%d\n",g);
//	 fprintf(EXITTRAJFILE,"Age = %d\n",age);
	  first_ptr = drift_sel(first_ptr,N_F, r, F_Epochs[e], FlagTrajToPrint, ListOfAllelesToKeep, EXITTRAJFILE, FIXEDSITESFILE, Short,  0);
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

printf("mutcounter = %i %i\n", count_mut, e);

if (SampleFlag == 1){
first_ptr = drift_sel(first_ptr,SampleSize, r, F_Epochs[e-1], FlagTrajToPrint, ListOfAllelesToKeep, EXITTRAJFILE, FIXEDSITESFILE ,Short, SampleFlag);
}

  //open a file with the full output:
char file_out_full[1000];
 sprintf(file_out_full, "%s/run.%d/full_out.run.%d.num.%d.N.%d.h.%f.F.%f.txt",path,run, run,num,N[0],h,F_Epochs[e-1]);
  FILE *FULL_OUT;
  FULL_OUT = fopen(file_out_full, "w"); //output file for sfs
  if (FULL_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to read output file\n");
      exit(8);
      }
 
//now create dog output
char file_out_dog[1000];
 sprintf(file_out_dog, "%s/run.%d/dog_out.run.%d.num.%d.N.%d.h.%f.F.%f.txt",path,run, run,num,N[0],h,F_Epochs[e-1]);
  FILE *DOG_OUT;
  DOG_OUT = fopen(file_out_dog, "w"); //output file for dog stuff
  if (DOG_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to read dog output file\n");
      exit(8);
      }
 
//now create sfs output
char file_out_sfs[1000];
 sprintf(file_out_sfs, "%s/run.%d/sfs_out.run.%d.num.%d.N.%d.h.%f.F.%f.txt",path,run, run,num,N[0],h,F_Epochs[e-1]);
  FILE *SFS_OUT;
  SFS_OUT = fopen(file_out_sfs, "w"); //output file for sfs stuff
  if (SFS_OUT == NULL)
    {
      fprintf(stderr, "Error: unable to read sfs output file\n");
      exit(8);
      }
 
 
	if(Short==1)
	{ 
		short_output(first_ptr, S_OUT, NUM_SNP_OUT, WEIGHT_S_OUT,  MAF_OUT, GEN_LOAD, num, run, n, r);
 
		fprintf(S_OUT, "\n");
		fprintf(NUM_SNP_OUT, "\n");
		fprintf(WEIGHT_S_OUT, "\n");
		fprintf(MAF_OUT, "\n");
		fprintf(GEN_LOAD, "\n");
	}

	 full_output(first_ptr, FULL_OUT,num, run);
	 dog_output(first_ptr, DOG_OUT,num, run, F_Epochs[e-1],r);
	sfs_output(first_ptr, SFS_OUT,  num,  run,  n, r);



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

	if(strcmp(type_sel,"point")==0)
	{ 
	//sel=0.005;
	//sel=0.001331913;
	sel= PointSel;
	}

	else if(strcmp(type_sel,"dist")==0)	
	{

	//Use this for gamma distribution in Boyko 2008:
    	 gamma = gsl_ran_gamma(r,0.184,319.8626*sel_mult); //note, this is scale for a Nanc=1000, using the boyko params
    	  sel=gamma/(2000.0);
 	}else if (strcmp(type_sel,"gamma")==0){
          gamma = gsl_ran_gamma(r,ParamOne,ParamTwo*sel_mult);
           sel=gamma/(2 * ParamThree);
	}else if (strcmp(type_sel,"beta")==0){
         randomvar = gsl_ran_beta(r,ParamOne,ParamTwo*sel_mult); 
           sel=randomvar;
	}else if (strcmp(type_sel,"lognormal")==0){
	 randomvar = gsl_ran_lognormal(r,ParamOne,ParamTwo*sel_mult);
	 sel=randomvar/(2 * ParamThree);
	}else if (strcmp(type_sel,"pointprob")==0 ){
	 randomvar = gsl_ran_flat(r,0,1);
	for (SelIterator = 0; SelIterator < NumberOfSelPars; SelIterator++){
	 if (randomvar <= VecSelParamTwo[SelIterator]){
	break;
	}
	}	
	sel = VecSelParamOne[SelIterator] / ( 2 * ParamThree);
//	printf("Current sel = %f %f %i %f\n", VecSelParamOne[SelIterator], randomvar, SelIterator, VecSelParamTwo[SelIterator]);
	}else if ( strcmp(type_sel,"unifbounds")==0 ){
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

struct linked_list *drift_sel(struct linked_list *head_ptr, int N, gsl_rng * r, double F, int FlagTrajToPrint, int *ListOfAllelesToKeep, FILE *EXITTRAJFILE, FILE *FIXEDSITESFILE, int ShortFlag, int SampleFlag)
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
	fprintf(FIXEDSITESFILE,"%d\t%d\t%lf\n",ReferenceSitesFixed,DerivedSitesFixed,sumfixeds);
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

void short_output(struct linked_list *head_ptr, FILE *S_OUT, FILE *NUM_SNP_OUT, FILE *WEIGHT_S_OUT,  FILE *MAF_OUT, FILE *GEN_LOAD, int num, int run, int n, gsl_rng * r)

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
	
	fprintf(S_OUT, "%lf\t",sum_s);
	fprintf(NUM_SNP_OUT, "%d\t",num_snp_count);
	fprintf(WEIGHT_S_OUT, "%lf\t",freq_weight_s);
	fprintf(MAF_OUT, "%lf\t",total_maf);
	fprintf(GEN_LOAD, "%lf\t",genloadsum);
	
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
