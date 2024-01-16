data q2;
input ID month event trt meno tsize nodes er;
if meno = . or tsize = . or nodes = . or nodes = 0 or er = . then delete;
trt2 = trt - 1;
dn1 = (nodes=1);
dn2 = (nodes=2);
dn3 = (nodes=3);
dn4 = (nodes=4);
dn510 = (4.5<nodes<10.5);
dn1015 = (10.5<nodes<15.5);
dn15 = (nodes>15.5);
dnscore = nodes;
if dn510=1 then
dnscore=7.5;
else if dn1015=1 then
dnscore=13;
else if dn15=1 then
dnscore=20;
label months="(censored) survival time in months"
	event="event"
	trt="treatment"
	meno="menopausal status"
	tsize="size of largest tumor in cm"
	nodes="number of positive nodes"
	er="estrogen receptor status"
	trt2="indicator for treatment 2";
datalines;

1 24.05 0 1 1 7 8 1
51 26.2 1 0 1 3 6 1
2 23.81 1 1 0 7.2 9 0
52 25.08 0 0 1 1.4 14 0
3 17.69 0 1 1 7.3 2 0
53 28.82 1 0 1 1 6 1
4 40.05 1 1 0 0.6 4 0
54 11.57 1 0 1 2.4 13 0
5 18.88 1 1 0 3.4 13 0
55 29.61 1 0 0 9.8 9 0
6 32.9 1 1 0 1.1 3 1
56 7.21 1 0 1 6.5 18 0
7 35.44 1 1 0 8.2 6 1
57 24.07 0 0 0 4.8 4 0
8 33.26 0 1 1 9.3 8 0
58 41.3 1 0 1 4.8 18 1
9 39.94 1 1 1 2.6 2 1
59 17.08 1 0 1 6.9 13 1
10 10.59 0 1 1 1.9 18 0
60 28.74 0 0 1 1 5 0
11 48.2 1 1 1 0.2 13 0
61 18.47 1 0 1 8.2 6 0
12 92.13 1 1 0 2.6 6 1
62 14.44 0 0 1 8.5 6 1
13 14.87 0 1 1 1.5 18 1
63 49.02 1 0 1 0.6 2 1
14 45.9 1 1 1 6.3 1 0
64 9.04 1 0 1 7.8 15 0
15 37.52 0 1 0 4.2 6 1
65 34.74 1 0 0 1.2 12 1
16 40.35 1 1 0 0.3 6 1
66 13.95 0 0 1 5.3 9 1
17 21.74 1 1 1 4.7 10 0
67 15.96 0 0 1 3.4 13 0
18 19.04 1 1 0 6.7 14 0
68 13.07 0 0 1 1.5 18 1
19 73.04 1 1 0 0.3 18 0
69 31.09 1 0 1 9 3 1
20 26.04 0 1 0 6.5 12 0
70 27.97 1 0 1 8.6 18 0
21 35.24 1 1 1 1 1 0
71 24.48 0 0 0 4 5 0
22 34.51 0 1 0 5.2 14 1
72 20.9 0 0 1 2.3 11 0
23 48.13 0 1 1 6.7 18 0
73 32.03 1 0 1 6.6 8 0
24 21.23 1 1 1 2.6 5 1
74 29.57 0 0 1 3 10 0
25 28.24 1 1 1 6.5 4 0
75 28.99 1 0 1 0.7 12 0
26 31.87 0 1 0 0.5 17 0
76 21.43 1 0 0 8 6 1
27 17.91 1 1 1 5 16 0
77 36.94 1 0 1 0.6 7 0
28 47.67 1 1 1 0.2 9 0
78 24.63 1 0 1 1.9 7 1
29 43.33 1 1 1 2.6 5 1
79 27.48 1 0 1 1.2 15 0
30 16.97 0 1 1 4.3 8 1
80 20.66 1 0 0 2.7 6 0
31 14.07 1 1 1 5.9 8 0
81 42.99 1 0 0 9.6 14 1
32 37.39 1 1 1 8.8 5 0
82 24.37 1 0 1 6.4 5 1
33 35.27 1 1 1 5.6 1 0
83 11.41 1 0 1 7.1 13 0
34 15.01 1 1 1 9.8 10 1
84 10.64 0 0 1 5.3 6 0
35 25.71 1 1 0 2.6 16 1
85 18.85 0 0 1 9 12 1
36 15.97 1 1 0 6.8 8 0
86 19.64 1 0 0 5.8 10 1
37 48.26 1 1 1 0.2 3 0
87 21.55 0 0 1 7.7 7 0
38 39.03 1 1 1 5.4 8 0
88 9.86 1 0 1 3.2 16 0
39 35.48 1 1 1 0.5 11 1
89 49.75 1 0 1 8.6 7 1
40 21.27 0 1 1 8.7 6 1
90 33.61 0 0 1 6.9 14 1
41 27.13 0 1 0 3.2 12 0
91 27.02 1 0 1 6.7 16 0
42 39.88 1 1 0 5.8 1 1
92 34.33 0 0 0 6.8 1 1
43 53.35 1 1 0 9.3 12 1
93 12.29 1 0 1 8.1 17 1
44 20.85 1 1 0 7.8 5 0
94 20.28 1 0 1 5.8 3 0
45 21.66 1 1 1 1.7 13 0
95 22.84 0 0 0 1.1 10 1
46 21.97 0 1 1 5.7 12 1
96 40.01 0 0 0 2.1 1 1
47 27.29 0 1 1 0.6 13 0
97 33.99 0 0 0 2.4 5 1
48 9.59 1 1 1 5.5 12 1
98 45.18 1 0 1 9.2 1 1
49 14.18 0 1 1 9.6 17 0
99 17.08 1 0 0 8.9 15 0
50 28.41 1 1 0 5 9 1
100 19.75 1 0 0 4.4 17 0
;

run;

title "2a Analysis of treatment effect adjusting for meno, tsize, nodes, er";
proc phreg data=q2;
model month*event(0) = meno tsize er dn1 dn2 dn3 dn4 dn510 dn1015 / covb;
run;

title "2f Analysis of treatment effect adjusting for meno, tsize, nodes, er";
proc phreg data=q2;
model month*event(0) = meno tsize er dn1 dn2 dn3 dn510 dn1015 dn15 / covb;
run;

title "3a Omnibus Test for Nodes using Dummy Variables";
proc phreg data=q2 ;
model month*event(0) = meno tsize er dn1 dn2 dn3 dn4 dn510 dn1015 
/ selection=f details include = 3 slentry=1.0 covb;
test_nodes: test dn1, dn2, dn3, dn4, dn510, dn1015;
run;


title1 "3b Trend test for number of nodes";
title2 "Analysis of adjusted nodes effect using subsample";
proc phreg data=q2;
model month*event(0) = meno tsize er dnscore
 / selection=f details include=3 slentry=1 covb;
 hazardratio dnscore;
run;



data q4;
input ID trt event drinking smoking age gender month;
agesq = age**2;
age1 = (39.5<age<50.5);
age2 = (50.5<age<60.5);
age3 = (60.5<age<70.5);
age4 = (70.5<age<81.5);
agescore = age;
if age1=1 then
agescore=45;
else if age2=1 then
agescore=55;
else if age3=1 then
agescore=65;
else if age4=1 then
agescore=75;
datalines; 

1 1 0 0 0 57 1 7.91
51 0 1 1 1 51 1 11.04
2 1 1 0 1 69 0 11.5
52 0 1 0 0 45 1 8.32
3 1 1 1 1 57 1 18
53 0 1 1 1 78 0 9.2
4 1 1 0 1 76 0 23.17
54 0 1 1 1 72 0 10.33
5 1 0 0 0 61 1 13
55 0 0 0 0 43 1 19.55
6 1 1 0 0 72 0 4.67
56 0 1 0 0 67 1 7.91
7 1 0 0 0 55 0 10.78
57 0 1 1 1 76 0 17.76
8 1 0 1 1 75 0 23.48
58 0 0 0 1 42 0 23.68
9 1 0 1 1 57 0 18.67
59 0 1 1 1 78 1 19.32
10 1 1 0 0 50 0 7.4
60 0 1 0 0 68 1 6.22
11 1 1 1 0 52 0 3.32
61 0 1 0 1 69 0 10.37
12 1 1 0 1 69 1 33.92
62 0 1 1 1 72 1 3.61
13 1 0 0 1 72 0 13.74
63 0 1 1 1 77 0 8.04
14 1 0 0 1 75 1 18.94
64 0 0 0 0 46 0 7.8
15 1 0 1 1 74 0 12.44
65 0 0 0 0 40 1 10.76
16 1 1 0 1 53 0 5.23
66 0 1 1 1 56 1 4.3
17 1 0 0 0 51 1 9.99
67 0 1 0 1 64 1 9.82
18 1 1 0 0 41 0 10.27
68 0 1 0 0 61 0 7.29
19 1 1 0 0 73 0 8.17
69 0 0 0 1 52 0 6.61
20 1 1 0 0 65 0 7.52
70 0 1 0 0 47 1 15.83
21 1 0 0 0 47 0 13.88
71 0 1 1 1 40 0 4.53
22 1 1 0 1 45 1 14.47
72 0 0 0 1 69 0 9.03
23 1 1 0 0 60 1 7.51
73 0 1 1 0 42 0 4.38
24 1 1 0 1 57 0 9.05
74 0 0 0 0 55 1 7.79
25 1 0 0 0 70 1 17.25
75 0 0 0 0 62 0 9.22
26 1 1 0 0 67 1 8.42
76 0 1 1 1 66 0 8.03
27 1 1 1 1 61 0 13.02
77 0 1 1 1 66 0 5.8
28 1 1 1 1 60 1 5.59
78 0 0 0 0 65 1 18.49
29 1 1 0 0 56 0 15.66
79 0 1 0 0 58 0 15.91
30 1 1 0 0 73 0 9.12
80 0 1 1 1 59 0 5.94
31 1 1 1 1 54 0 12.47
81 0 0 0 0 42 0 5.81
32 1 1 0 0 44 0 14.32
82 0 1 0 0 73 1 9.57
33 1 1 1 1 50 1 28.87
83 0 1 0 1 71 0 15.58
34 1 0 0 0 57 0 6.92
84 0 1 0 1 50 0 15.93
35 1 0 0 0 59 1 9.7
85 0 0 0 0 50 1 7.19
36 1 1 0 0 68 0 4.68
86 0 0 0 1 51 1 6.67
37 1 1 0 0 77 1 5.17
87 0 1 0 0 68 1 8.55
38 1 0 0 0 66 1 8.12
88 0 1 0 0 67 0 23.54
39 1 1 0 0 64 1 15.96
89 0 1 0 0 71 0 14.83
40 1 0 0 0 79 0 11.15
90 0 1 1 1 60 0 3.42
41 1 1 0 0 55 0 4.48
91 0 1 0 0 60 1 4.5
42 1 1 0 0 40 0 12.58
92 0 1 0 0 71 0 9.52
43 1 1 0 0 61 1 9.11
93 0 0 1 1 58 0 3.63
44 1 0 0 1 71 1 25.3
94 0 1 0 1 73 0 4.78
45 1 1 0 0 55 0 6.34
95 0 1 0 0 77 0 9.13
46 1 1 0 0 51 0 23.72
96 0 1 1 0 75 1 9.5
47 1 1 0 1 61 1 4.97
97 0 1 1 1 43 1 4.25
48 1 0 0 1 62 1 23.09
98 0 0 0 1 67 0 7.66
49 1 1 0 0 65 1 24.51
99 0 0 0 0 76 1 7.54
50 1 1 1 0 71 0 13
100 0 0 1 1 63 0 10.14
;

run;

title "4a Global Test";
proc phreg data=q4;
model month*event(0) = trt drinking smoking age gender / covb;
hazardratio trt;
run;

title "4a Individual";
proc phreg data=q4;
model month*event(0) = drinking smoking age gender trt / 
selection=f details include = 4 slentry=0.1 slstay=0.05 covb;
hazardratio trt;
run;

title "4b Model Selction";
proc phreg data=q4;
model month*event(0) = trt drinking smoking age gender / 
selection=f details slentry=0.1 slstay=0.05 covb;
hazardratio trt;
run;

title "4c Test Quadratic Term age^2";
proc phreg data=q4;
model month*event(0) = drinking smoking age gender trt agesq / 
selection=f details include = 5 slentry=1 slstay=0.05 covb;
hazardratio trt;
run;

title "4d Discretize Age into 4 groups";
proc phreg data=q4;
model month*event(0) = trt drinking smoking gender age1 age2 age3 age4
 /  covb;
 hazardratio trt;
run;

title "4e All 2-way interactions Global Test";
proc phreg data=q4;
model month*event(0) = trt drinking smoking gender age 
age*drinking age*gender age*smoking age*drinking age*trt 
drinking*smoking drinking*trt drinking *gender
trt*smoking trt *gender
gender *smoking ;
 hazardratio trt;
run;

title "4e All 2-way interactions Individual Test for trt";
proc phreg data=q4;
model month*event(0) = drinking smoking gender age 
age*gender age*smoking age*drinking  
drinking*smoking drinking *gender
gender*smoking trt drinking*trt trt*smoking trt *gender age*trt
 / selection=f details include =10 slentry=0.1 slstay=0.1;
 hazardratio trt;
run;

title "4f All 2-way interactions";
proc phreg data=q4;
model month*event(0) = trt | drinking | smoking | age | gender
/ selection=stepwise details slentry=0.1 slstay=0.1;
hazardratio trt;
run;
