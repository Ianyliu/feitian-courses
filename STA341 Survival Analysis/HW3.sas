*2b;

data event;
   call streaminit(12345);        /* seed=1234, use default method */
   do ID =1 to 40;
   lambda=0.4;
   t=RAND('EXPONENTIAL', 1/lambda);
   status=1;
   output;
   end;
run;
data censor;
   call streaminit(12345);        /* seed=1234, use default method */
   do ID=41 to 50;
   lambda=0.2;
   t=RAND('EXPONENTIAL', 1/lambda);
   status=0;
   output;
   end;
run;
data q2;
   set event censor;
run;
proc print data=q2;
run;

*2c;

proc lifetest data=q2 method=km OUTSURV=mydata1 plots=(s(CL)) CONFTYPE=log;
time t*status(0);

run;

*2e;

proc lifetest data=q2 method=km OUTSURV=mydata2 plots=(s(CL)) CONFTYPE=linear;
time t*status(0);

run;


*3;

Data lung_cancer;
input survtime status;
cards;
3 1
5 1
6 0
6 0
8 1
10 0
11 0
15 1
20 0
20 0
22 1
23 1
27 0
29 1
32 1
35 1
40 1
26 1
28 1
33 0
33 0
21 1
24 0
;
run;

*3a;
proc lifetest data=lung_cancer method=life outsurv=mydata3 plots=(s); 

time survtime*status(0);
freq number;
run;

*3b;
proc lifetest data=lung_cancer method=km Nelson outsurv=mydata4 plots=(s); 

time survtime*status(0);
freq number;
run;

*3c;
proc lifereg data=lung_cancer plots=probplot;
   model survtime*status(0)= /dist=exponential;
run;

*3d & 4b;
proc lifereg data=lung_cancer plots=probplot;
   model survtime*status(0)= /dist=weibull;
run;



