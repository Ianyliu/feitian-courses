/* B.a */
DATA BUS; 
  set '/home/u62223361/Intro to SAS/FinalExam/bus.sas7bdat'; 
RUN; 

PROC CONTENTS DATA = BUS;
RUN;

PROC PRINT DATA = BUS;
RUN;

PROC MEANS DATA = BUS MEAN MEDIAN STDDEV MAXDEC=1;
	VAR Plan1 Plan2 Plan3;
RUN;

/* B.b */
DATA BUS_PLAN1 (KEEP=Plan1 Plan Day RENAME= (Plan1 = Time));
	SET BUS;
	Plan = "Plan1";
RUN;

DATA BUS_PLAN2 (KEEP=Plan2 Plan Day RENAME= (Plan2 = Time));
	SET BUS;
	Plan = "Plan2";
RUN;

DATA BUS_PLAN3 (KEEP=Plan3 Plan Day RENAME= (Plan3 = Time));
	SET BUS;
	Plan = "Plan3";
RUN;

DATA BUS_RESHAPED;
	SET BUS_PLAN1 BUS_PLAN2 BUS_PLAN3;
RUN;

PROC ANOVA DATA = BUS_RESHAPED;
	CLASS Plan;
	MODEL Time = Plan;
	MEANS Plan / BON DUNCAN SCHEFFE SIDAK T TUKEY WALLER WELCH ALPHA=0.05 ;
RUN;

/* B.c */
PROC TTEST DATA = BUS ALPHA=0.05 SIDES= U PLOTS(ONLY) = (ALL);
	PAIRED Plan1 * Plan2;
RUN;

PROC TTEST DATA = BUS ALPHA=0.05 SIDES= U PLOTS(ONLY) = (ALL);
	PAIRED Plan2 * Plan3;
RUN;

PROC TTEST DATA = BUS ALPHA=0.05 SIDES= U PLOTS(ONLY) = (ALL);
	PAIRED Plan1 * Plan3;
RUN;

/* B.d */
/* The pairwise t-tests between each plan show p-values that are close to 1.
This means that we fail to reject the null hypothesis that there is no difference 
between the two means. 
In particular, the boxplots show that plan 2 and plan 3 overlap quite a lot.  
However, if I had to choose a plan, I would choose plan 1. 
Based on the boxplot, it shows that the time is in general faster than other plans. */


/* C.a */
DATA VISITS; 
  set '/home/u62223361/Intro to SAS/FinalExam/visits.sas7bdat'; 
  FORMAT VisitDt DATE.;
RUN; 

DATA TXGROUP; 
  set '/home/u62223361/Intro to SAS/FinalExam/txgroup.sas7bdat'; 
RUN; 

PROC CONTENTS DATA = VISITS;
RUN;
PROC CONTENTS DATA = TXGROUP;
RUN;

PROC PRINT DATA = VISITS;
RUN;
PROC PRINT DATA = TXGROUP;
RUN;

PROC SORT DATA = TXGROUP;
BY ID;
RUN;

PROC SORT DATA = VISITS;
BY ID;
RUN;

DATA VISITS_TXGROUP;
	MERGE VISITS (IN=V) TXGROUP;
	BY ID;
	IF V;
RUN;

PROC CONTENTS DATA = VISITS_TXGROUP;
RUN;

/* C.b */
PROC SORT DATA = TXGROUP OUT = TXGROUP_NEAT NODUPKEY DUPOUT= TXGROUP_EXTRA;
	BY ID TX;
RUN;

DATA VISITS_TXGROUP;
	MERGE VISITS (IN=V) TXGROUP_NEAT;
	BY ID;
	IF V;
RUN;

PROC CONTENTS DATA = VISITS_TXGROUP;
RUN;

/* C.c */
PROC MEANS DATA= VISITS_TXGROUP MEDIAN;
	VAR B_Cholesterol;
	OUTPUT OUT = VISITS_TXGROUP_MEDIAN MEDIAN(B_Cholesterol) = Median_B_Choles;
RUN;

DATA VISITS_TXGROUP_MEDIAN;
	SET VISITS_TXGROUP_MEDIAN;
	TEMP = "TEMP";
RUN;

DATA VISITS_TXGROUP;
	SET VISITS_TXGROUP;
	TEMP = "TEMP";
RUN;

DATA VISITS_TXGROUP (DROP= TEMP _FREQ_ _TYPE_);
	MERGE VISITS_TXGROUP (IN=I) VISITS_TXGROUP_MEDIAN;
	BY TEMP;
	IF I;
	IF B_Cholesterol <= Median_B_Choles THEN B_Chol_Strata = "LESS THAN";
	ELSE B_Chol_Strata = "GREATER THAN";
	LABEL Median_B_Choles = "Median of Baseline Cholesterol measurement";
	LABEL B_Chol_Strata = "Greater than or less than equal to the median of B_Cholesterol";
RUN;

PROC CONTENTS DATA=VISITS_TXGROUP;
RUN;

/* C.d */
DATA VISITS_0;
	SET VISITS_TXGROUP;
RUN;

DATA VISITS_1;
	SET VISITS_0;
	Visit = 1;
	VisitDt = VisitDt + 30;
RUN;

DATA VISITS_2;
	SET VISITS_1;
	Visit = 2;
	VisitDt = VisitDt + 30;
RUN;

DATA VISITS_3;
	SET VISITS_2;
	Visit = 3;
	VisitDt = VisitDt + 30;
RUN;

DATA SCHEDULED_VISITS;
	SET VISITS_0 VISITS_1 VISITS_2 VISITS_3;
RUN;

PROC CONTENTS DATA=SCHEDULED_VISITS;
RUN;


/* C.e */
/* SCHEDULED_VISITS has 9452 observations and 8 variables*/
/* VISITS_TXGROUP has 2363 observations and 8 variables */