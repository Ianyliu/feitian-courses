Data myData;
input week status trt;
trtp = (trt = 2);
trtm = (trt = 1);
/*p =2, m =1  */
cards;
5 1 2
5 1 2 
8 1 2 
8 1 2
12 1 2
16 0 2
23 1 2
27 1 2
30 1 2
33 1 2
43 1 2
45 1 2
9 1 1
13 1 1
13 0 1
18 1 1
23 1 1 
28 0 1
31 1 1
34 1 1
45 0 1
48 1 1
161 0 1
; 
run;



Title "4a 4b Log-rank test for TRT without stratification";
proc lifetest data=myData;
time week*status(0);
strata trt / test=logrank;
run;


Title "4c 4d PHREG for treatment p";
proc phreg data=myData;
model week*status(0)=trtp;
run;

Title "4c 4d PHREG for treatment m";
proc phreg data=myData;
model week*status(0)=trtm;
run;
