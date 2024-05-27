/* 23A */
DATA POPULATION; 
  set '/home/u62223361/Intro to SAS/HW8/population.sas7bdat'; 
RUN; 

PROC CONTENTS DATA= POPULATION;
RUN;

PROC SGPLOT DATA = POPULATION;
	HISTOGRAM Y1;
	DENSITY Y1; 
	DENSITY Y1 / TYPE = KERNEL;
RUN;

/* 23B */
PROC SGPANEL DATA = POPULATION;
	PANELBY Continent; 
	HISTOGRAM Y1;
	DENSITY Y1; 
RUN;

/* 23C */
PROC SGPLOT DATA = POPULATION;
	VBOX Y1 / CATEGORY= Continent;
RUN;

/* 23D */
/* Histograms can visualize probability distributions 
while box plots are good for assessing how the quartiles are distributed and if there are outliers. 
Boxplots are more concise in describing the spread and can be better when the histogram has lots 
of ups and downs, which could be confusing. */

/* 27A */
DATA STUDY_GPA; 
  set '/home/u62223361/Intro to SAS/HW8/study_gpa.sas7bdat'; 
RUN; 

PROC CONTENTS DATA= STUDY_GPA;
RUN;
PROC SGPLOT DATA = STUDY_GPA;
	VBOX AveTime / CATEGORY= SECTION;
RUN;

/* 27B */
PROC SGPLOT DATA = STUDY_GPA;
	REG X = AveTime Y = GPA / NOMARKERS
	NOLEGCLM NOLEGCLI;
	
/* 27C */
PROC SGPLOT DATA = STUDY_GPA;
	REG X = AveTime Y = GPA / NOMARKERS
	ALPHA=0.05 CLMTRANSPARENCY=0.5 GROUP=SECTION;
	KEYLEGEND / LOCATION = INSIDE POSITION = BOTTOMRIGHT;

/* 27D */
PROC SGPLOT DATA = STUDY_GPA;
	REG X = AveTime Y = GPA / NOMARKERS CLM GROUP=SECTION
	NOLEGCLM NOLEGCLI ALPHA=0.05 CLMTRANSPARENCY=0.6;
	KEYLEGEND / LOCATION = INSIDE POSITION = BOTTOMRIGHT;
	
/* 27E */
/* As average study time increases in section 1, GPA tends to go down. 
As average study time increases in section 2, GPA tends to go up. 
Average study time and GPA have a inverse correlation in section 1,
and average study time and GPA have a positive correlation in section 2. */