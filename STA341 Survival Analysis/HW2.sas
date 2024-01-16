*3e;

Data mi;
input survtime number status;
cards;
0 27 1
0 3  0
1 18 1
1 10 0
2 21 1
2 10 0
3 9  1
3 3  0
4 1  1
4 3  0
5 2  1
5 11 0
6 3  1
6 5  0
7 1  1
7 8  0
8 2  1
8 1  0
9 2  1
9 6  0
;
run;
proc lifetest data=mi method=life outsurv=mydata1 plots=(s(CL)); 
**s=survival function, ls=log survival function, lls=log log survival function, h=hazard function, p=probability density function;
time survtime*status(0);
freq number;
run;


*4;

Data engine_fail;
input survtime number status;
cards;
1.3 1 0
3.5 1 1
4.6 1 1
5.2 1 1
6.1 1 0
8.4 1 1
9.5 1 0
;
run;

*4d*;

proc lifetest data=engine_fail method=km outsurv=mydata2 plots=(s); 

time survtime*status(0);
freq number;

run;

*5f;
proc lifetest data=engine_fail method=km  
Nelson 
OUTSURV=mydata3 
plots=(s)
;
time survtime*status(0);
freq number;
run;

