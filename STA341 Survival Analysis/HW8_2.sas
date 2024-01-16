* Simulated observational study;
data trt0;
   call streaminit(1234);        /* seed=1234, use default method */
   do ID =1 to 50;
   trt=0;
   lambda=0.20;
   event =(rand('uniform', 0, 1)>0.25);
   meno  =(rand('uniform', 0, 1)>0.3);
   tsize =int(10*(5+4.9*(rand('uniform', -1, 1))))/10;
   nodes =int(10+9*(rand('uniform', -1, 1)));
   er    =(rand('uniform', 0, 1)>0.5);
   month =(RAND('EXPONENTIAL', 1/lambda)  
    + ((meno=0)+1)*4*rand('uniform', 1, 2)
	+ 5/tsize
    + 15/nodes
	+ 8*(er+1)*rand('uniform', 0, 1)  );
   output;
   end;
run;

data trt1;
   call streaminit(5678);        /* seed=5678, use default method */
   do ID =51 to 100;
   trt=1;
   lambda=0.12;
   event =(rand('uniform', 0, 1)>0.25);
   meno  =(rand('uniform', 0, 1)>0.3);
   tsize =int(10*(5+4.9*(rand('uniform', -1, 1))))/10;
   nodes =int(10+9*(rand('uniform', -1, 1)));
   er    =(rand('uniform', 0, 1)>0.5);
   month =(RAND('EXPONENTIAL', 1/lambda)  
    + ((meno=0)+1)*4*rand('uniform', 1, 2)
	+ 5/tsize
    + 15/nodes
	+ 8*(er+1)*rand('uniform', 0, 1)  );
   output;
   end;
run;

data HW7;
   set trt0 trt1;
   month=round(100*month)/100;
run;
proc print data=HW7;
run;

proc corr data=HW7;
var month trt meno tsize nodes er;
run;
