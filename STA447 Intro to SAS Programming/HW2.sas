/*
Question 45
a. Number of variables: 2 (excluding ID/row number); 
Number of observations: 10*/

/* B*/

DATA cancer_rates;
	INFILE "/home/u62223361/Intro to SAS/HW2/CancerRates.dat";
	INPUT ID Type Size; 
RUN;

/* C*/
PROC PRINT DATA = cancer_rates; 
  title 'Output dataset: hw2_dat.cancer_rates';
  RUN;
  
/* D*/
DATA cancer_rates2;
	INFILE "/home/u62223361/Intro to SAS/temp/CancerRates.dat";
	INPUT Type Size; 
RUN;
PROC PRINT DATA = cancer_rates; 
  title 'Output dataset: hw2_dat.cancer_rates2';
  RUN;
  
/*
Question 54
*/

/* A*/

%web_drop_table(WORK.OSCAR);


FILENAME REFFILE '/home/u62223361/Intro to SAS/HW2/Oscars.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=WORK.OSCAR;
	GETNAMES= NO;
	INPUT 
		ID 2 
		YEAR 4. 
		HOST $ 
		BEST_PIC $ 
		BEST_ACTOR $ 
		BEST_ACTRESS $ 
		BEST_DIRECTOR $ 
		BEST_SCREENPLAY $;
RUN;

data OSCAR; set WORK.OSCAR;
rename 
A = ID
B = YEAR
C= HOST
D = BEST_PIC
E = BEST_ACTOR 
F = BEST_ACTRESS  
G = BEST_DIRECTOR  
H = BEST_SCREENPLAY;

RUN;

PROC PRINT DATA = OSCAR; 
  title 'Output dataset: hw2_dat.OSCAR';
  RUN;

/* B */
PROC CONTENTS DATA=WORK.OSCAR; RUN;

/* C: The limitations include the missing talk show host represented as a string instead of a missing value. 
The actresses and actors that won are associated with a picture, but best_actress should just be the 
actresses' name to avoid confusion. Also, I had to rename the data separately. 
The Import statment, unlike the engine, also cannot allow multiple users to use the same Excel file. 
Using libname to read data allows locking of the Excel file. */

/* D */

LIBNAME Oscars XLSX '/home/u62223361/Intro to SAS/HW2/Oscars.xlsx';
PROC PRINT DATA = Oscars.Awards;
	TITLE 'PROC PRINT OF OSCAR DATA';
RUN;
/* Limitations of using this method:  does not offer many options 
because it is reading it as a SAS dataset (according to the textbook).
*/