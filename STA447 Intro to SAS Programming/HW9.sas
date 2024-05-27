/* 25A */
DATA VITE; 
  set '/home/u62223361/Intro to SAS/HW9/vite.sas7bdat'; 
RUN; 

PROC CONTENTS DATA = VITE;
RUN;

PROC PRINT DATA = VITE;
RUN;

PROC TTEST H0= 140 DATA = VITE ALPHA=0.05 SIDES= U;
	CLASS Strata;
	VAR SBP;
/* U specifies upper one-sided tests (in which the alternative hypothesis 
indicates a parameter value greater than the null value) and 
upper one-sided confidence intervals between the lower confidence limit and infinity. */


/* 25B */

/* The current data structure would not allow for testing for difference
between true mean plaque before treatment and at the second visit because 
they are different variables and thus one cannot stratify via T-test. */

/* 25C */
DATA VITE_0 (RENAME = (
	Visit = Visit_0 
	Plaque = Plaque_0
	));
	SET VITE (KEEP = Plaque Visit Treatment ID);
	IF VISIT = 0;
RUN;

DATA VITE_2 (RENAME = (
	Visit = Visit_2
	Plaque = Plaque_2
	));
	SET VITE (KEEP = Plaque Visit Treatment ID);
	IF VISIT = 2;
RUN;

DATA VITE_VISIT_TEST;
	MERGE VITE_0 VITE_2;
	BY ID;
RUN;


PROC SORT DATA = VITE_VISIT_TEST;
	BY Treatment;
RUN;

PROC TTEST H0= 0 DATA = VITE_VISIT_TEST ALPHA=0.05 SIDES= 2;
	BY Treatment;
	PAIRED Plaque_0 * Plaque_2;
RUN;
	
	
/* 25D */
PROC SORT DATA = VITE_VISIT_TEST;
	BY Treatment;
RUN;
PROC TTEST H0= 0 DATA = VITE_VISIT_TEST ALPHA=0.05 SIDES= 2;
	PAIRED Plaque_0 * Plaque_2;
RUN;

/* 25E */

PROC SORT DATA = VITE_VISIT_TEST;
	BY Treatment;
RUN;

PROC TTEST PLOTS(ONLY) = (ALL) H0= 0 DATA = VITE_VISIT_TEST ALPHA=0.05 SIDES= 2;
	BY Treatment;
	PAIRED Plaque_0 * Plaque_2;
RUN;

PROC SORT DATA = VITE_VISIT_TEST;
	BY Treatment;
RUN;
PROC TTEST PLOTS(ONLY) = (ALL) H0= 0 DATA = VITE_VISIT_TEST ALPHA=0.05 SIDES= 2;
	PAIRED Plaque_0 * Plaque_2;
RUN;

PROC UNIVARIATE DATA = VITE_VISIT_TEST NORMALTEST NORMAL;
	VAR Plaque_0 Plaque_2 Treatment; 
	CDFPLOT Treatment / NORMAL;
	HISTOGRAM Treatment / NORMAL;
	PPPLOT Treatment / NORMAL;
	PROBPLOT Treatment / NORMAL;
	QQPLOT Treatment / NORMAL;
	
	CDFPLOT Plaque_0 / NORMAL;
	HISTOGRAM Plaque_0 / NORMAL;
	PPPLOT Plaque_0 / NORMAL;
	PROBPLOT Plaque_0 / NORMAL;
	QQPLOT Plaque_0 / NORMAL;
	
	CDFPLOT Plaque_2 / NORMAL;
	HISTOGRAM Plaque_2 / NORMAL;
	PPPLOT Plaque_2 / NORMAL;
	PROBPLOT Plaque_2 / NORMAL;
	QQPLOT Plaque_2 / NORMAL;
RUN;

/* 25F */
/* Part c): The results of the T-test show that the p-value is 
0.0471 < 0.05, which means that we reject 
the null hypothesis (difference of plaque_2 - plaque_0 = 0)
in favor of the alternative hypothesis that 
the plaque before and after 2nd visit for both the 
treatment and placebo group is significantly different.*/
/* Part d): The results of the T-test display that the p-value is 
<0.0001 which is less than 0.05. 
This means that we strongly reject the null hypothesis that 
there is no difference between the plaque before vs after 2nd visit.
Instead, we favor the alternative hypothesis that the plaque
before and after the 2nd visit across the treatment groups is 
significantly different. */
	
/* 28A */
DATA PATENTS; 
  set '/home/u62223361/Intro to SAS/HW9/patents.sas7bdat'; 
RUN; 

PROC CONTENTS DATA = PATENTS;
RUN;

DATA PATENTS_100;
	SET PATENTS;
	IF Patents => 100;
RUN;

PROC REG DATA = PATENTS_100 ALPHA = 0.05 
	CORR EDF ALL SIMPLE RSQUARE PLOTS(ONLY)=(FITPLOT RESIDUALS DIAGNOSTICS COOKSD OBSERVEDBYPREDICTED QQPLOT RESIDUALBYPREDICTED RESIDUALHISTOGRAM RFPLOT RSTUDENTBYLEVERAGE RSTUDENTBYPREDICTED);
	MODEL Patents = Education;
RUN;

/* 28B */
/* For 1% increase in %of people with education level of Bachelor's or more,
the number of patents is expected to increase by 19.21185.
The regression coefficient of Education is statistically significant (p-value = 0.0094),
however, the correlation between Education and Patents is only 0.1926, which is low. 

The test of first and second moment specification (White test) has a Chi-square p-value of 
0.4321, which is > 0.05, indicating that we fail to reject the null hypothesis of homoscedasticity 
(we do not have enough evidence to conclude that the error terms' variance are not constant). 
In other words, the test suggests constant variance. 

However, I still have concerns over the constant variance assumption because 
1) Both Residual vs Predicted & Observed vs Predicted plot does not showcase uniformly spreaded residual points
2) Residual for Patents also does not display uniformly spreaded residual points 


The adjusted R-square is 0.0317, which means the model does not really fully explain the change in patents. 
There are also some outlier and high leverage points. 
The QQ-plot shows that the errors are not exactly normally distributed, which may be of concern.
Based on the ANOVA table, the p-value for the F-test is 0.0094 which means that 
we can reject the null hypothesis (no statistically significant relationship between independent variable and dependent variable) 
in favor of the alternative hypothesis (there is statistically significant relationship between Patents and Education). 

Since there is only 1 variable, it makes sense that it only has VIF = 1 (no multicollinearity).
  */


/* 28C */
DATA PATENTS_LOG10;
	SET PATENTS_100;
	IF Patents => 100;
	Patents = LOG10(Patents);
	Education = LOG10(Education);
RUN;

PROC REG DATA = PATENTS_LOG10 ALPHA = 0.05 
	CORR EDF ALL SIMPLE RSQUARE PLOTS(ONLY)=(FITPLOT RESIDUALS DIAGNOSTICS COOKSD OBSERVEDBYPREDICTED QQPLOT RESIDUALBYPREDICTED RESIDUALHISTOGRAM RFPLOT RSTUDENTBYLEVERAGE RSTUDENTBYPREDICTED);
	MODEL Patents = Education;
RUN;

/* 28D */
/* For 1% increase in %of people with education level of Bachelor's or more,
the number of patents is expected to increase by 1.16653.
The regression coefficient of Education is statistically significant <.0001 (but the intercept is not p-val: 0.0611) ,
however, the correlation between Education and Patents is only 0.3507, which is still low but higher than before. 

The concerns over the constant variance assumption seem to have exacerbated. 
1) The test of first and second moment specification (White test) has a Chi-square p-value of 
0.0140 < 0.05, indicating that we reject the null hypothesis of homoscedasticity.
(we have enough evidence to conclude that the variance is not constant).
2) Residuals vs Predicted seem to have more uniformly spreaded points, but Observed vs Predicted shows a pattern. 

The adjusted R-square is 0.1181, which means the model has improved in its ability to explain change in patents. 

There are still some outlier and high leverage points. 
The QQ-plot shows that the errors are not exactly normally distributed, but by my eye it seems to have improved a bit.
Based on the ANOVA table, the p-value for the F-test is <.0001 which means that 
we have even stronger evidence to reject the null hypothesis 
(no statistically significant relationship between independent variable and dependent variable) 
in favor of the alternative hypothesis (there is statistically significant relationship between Patents and Education). 

Since there is only 1 variable, it makes sense that it only has VIF = 1 (no multicollinearity).
  */


/* 28E */
PROC REG DATA = PATENTS_LOG10 ALPHA = 0.05 
	CORR EDF ALL SIMPLE RSQUARE PLOTS(ONLY)=(FITPLOT RESIDUALS DIAGNOSTICS COOKSD OBSERVEDBYPREDICTED QQPLOT RESIDUALBYPREDICTED RESIDUALHISTOGRAM RFPLOT RSTUDENTBYLEVERAGE RSTUDENTBYPREDICTED);
	MODEL Patents = Education;
	OUTPUT OUT= PATENT_REG_10_RESID
		RESIDUAL = patent_resid;
RUN;

PROC UNIVARIATE NORMAL NORMALTEST DATA = PATENT_REG_10_RESID ALPHA= 0.05;
	VAR patent_resid; 
	CDFPLOT patent_resid / NORMAL;
	HISTOGRAM patent_resid / NORMAL;
	PPPLOT patent_resid / NORMAL;
	PROBPLOT patent_resid / NORMAL;
	QQPLOT patent_resid / NORMAL;
RUN;

/* 28F */
/*
Based on the results, all normality tests (Anderson-Darling, Cramer-von Mises, Kolmogorov-Smirnov)
yielded p-values <0.05, which means that we reject the null hypothesis that the residuals are normally distributed.
*/


/* 28G */
PROC OPTIONS OPTION=MACRO;
RUN;
PROC OPTIONS OPTION = SYMBOLGEN;
RUN;


%MACRO PATENT_REG (DEP_VAR=, INDEP_VAR=, DATASET_NAME=);

	%LET RESID_DATASET = &DEP_VAR._resid;

	PROC REG DATA = &DATASET_NAME ALPHA = 0.05 
		CORR EDF ALL SIMPLE RSQUARE 
		PLOTS(ONLY)=(FITPLOT RESIDUALS DIAGNOSTICS COOKSD OBSERVEDBYPREDICTED QQPLOT RESIDUALBYPREDICTED RESIDUALHISTOGRAM RFPLOT RSTUDENTBYLEVERAGE RSTUDENTBYPREDICTED);
		MODEL &DEP_VAR = &INDEP_VAR;
		OUTPUT OUT= &RESID_DATASET
			RESIDUAL = resid; 
		TITLE "REGRESSION ANALYSES FOR &DEP_VAR AND &INDEP_VAR AS REGRESSOR (&DATASET_NAME.) " ;
	RUN;
	
	PROC UNIVARIATE NORMAL NORMALTEST DATA = &RESID_DATASET ALPHA= 0.05;
		VAR resid; 
		CDFPLOT resid / NORMAL;
		HISTOGRAM resid / NORMAL;
		PPPLOT resid / NORMAL;
		PROBPLOT resid / NORMAL;
		QQPLOT resid / NORMAL;
		TITLE "RESIDUAL NORMALITY ANALYSES FOR &DEP_VAR (&DATASET_NAME.) " ;
	RUN;

%MEND PATENT_REG;

%PATENT_REG(DEP_VAR=Patents, INDEP_VAR=Caucasian, DATASET_NAME=PATENTS)
%PATENT_REG(DEP_VAR=Patents, INDEP_VAR=Income, DATASET_NAME=PATENTS)



/* 28H */
ODS PDF FILE = "/home/u62223361/Intro to SAS/HW9/28_ANALYSIS.PDF";
%PATENT_REG(DEP_VAR=Patents, INDEP_VAR=Education, DATASET_NAME=PATENTS_100)
%PATENT_REG(DEP_VAR=Patents, INDEP_VAR=Education, DATASET_NAME=PATENTS_LOG10)

ODS PDF CLOSE;

