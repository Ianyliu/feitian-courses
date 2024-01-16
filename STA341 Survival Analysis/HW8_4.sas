* Simulated observational study;
data trt0;
   call streaminit(1234);        /* seed=1234, use default method */
   do ID =51 to 100;
   trt=0;
   lambda=0.2;
   event   =(rand('uniform', 0, 1)>0.3);
   drinking=(rand('uniform', 0, 1)>0.7);
   if rand('uniform', 0, 1)>0.2 then smoking =drinking; else smoking=(drinking=0);
   age     =int(60+20*(rand('uniform', -1, 1)));
   gender  =(rand('uniform', 0, 1)>0.5);
   month=RAND('EXPONENTIAL', 1/lambda) 
     + ((drinking=0)+1)*rand('uniform', 1, 2)
     + 100/age;
   output;
   end;
run;

data trt1;
   call streaminit(5678);        /* seed=568, use default method */
   do ID =1 to 50;
   trt=1;
   lambda=0.153;
   event   =(rand('uniform', 0, 1)>0.3);
   drinking=(rand('uniform', 0, 1)>0.7);
   if rand('uniform', 0, 1)>0.2 then smoking =drinking; else smoking=(drinking=0);
   age     =int(60+20*(rand('uniform', -1, 1)));
   gender  =(rand('uniform', 0, 1)>0.5);
   month=RAND('EXPONENTIAL', 1/lambda) 
     + ((drinking=0)+1)*rand('uniform', 1, 2)
     + 100/age;
   output;
   end;
run;

data HW8;
   set trt0 trt1;
   month=int(month*100)/100;
run;
proc print data=HW8;
run;

proc corr data=HW8;
var drug drinking smoking age gender;
run;

proc lifetest data=HW8 nelson plot=(s(CL) ls lls h) ;
time month*event(0);
strata trt/test=logrank;
run;
 
proc phreg data=HW8;
model month*event(0) = trt ;
run;

proc phreg data=HW8;
model month*event(0) = trt drinking smoking age gender;
run;

proc phreg data=HW8;
model month*event(0) = trt drinking smoking age gender/selection=forward include=1 details slentry=0.1 slstay=0.05;
run;

proc phreg data=HW8;
model month*event(0) = trt | drinking | smoking | age | gender;
hazardratio trt;
run;

proc phreg data=HW8;
model month*event(0) = trt | drinking | smoking | age | gender/selection=forward include=1 details slentry=0.1 slstay=0.1;
hazardratio trt;
run;
