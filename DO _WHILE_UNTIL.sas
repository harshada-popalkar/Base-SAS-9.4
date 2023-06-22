* DO statement;
DATA Trial.STOCKS;
SET SASHELP.STOCKS(DROP= Adjclose);
LENGTH STATUS $ 10;
IF CLOSE > OPEN THEN
DO;
STATUS = 'DEC';
END;
ELSE IF CLOSE < OPEN THEN STATUS= 'INC' ;
ELSE IF CLOSE = OPEN THEN STATUS ='NO CHANGE';
RUN;
PROC PRINT DATA=STOCKS;
RUN;
PROC SORT DATA= STOCKS ;
BY STOCK;
RUN;
PROC PRINT DATA= STOCKS;
ID STOCK ;
BY STOCK ;
VAR  OPEN CLOSE ;
WHERE PROFIT= 'HIGH';
RUN;     

* Processing Iterative DO loops ;
data trial.percentage(drop=i);
set trial.stocks;
day= day(date);
month = month(date);
year=year(date);
do i= 1 to _N_ ;
stock_growth = ((close-open)/open )*100;
end;
run;  
run;
proc print data= percentage ;
var open close stock_growth ;
run;

data per;
set trial.percentage;
do i=1 to _N_ while (stock='IBM');
month=month(date);
growth_percentage = ((close-open)/open )*100;
output;
end;
run;
proc print data=per ;
run;

data per;
set percentage;
do until (year(date)<2000);
growth_percentage = ((close-open)/open )*100;
output;
end;
run;
                                                                                                                                                      