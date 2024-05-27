/* 41A */
DATA GASMILEAGE; 
  set '/home/u62223361/Intro to SAS/HW3/gasmileage.sas7bdat'; 
  State = UPCASE(State);
  IF State = "NEW YORK";
RUN; 
/* 41B */
DATA GASMILEAGE; 
  set GASMILEAGE; 
  AvgDailyCityMiles = MEAN(CityMile1, CityMile2, CityMile3, CityMile4, CityMile5, CityMile6, CityMile7);
  AvgDailyHWYMiles = MEAN(HWYMile1, HWYMile2, HWYMile3, HWYMile4, HWYMile5, HWYMile6, HWYMile7);
  AvgDailyCityMiles = ROUND(AvgDailyCityMiles, .1);
  AvgDailyHWYMiles = ROUND(AvgDailyHWYMiles, .1);
RUN; 
/* 41C */
DATA GASMILEAGE; 
  set GASMILEAGE; 
  TotalCityMiles = SUM(CityMile1, CityMile2, CityMile3, CityMile4, CityMile5, CityMile6, CityMile7);
  TotalHWYMiles = SUM(HWYMile1, HWYMile2, HWYMile3, HWYMile4, HWYMile5, HWYMile6, HWYMile7);
  TotalGallonsConsumed = TotalCityMiles * cityMPG + TotalHWYMiles * HWYMPG;
RUN; 
/* 41D */
/* Current Average for NY State 3.308 */
DATA GASMILEAGE; 
  set GASMILEAGE; 
  TotalTestWeekCost = ROUND(TotalGallonsConsumed * 3.308, .01);
RUN; 
/* 41E */
DATA GASMILEAGE; 
  set GASMILEAGE;
  NumWeeksToSpend1000 = TotalTestWeekCost/ 1000;
RUN; 
/* 41F */
PROC PRINT DATA = GASMILEAGE;
  RUN;
/* 1st obs: LICENSE: 0SEP243  AvgDailyCityMiles:  4.7 AvgDailyHWYMiles: 45.5 TotalTestWeekCost: 23732.25 NumWeeksToSpend1000: 23.7323*/

/* 47A */
DATA BANDJ;
	INFILE '/home/u62223361/Intro to SAS/HW3/ben_and_jerrys.csv' DSD  delimiter="," FIRSTOBS=2;
	INPUT Flavor $ Portion	Calories	CalFat	Fat	SatFat	
	TransFat	Cholesterol	Sodium	Carbohydrates	Fiber $
	Sugar	Protein	YearIntro	YearRetire	Description	$ Notes $;
RUN;
PROC PRINT DATA = BANDJ;
	TITLE "PROC PRINT OF BEN AND JERRY'S";
RUN;

/* 47B */

PROC SQL;
	CREATE TABLE BANDJ_CURRENT AS
	SELECT * FROM BANDJ WHERE NOT (
	 Notes CONTAINS 'retire' OR Notes CONTAINS 'retired'
	OR Notes CONTAINS 'RETIRE' OR Notes CONTAINS 'RETIRED' OR
	Description CONTAINS 'retire' OR Description CONTAINS 'retired'
	OR Description CONTAINS 'RETIRE' OR Description CONTAINS 'RETIRED');
QUIT;
DATA BANDJ_CURRENT;
	SET BANDJ_CURRENT;
	IF Notes =: "Scoop Shop Exclusive" THEN DELETE;
RUN;
PROC PRINT DATA = BANDJ_CURRENT;
	TITLE "PROC PRINT OF BEN AND JERRY'S CURRENT FLAVORS";
RUN;

/* 47C */
DATA BANDJ_CURRENT;
	SET BANDJ_CURRENT;
	CaloriesInTBLSP = Calories / (Portion /15);
	IF CaloriesInTBLSP ~= .;
RUN;

/* 47D */
DATA BANDJ_CURRENT;
	SET BANDJ_CURRENT;
	RETAIN TotalCalories 0;
	TotalCalories = SUM(CaloriesInTBLSP, TotalCalories);
RUN;

/* 47E */
DATA BANDJ_CURRENT;
	SET BANDJ_CURRENT;
	RETAIN MaxCalories 0;
	MaxCalories = MAX(MaxCalories, CaloriesInTBLSP);
RUN;

/* 47F */
PROC PRINT DATA = BANDJ_CURRENT;
	TITLE "PROC PRINT OF BEN AND JERRY'S CURRENT FLAVORS";
RUN;
/* Total Calories (in Single TBSP): 2135.9939433 */
/* Max Calories (in Single TBSP): 46.153846154 */