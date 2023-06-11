*PUTLOG Statement;
options obs=2;
data putlog;
set sashelp.birthwgt ;
putlog AgeGroup= Death= ;
run;

*Using the PUT Statement;
options obs=2;
data putlog;
set sashelp.birthwgt ;
put'Note';

*Conditional Processing;
options obs=30;
data log;
set sashelp.birthwgt ;
if AgeGroup = 1 then put "children's data";
run;
