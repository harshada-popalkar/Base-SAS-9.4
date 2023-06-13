* Creating New variables ;
data sales_profit;
set sashelp.shoes (Keep= Region Product Sales Inventory Returns);
Total_sale =Sales-Returns ;
profit = Inventory - Total_sale;
Format Total_sale  profit dollar10.;
length Status  $ 6 ;
if profit < 0 then Status = "Loss";
else Status = 'Profit';
run;

*Print Data according To product Type and give the totoal sale;
proc sort data=sales_profit out = Product_details ;
by Region product ;
run ;
proc print data= product_details ;
id Product ;
by Region product ;
var  Inventory ; 
Sum Total_sale profit;
run;

proc means data= product_details ;
id Product ;
by Region product ;
var  Inventory Total_sale profit;
run;


proc sort data=sashelp.class out= class;
by Age ;
run ;

* Proc Transpose ;
proc transpose data= class out= trans prefix=student ;
var Sex Height Weight ;
by Age ;
run;
proc print data=trans noobs ;
id Age ;
by Age ;
run;


*use macro variables;
%Let height=60 ;
%Let weight =100;
%let Sex = 'F' ;
proc print data= sashelp.class;
where height > &height and weight > &weight and sex= &Sex ;
run;

* Use of retain and Delete ;
data rd;
set sashelp.class;
BMI = height/ (Weight*0.01);
retain B 5 ;
BMI = B +BMI ;
if( height > 60 and weight <120) then delete ;
proc print data= rd ;
var Age Height Weight BMI;
run;









