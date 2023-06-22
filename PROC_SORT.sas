LIBNAME TRIAL '/home/u63348281/2023';

*  variable selection; 
DATA TRIAL.chap_4 ;
SET SASHELP.baseball ;
RUN;
PROC PRINT DATA= TRIAL.chap_4 ;
PROC CONTENTS DATA= TRIAL.chap_4 ;
RUN;

* sort entire data by RUNS ;
TITLE1 'SORT BY RUNS';
PROC SORT DATA=TRIAL.chap_4 OUT=TRIAL.RUNS;
BY nRuns ;
RUN ;
PROC PRINT DATA=TRIAL.RUNS;
RUN ;
TITLE1 ;

*label the variable ;
PROC PRINT DATA= TRIAL.RUNS LABEL ;
LABEL Team = 'Team_name'  ;
RUN;

* select observation and variable ;
PROC PRINT DATA=TRIAL.chap_4 NOOBS;
	VAR Team League;
	WHERE nRUNS > 50 ;
RUN ;

PROC SORT DATA= TRIAL.chap_4 ; 
BY Div ;
PROC PRINT DATA=TRIAL.chap_4 ;
	VAR Team nBB nAssts League ;
	ID  Div ;
	BY Div ;
	SUM nBB ;
RUN;

*select first 10 observations ;
OPTIONS OBS=10 ;
PROC PRINT DATA=TRIAL.chap_4 ;
RUN;

* select 20-30 th observations ;
OPTIONS FIRSTOBS=20 OBS=30 ;
PROC PRINT DATA=TRIAL.chap_4 ;
RUN;

* Format ;
TITLE2 'Formating data and currency';
DATA TRIAL.rent;
SET SASHELP.RENT ;
PROC PRINT DATA= TRIAL.rent;
FORMAT DATE MMDDYY10.;
FORMAT AMOUNT DOLLAR12.2;
SUM AMOUNT ;
RUN ;
TITLE2;






