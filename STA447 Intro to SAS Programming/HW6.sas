/* 28A */

DATA DISTRICT; 
  set '/home/u62223361/Intro to SAS/HW6/district.sas7bdat'; 
RUN; 
DATA PROJECTS; 
  set '/home/u62223361/Intro to SAS/HW6/projects.sas7bdat'; 
RUN; 
DATA TEACHERS; 
  set '/home/u62223361/Intro to SAS/HW6/teachers.sas7bdat'; 
RUN; 
DATA USERS; 
  set '/home/u62223361/Intro to SAS/HW6/users.sas7bdat'; 
RUN; 

PROC CONTENTS DATA = DISTRICT;
RUN;


PROC CONTENTS DATA = TEACHERS;
RUN;

PROC SORT DATA = DISTRICT;
	BY CG TS;
RUN;

PROC SORT DATA = TEACHERS;
	BY CurriculumGrd TeacherScore;
RUN;

DATA COMBINED;
	MERGE TEACHERS DISTRICT  (RENAME=(CG=CurriculumGrd TS=TeacherScore));;
	BY CurriculumGrd TeacherScore;

	



/* 28B */

PROC SORT DATA = DISTRICT;
	BY CG TS;
RUN;

PROC SORT DATA = TEACHERS;
	BY CurriculumGrd TeacherScore;
RUN;

DATA COMBINED;
	MERGE TEACHERS (IN=InTeachers) DISTRICT (IN=InDistrict RENAME=(CG=CurriculumGrd TS=TeacherScore));;
	BY CurriculumGrd TeacherScore;
	IF InTeachers = 1;

/* 28C */

PROC SORT DATA = COMBINED;
	BY Teacher;



/* 28D */

PROC SQL;
	CREATE TABLE COMBINED_SQL AS
	SELECT  Teacher, TeacherScore, CurriculumGrd, Rating
	FROM TEACHERS, DISTRICT
	WHERE TEACHERS.CurriculumGrd = DISTRICT.CG 
		AND TEACHERS.TeacherScore = DISTRICT.TS
	ORDER BY TEACHERS.Teacher;
QUIT;


/* 28E */

/* # OBS: 10  */
/* # VARS: 4 */
