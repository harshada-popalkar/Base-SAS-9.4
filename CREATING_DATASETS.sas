data total_points (drop=TeamName);
	input TeamName $ ParticipantName $ Event1 Event2 Event3;
	TeamTotal + (Event1 + Event2 + Event3);
	datalines;
Knight's Sue    6  8  8
Cardinal's Jane 9  7  8
Knight's John   7  7  7
Cardinal's Lisa 8  9  9
Cardinal's Fran 7  6  6
Knight's Walter 9  8 10
;

proc print data=total_points;
	title 'Total Team Scores';
run;

data mydata;
	input id $ name $ age;
	datalines4;
12345 John Smith 25;
67890 Jane Doe 30;
;;;;

PROC PRINT DATA=mydata;
run;

data basket;
	infile datalines delimiter=',';
	input Milk $ Bread $ Biscuit $;
	datalines;
MILK,BREAD,BISCUIT
BREAD,MILK,BISCUIT
BREAD,TEA,BOURNVITA
JAM,MAGGI,BREAD
MAGGI,TEA,BISCUIT
BREAD,TEA,BOURNVITA
MAGGI,TEA,CORNFLAKES
MAGGI,BREAD,TEA
JAM,MAGGI,BREAD
COFFEE,COCK,BISCUIT
COFFEE,COCK,BISCUIT
COFFEE,SUGER,BOURNVITA
BREAD,COFFEE,COCK
BREAD,SUGER,BISCUIT
COFFEE,SUGER,CORNFLAKES
BREAD,SUGER,BOURNVITA
BREAD,COFFEE,SUGER
BREAD,COFFEE,SUGER
TEA,MILK,COFFEE
;

proc print data=basket;
run;

data new_data;
	input first_name $ last_name $ age Gender $ Birth_date :yymmdd10.;
	format Birth_date;
	datalines;
John Doe  30 Male 1993-03-08
Jane Doe   25  Female  1998-02-14
Bill Smith   40  Male  1983-05-02
Mary Jones 35 Female 1988-01-01
Peter Johnson   20  Male 2003-06-04
Sarah Brown   18  Female 2005-08-17
David Williams  32  Male  1991-09-23
Emily White   27  Female  1996-07-10
Michael Green  45  Male  1978-04-25
Jessica Black  42  Female 1981-03-12
Tom Brown  50  Male  1973-01-05
;
run;

proc print data=new_data;
	format Birth_date yymmdd10.;
run;

proc sql;
	select first_name|| '' || last_name as name , age, Gender , year(Birth_date)as 
		year , month(Birth_date)as month, day(Birth_date)as day from new_data where 
		age >20;
	run;

data a;
	infile '/home/u63348281/2023/MILK,BREAD,BISCUIT.txt' dlm=',';
	input A $ B $ C $;
run;