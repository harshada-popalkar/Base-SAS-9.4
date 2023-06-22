proc format lib=trial ;
value $ Education
'SSC'=1
'HSC'=2
'Graduation'=3
'Postgraduation'=4
'Phd'=5 ;
run;
proc format lib= Trial fmtlib ;
run;


*Displaying a List of Your Formats;
proc format lib=trial;
value cgpa
0-<5 = 'fail'
5-<7 ='B'
7-<8 ='A'
8-<10 = 'O' ;
run;

*Assigning Your Formats to Variables;
data Trial.student;
	input cgpa_s placement;
	format cgpa_s cgpa. ;
	datalines;
6.89 3.26
5.12 1.98
7.82 3.25
7.42 3.67
6.94 3.57
7.89 2.99	
6.73 2.6
6.75 2.48
6.09 2.31
8.31 3.51
5.32 1.86
6.61 2.6
8.94 3.65
6.93 2.89
7.73 3.42
;
run;
proc print data=trial.student;
run;

proc format ;
value $basket
'MILK'= 1
'BREAD'= 2;
run;


data a;
	infile '/home/u63348281/2023/MILK,BREAD,BISCUIT.txt' dlm=',';
	input A $ B $ C $;
	format A $basket. B $basket. C $basket. ;
run;
proc print data=a ;
run;