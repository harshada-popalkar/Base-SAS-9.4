* Que1 ;
DATA work.shoes ;
SET sashelp.shoes;
RUN ;
PROC SORT DATA=work.shoes OUT= work.sorteshoes;
BY DESCENDING product  sales ;
OPTIONS FIRSTOBS=130 OBS=130 ;
PROC PRINT DATA= work.sorteshoes(KEEP=region);
OPTIONS FIRSTOBS=148 OBS=148 ;
PROC PRINT DATA= work.sorteshoes(KEEP=product);
RUN;

*Que2 ;
DATA work.shoerange;
SET sashelp.shoes;
LENGTH salesrange $ 7 ; 
IF sales < 100000 THEN salesrange ='Lower';
ELSE IF 100000 < = sales < = 200000 THEN salesrange ='Middle';
ELSE IF sales > 200000 THEN salesrange = 'Upper';
RUN;
PROC PRINT DATA=work.shoerange (KEEP=salesrange sales);
RUN;
PROC FREQ DATA= shoerange ;
TABLE salesrange ;
RUN;
PROC MEANS DATA= shoerange MEAN maxdec=0;
VAR sales;
WHERE salesrange = 'Middle';
RUN;

*Que3;
data work.lowchol work.highchol work.misschol;
set sashelp.heart;
if cholesterol lt 200 and not  missing(cholesterol) then output work.lowchol;
if cholesterol ge 200  then output work.highchol;
if missing(cholesterol)then output work.misschol;
run;
proc contents data=work.lowchol ;
run;
proc contents data=work.highchol ;
run;
proc contents data=work.misschol ;
run;

















