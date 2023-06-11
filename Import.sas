* Importing an Excel File with an XLSX Extension ;
proc import datafile='/home/u63348281/2023/PowerBIData.xlsx' out=actual 
		dbms=XLSX replace;
	sheet=Actual;
run;
proc contents data=actual varnum;
run;
proc print data=actual;
run;

proc import datafile='/home/u63348281/2023/PowerBIData.xlsx' out=actual 
		dbms=XLSX replace;
	sheet=Actual;
	getnames=No;
run;
proc contents data=actual varnum;
run;
proc print data=actual;
run;

*Importing a Comma-Delimited File with a CSV Extension;

proc import datafile='/home/u63348281/2023/50_Startups.csv' out=startup 
		dbms=csv;
run;
proc contents data=startup varnum;
run;
proc print data=startup;
run;

*Importing a Tab-Delimited File ;
proc import datafile='/home/u63348281/2023/student.txt' out=student_cgpa 
		dbms=tab replace;
	delimiter='09'x;
run;
proc contents data=student_cgpa;
run;
proc print data=student_cgpa;
run;

*importing a Delimited File with a TXT Extension ;
proc import datafile='/home/u63348281/2023/MILK,BREAD,BISCUIT.txt' out=basket 
		dbms=dlm replace;
	delimiter=',';
	getnames=no;
run;
proc print data=basket;
run;

* Using the SET Statement to Specify Imported Data ;
options obs= max ;
proc import datafile='/home/u63348281/2023/student.txt' out=student_cgpa 
		dbms=tab replace;
	delimiter='09'x;
run;
data cgpa_plcement ;
set student_cgpa ;
where cgpa > 8 and placement > 4 ;
proc print data=cgpa_placement;
run;

*Specifying DROP= and KEEP= Data Set Option;
proc import datafile='/home/u63348281/2023/50_Startups.csv'
out=startups
dbms=csv replace;
run;
data new_start(drop= Administration);
set startups(keep=Administration State Profit);
where Administration > 100000 and State = 'California';
run;
proc print data=new_start;
run;

*Reading Microsoft Excel Data with the XLSX 
Engine;
libname exl XLSX '/home/u63348281/2023.XLSX' ;
data exl.abc;
set sashelp.cars ;
run;
proc contents data=exl.abc ;
run;





