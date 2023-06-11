data report;
set sashelp.heart;

*Creating a Basic Report;
proc print data=report noobs;
var Status Sex Systolic Diastolic ;
id Status ;
Where( (Systolic >80 and Diastolic >150) and Sex='Female' ) and 
Status contains 'Dead';
run;

*Sorting Data ;
proc sort data=report out=sort_report;
by Status;
run;
options obs=5 ;
proc print data= sort_report;
var Status Sex Systolic Diastolic ;
run;

*Generating Column Totals;
data total;
set sashelp.baseball;

proc print data= total;
var Div Team nHits nRuns nHome nRBI nBB ;
where Team ='Cleveland';
sum nHits nRuns nHome nRBI nBB ;
run;

*/PAGEBY;
options obs=10;
proc sort data= total out= tre;
by Team ;
run;
proc print data= tre;
var Team nHits nRuns nHome nRBI nBB ;
by Team ;
pageby Team ;
run;

*Temporarily Assigning Labels to Variables;
title 'Temporarily Assigning Labels';
options obs=10;
proc print data= total label;
label nRuns = 'Number of runs'
	Team ='Team Name';
var Team nHits nRuns nHome nRBI nBB ;
run;
title;

*Using Permanently Assigned Labels;
title1 'Permanently Assigned Labels';
options obs=10;
data  new ;
set total;
label nRuns = ' Total Number of runs'
	Team ='Team Name';
run ;
proc print data= new label ;
var Team nHits nRuns nHome nRBI nBB ;
run;
title1;





