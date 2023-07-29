Data Exam;
Input ID $ Test1 Test2 Final;
Datalines;
9000001 90 87 66
9000002 66 89 98
9000003 20 45 73
9000004 75 74 100
9000005 44 85 76
9000006 71 82 89
9000007 82 83 88
9000008 68 71 54
9000009 36 48 46
9000010 71 73 98
;
Run;
Data Total Topper;
set Exam ;
final_score = 0.5*(max(Test1,Test2)) +0.5*Final ;
Final_avg_score =0.5*(mean(Test1 ,Test2)) + 0.5*Final;
if final_score >= 85 then output Topper ; else output Total ;
run;
/* ---------------------------------------------------------------------------------------- */
Data MathExam;
infile datalines dsd;
input Comment $40.;
datalines;
Mary's exam result is 89
Jonathan's exam result is 77
Ann's exam result is 97
Christopher's exam result is 68
Peter's exam result is 90
Jeev's exam result is 55
Tina's exam result is 86
Porter's exam result is 91
MaryAnn's exam result is 69
Tim's exam result is 72
;
Run;
Data MathExam2;
Set MathExam;
Result= input(scan(comment ,-1),2.) ;
Run;
proc contents data=MathExam ;run;
proc print data=mathexam;run;
/* ------------------------------------------------------------------------------------------ */
Data Transac;
Input Order $ Date Time Total;
Datalines;
BA00001 19000 40143 1432
BA00002 19000 51865 1455
BA00003 19000 68954 2435
BA00004 19000 49865 894
BA00005 19000 53214 1745
BA00006 19000 64521 997
BA00007 19000 74521 562
BA00008 19000 56321 132
BA00009 19000 51236 987
BA00010 19000 45698 562
;
Run;
/* Total(After tax) = Total(Before tax) x 14.75% */
Data Transaction;
set Transac;
format Date date9. Time time8. Total_After_Tax 6.2 total2 dollar9.2;
Total_After_Tax = Total*1.1475 ;
Total1= Total*0.1475;
Total2 = total*1.1475;
run;
proc print data=Transaction ;
run;
/* ------------------------------------------------------------------------------------------- */
Data Drinks;
Infile Datalines dsd;
Input Type $ Name:$50. Calories Fat;
Datalines;
Cold,Caramel Frappuccino® Light Blended Beverage,100,0
Cold,Coffee Frappuccino® Blended Beverage,180,2.5
Cold,Teavana® Shaken Iced Passion Tango™ Tea,0,0
Cold,Shaken Tazo® Iced Black Tea Lemonade,100,0
Cold,Nonfat Iced Vanilla Latte,120,0
Cold,Nonfat Iced Caramel Macchiato,140,1
Cold,Iced Coffee (with classic syrup),60,0
Cold,Iced Skinny Latte,70,0
Hot,Brewed Coffee,5,0
Hot,Brewed Tea,0,0
Hot,Nonfat Green Tea Latte,210,0
Hot,Nonfat Cappuccino,60,0
Hot,Nonfat Caffè Latte,100,0
Hot,Nonfat Caramel Macchiato,140,1
Hot,Soy Chai Tea Latte,180,2
Hot,Nonfat Caffè Mocha – hold the whip,170,2
Hot,Skinny Vanilla Latte,100,0
Hot,Steamed Apple Juice,170,0
Hot,Caffè Americano,10,0
;
Run;
proc sort data=Drinks out=Sort_Drinks;
by descending Fat Type;
run; 

data Drink_info;
set Sort_Drinks ;
format drink $10.;
/* if Name_ like '%CO'  then drink ='Coffee'; */
if index(upcase(Name),'FF') then drink = 'Coffee';
else if  index(upcase(Name),'TEA') then drink ='Tea';
Else drink ='Bevrages';
run;
proc print data= Drink_info ;
run;
/* -------------------------------------------------------------------------------------------------- */
Data car;
set sashelp.cars;
proc sort data= car out=sort_car;
By Make ;
run;
proc means data=sort_car max min noprint ;
var Horsepower ;
by make;
output Out= Most_least min=Minimum max=Maximum;
run;
proc print data= most_least(drop= _FREQ_ _TYPE_);
run;

proc sql;
select Make, Max(Horsepower) as maximum ,min(Horsepower) as minimum from sashelp.cars 
group by Make;
run;
/* ------------------------------------------------------------------------------------------------- */
Data Inventory;
Infile datalines dsd;
Input Product : $30. Store : $10. Qty;
Datalines;
Billy's Bookshelf,Store 1, 150
Billy's Bookshelf,Store 2, 200
Billy's Bookshelf,Store 3, 230
Billy's Bookshelf,Store 4, 160
Billy's Bookshelf,Store 5, 180
Billy's Bookshelf,Store 6, 220
Billy's Bookshelf,Store 7, 130
Billy's Bookshelf,Store 8, 450
Billy's Bookshelf,Store 9, 260
Billy's Bookshelf,Store 10, 300
;
Run;
Data In_Store ;
set Inventory ;
retain Invent 1500
Total = sum(QTY, invent);
run;
proc print data=In_Store;
sum Total;
run;
/* ----------------------------------------------------------------------------------------------- */
Data Demo;
Input Index $ Age Income;
Datalines;
ID5001 28 56000
ID5002 42 60000
ID5003 34 35000
ID5004 35 44000
ID5005 60 87500
ID5006 44 69000
ID5007 18 45000
ID5008 22 54000
ID5009 47 46000
ID5010 36 73000
;
Run;
proc univariate data=Demo normaltest;
histogram/normal;
var Income ;
run;
/* ---------------------------------------------------------------------------------------------------- */
Data Num;
Input RNumber;
Datalines;
56
78
44
33
59
89
105
85
45
66
;
Run;
proc means data=Num mean std;
run;
data Number;
set Num ;
z=(RNumber-66.0000000)/22.8958997;
run;
/* -------------------------------------------------------------------------------------------------- */
data records;
input ID $ homework midterm final;
datalines;
ID0001 16 15 46
ID0002 19 23 42
ID0003 19 . 50
ID0004 22 20 49
ID0005 19 23 41
ID0006 19 17 .
ID0007 24 25 42
ID0008 17 23 37
ID0009 25 25 42
ID0010 . 25 42
;
Run;
data total;
set records;
final_score = sum(homework + midterm + final);
array t(*) _numeric_;
do i= 1 to dim(t);
if missing(t(i)) then t(i)=0;
end;
run;
/* ------------------------------------------------------------------------------------------------------------ */



















