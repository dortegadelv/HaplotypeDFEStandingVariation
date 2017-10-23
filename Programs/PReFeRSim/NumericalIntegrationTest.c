#include <stdio.h>
#include <math.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include <gsl/gsl_integration.h>

double GammaInIntegrableFunction = 5;
int jInIntegrableFunction = 4;
int BurnInPopSizeInIntegrableFunction = 10000;
double PointSelInIntegrableFunction = 0.0002; // selection
// double PointSelInIntegrableFunction = 0.0; // Neutral
double a = 3.0;
double b = 2.0;
double c = 1.0;
int SampleSizeInIntegrableFunction = 10000;
double ThetaInIntegrableFunction = 8.0;
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

int
main (void)
{
	gsl_integration_workspace * w = gsl_integration_workspace_alloc (1000);
	
	double result, error;
	double expected = -4.0;
	double alpha = 1.0;
	
	struct my_f_params { double a; double b; double c; };
	
	gsl_function IntegrableFunction;
	struct my_f_params params = { 3.0, 2.0, 1.0 };

	IntegrableFunction.function = &f_of_q_lambda;
//	F.params = &alpha;
	
	for (jInIntegrableFunction = 1; jInIntegrableFunction<= 999; jInIntegrableFunction++){
	gsl_integration_qags (&IntegrableFunction, 0, 1, 0, 1e-9, 1000,
						  w, &result, &error); 
	
	printf ("%.18f\n", result);
	}
	printf ("exact result    = % .18f\n", expected);
	printf ("estimated error = % .18f\n", error);
	printf ("actual error    = % .18f\n", result - expected);
	printf ("intervals       = %zu\n", w->size);
	
	gsl_integration_workspace_free (w);
	
	return 0;
}





/* #include <math.h>
#define EPS 1.0e-6
#define JMAX 20
#define JMAXP (JMAX+1)
#define K 5
#define PI02 1.5707963
#include "nr.h" 
 Here EPS is the fractional accuracy desired, as determined by the extrapolation error estimate;
 JMAX limits the total number of steps; K is the number of points used in the extrapolation.

float func(float x)
{
	return x*x*(x*x-2.0)*sin(x);
}

float fint(float x)
{
	return 4.0*x*(x*x-7.0)*sin(x)-(pow(x,4.0)-14.0*x*x+28.0)*cos(x);
}

int main(void)
{
	float a = 0.0, b = 1.5707963,s;	
	printf("Integral of func computed with QROMB\n\n");
	printf("Actual value of integral is %12.6f\n",fint(b)-fint(a));
	s = qromb(func,a,b);
	printf("Results from routine QROMB is %11.6f\n",s);
	return 0;
}

 Returns the integral of the function func from a to b. Integration is performed by Romberg’s
 method of order 2K, where, e.g., K=2 is Simpson’s rule.  
 
float qromb(float (*func)(float), float a, float b)
{
	void polint(float xa[], float ya[], int n, float x, float *y, float *dy);
	float trapzd(float (*func)(float), float a, float b, int n);
	void nrerror(char error_text[]);
	float ss,dss;
	float s[JMAXP],h[JMAXP+1]; // These store the successive trapezoidal approxiint
	j; ## mations and their relative stepsizes.
	h[1]=1.0;
	for (j=1;j<=JMAX;j++) {
		s[j]=trapzd(func,a,b,j);
		if (j >= K) {
			polint(&h[j-K],&s[j-K],K,0.0,&ss,&dss);
			if (fabs(dss) <= EPS*fabs(ss)) return ss;
		}
		h[j+1]=0.25*h[j];
		This is a key step: The factor is 0.25 even though the stepsize is decreased by only
		0.5. This makes the extrapolation a polynomial in h2 as allowed by equation (4.2.1),
		not just a polynomial in h. 
	}
	nrerror("Too many steps in routine qromb");
	return 0.0; Never get here.
}

*/