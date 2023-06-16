*MEANS Procedure;
data fish ;
set sashelp.fish;
run;

*Class;
proc means data=fish ;
class species;
var height width weight ;
run;

*output;
proc means data=fish noprint;
class species;
var height width weight ;
output out=class_fish 
mean= avgheight avgwidth avgweight
min= minheight minwidth minweight;
run;
proc print data=class_fish;
run;

*sorting by species;
proc sort data= fish out=sort ;
by Species;
run;
proc means data=sort;
by species ;
run;

proc means data=fish  mean median mode range sum nmiss maxdec=4;
var height width weight ;
run;

proc means data=fish skew var std stderr uss maxdec=4;
var height width weight ;
run;

* Quartile & Percentile;
proc means data=fish q1 p50 q3 qrange maxdec=0;
var height width weight ;
run;

*95% ci ;
proc means data=fish lclm uclm maxdec=0;
var height width weight ;
run;

*p-value & t- statistic ;
proc means data=fish probt t;
var height weight ;
run;

*FREQ Procedure ;
data heart ;
set sashelp.heart;
proc freq  data=heart;
table sex status smoking ;
run;

*cosstab;
proc freq  data=heart;
table sex*status/ nocum list;
run;
