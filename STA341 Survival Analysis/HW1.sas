Data mi;
	input survtime number status;
cards;
0 0 1
0 0 0
1 0 1
1 0 0
2 0 1
2 0 0
3 0 1
3 0 0
4 0 1
4 0 0
5 0 1
5 0 0
6 0 1
6 0 0
7 0 1
7 0 0
8 0 1
8 1 0
9 0 1
9 1 0
10 0 1
10 0 0
11 0 1
11 0 0 
12 0 1
12 0 0 
13 1 1
13 1 0 
14 0 1 
14 0 0
15 2 1
15 0 0
16 0 1
16 1 0
17 0 1
17 0 0
18 1 1
18 0 0
; 
run;

Proc print data=mi;
run;

proc lifetest method=life intervals=(0 to 19 by 1) data=mi;
time survtime*status(0);
freq number;
run;

