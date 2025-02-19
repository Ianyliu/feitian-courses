PROC OPTIONS OPTION=MACRO;
RUN;

/* 24A */
DATA STUDYTIME; 
  set '/home/u62223361/Intro to SAS/HW7/studytime.sas7bdat'; 
RUN; 

PROC CONTENTS DATA = STUDYTIME;
RUN;

DATA STUDYTIME;
	SET STUDYTIME;
	TIME_PER_UNIT = TIME/UNITS;
RUN;

/* 24 B */
PROC SORT DATA = STUDYTIME;
BY SECTION;
RUN;
PROC MEANS DATA = STUDYTIME; 
BY SECTION;
OUTPUT OUT = STUDYTIME_STATS;
RUN; 

/* 24C */
%MACRO SECTIONDATA (SECTION_NUM=);
	PROC PRINT DATA = STUDYTIME;
		WHERE SECTION = "0&SECTION_NUM";
		TITLE "DATA FOR SECTION &SECTION_NUM";
	RUN;
%MEND SECTIONDATA;

/* 24D */
PROC OPTIONS OPTION = SYMBOLGEN;
RUN;

/* 24E */
%MACRO SECTIONDATA (SECTION_NUM=);
	PROC SQL NOPRINT;
		SELECT TIME_PER_UNIT
			INTO :AVG_TIME_PER_UNIT_SEC
			FROM STUDYTIME_STATS
			WHERE SECTION = "0&SECTION_NUM" 
			AND _STAT_ = "MEAN";
	QUIT;
	
	%IF &AVG_TIME_PER_UNIT_SEC > 2 %THEN 
		%LET FOOTNOTE = "Average study time was met for section &SECTION_NUM";
	%ELSE
		%LET FOOTNOTE = = "Average study time was NOT met for section &SECTION_NUM";
		
	PROC PRINT DATA = STUDYTIME;
		WHERE SECTION = "0&SECTION_NUM";
		TITLE "DATA FOR SECTION &SECTION_NUM";
		FOOTNOTE "&FOOTNOTE";
	RUN;
%MEND SECTIONDATA;


/* 24F */
%MACRO SECTIONDATA (SECTION_NUM=);
	PROC SQL NOPRINT;
		SELECT TIME_PER_UNIT
			INTO :AVG_TIME_PER_UNIT_SEC
			FROM STUDYTIME_STATS
			WHERE SECTION = "0&SECTION_NUM"
			AND _STAT_ = "MEAN";
	QUIT;

	%LET AVG_TIME_PER_UNIT_SEC_ROUNDED = %SYSFUNC(ROUND(&AVG_TIME_PER_UNIT_SEC, .01));
	
	%IF &AVG_TIME_PER_UNIT_SEC > 2 %THEN 
		%LET FOOTNOTE = "&AVG_TIME_PER_UNIT_SEC_ROUNDED HRS: average study time was met for section &SECTION_NUM";
	%ELSE
		%LET FOOTNOTE = "&AVG_TIME_PER_UNIT_SEC_ROUNDED HRS: average study time was NOT met for section &SECTION_NUM";
		
	PROC PRINT DATA = STUDYTIME;
		WHERE SECTION = "0&SECTION_NUM";
		TITLE "DATA FOR SECTION &SECTION_NUM";
		FOOTNOTE "&FOOTNOTE";
	RUN;
%MEND SECTIONDATA;

/* 24G */
%SECTIONDATA(SECTION_NUM = 1);
%SECTIONDATA(SECTION_NUM = 2);