*q1;
data results.output04;
  set cert.input04;
  var3=round(var1,1)*round(var2,1);
  var20=sum(of var12-var19);
run;

proc print data=results.output04 (obs=16 firstobs=16);
  var var3 var20;
run;
*q2;
data results.output04;
  set cert.input04;
  var3=round(var1,1)*round(var2,1);
  var20=sum(of var12-var19);
run;

proc print data=results.output04 (obs=16 firstobs=16);  
  var var3 var20;
run;

*Q3
proc sort data=cert.input08a out=work.input08a;
  by ID;
run;

proc sort data=cert.input08b out=work.input08b;
  by ID;
run;

data results.match08 results.nomatch08 (drop=ex: );
  merge work.input08a (in=a) work.input08b (in=b);
  by ID;
  if a and b then output results.match08;
  else output results.nomatch08;
run;

proc contents data=results.match08;
run;

proc contents data=results.nomatch08;
run;

*q4;
proc sort data=cert.input08a out=work.input08a;
  by ID;
run;

proc sort data=cert.input08b out=work.input08b;
  by ID;
run;

data results.match08 results.nomatch08 (drop=ex: );
  merge work.input08a (in=a) work.input08b (in=b);
  by ID;
  if a and b then output results.match08;
  else output results.nomatch08;
run;

proc contents data=results.match08;
run;

proc contents data=results.nomatch08;
run;

*q5;
proc sort data=cert.input08a out=work.input08a;
  by ID;
run;

proc sort data=cert.input08b out=work.input08b;
  by ID;
run;

data results.match08 results.nomatch08 (drop=ex: );
  merge work.input08a (in=a) work.input08b (in=b);
  by ID;
  if a and b then output results.match08;
  else output results.nomatch08;
run;

proc contents data=results.match08;
run;

proc contents data=results.nomatch08;
run;

*q6;
proc
sort data=cert.input08a out=work.input08a;
  by ID;
run;

proc sort data=cert.input08b out=work.input08b;
  by ID;
run;

data results.match08 results.nomatch08 (drop=ex: );
  merge work.input08a (in=a) work.input08b (in=b);
  by ID;
  if a and b then output results.match08;
  else output results.nomatch08;
run;

proc contents data=results.match08;
run;

proc contents data=results.nomatch08;
run;

*q7;
data results.output12;
  set cert.input12;
  do until (salary gt 500000);
    salary=salary*1.0565;
    year+1;
    output;
  end;
run;

proc print data=results.output12;
run;

*q8;
data results.output13;
  set cert.input13;
  Chdate=put(date1,date9.);
  num1=input(Charnum,dollar7.);
run;

proc print data=results.output13 (firstobs=52 obs=52);
run;

*q9;
data results.output13;
  set cert.input13;
  Chdate=put(date1,date9.);
  num1=input(Charnum,dollar7.);
run;

proc means data=results.output13;
 var num1;
run;

*q10;
proc sort data=cert.input27
out=results.output27a(where=(upcase(country)='US'));
  by state descending Postal_Code employee_ID;
run;

proc print data=results.output27a (firstobs=100 obs=100);
  var employee_ID;
run;

*q11;
proc sort data=cert.input27 out=results.output27b nodupkey;
  by descending postal_code;
run;

proc print data=results.output27b (firstobs=98 obs=181);
  var employee_ID;
run;

*q12;
proc sort data=cert.input27 out=results.output27b nodupkey;
  by descending postal_code;
run;

proc print data=results.output27b (firstobs=98 obs=181);
  var employee_ID;
run;

*q13;
data work.cleandata36;
   set cert.input36;
   group=upcase(group);
   if group in ('A','B');
run;

proc means data=work.cleandata36 median;
  class group;
  var kilograms;
run;

data results.output36;
  set cleandata36;
  if Kilograms < 40 or Kilograms > 200 then do;
    if group='A' then kilograms=79;
    else kilograms=89;
  end;
run;

proc contents data=results.output36;
run;

*q14;
data work.cleandata36;
  set cert.input36;
  group=upcase(group);
  if group in ('A','B');
run;

proc means data=work.cleandata36 median;
class group;
var kilograms;
run;

data results.output36;
  set cleandata36;
  if Kilograms < 40 or Kilograms > 200 then do;
  if group='A' then kilograms=79;
  else kilograms=89; 
end;
run;

proc means data=results.output36 mean;
  class group;
  var kilograms;
run;

*q15;
data work.cleandata36;
  set cert.input36;
  group=upcase(group);
  if group in ('A','B');
run;

proc means data=work.cleandata36 median;
  class group;
  var kilograms;
run;

data results.output36;
  set cleandata36;
  if Kilograms < 40 or Kilograms > 200 then do;
  if group='A' then kilograms=79;
  else kilograms=89;
end;
run;

proc means data=results.output36 mean;
  class group;
  var kilograms;
run;

*q16;
data out;
  set cert.input44;
  length chol_status $ 15;
  drop bp_status
weight_status smoking_status;
  if cholesterol ne . then do;
    if cholesterol < 200 then chol_status='Safe';
    else if cholesterol <= 239 then chol_status='High-Borderline';
    else if cholesterol >= 240 then chol_status='High';
  end;
run;

proc contents data=out;
run;

proc freq data=out;
  table chol_status;
run;

*q17;
data out;
  set cert.input44;
  length chol_status $ 15;
  drop bp_status weight_status smoking_status;
  if cholesterol ne . then do;
    if cholesterol < 200 then chol_status='Safe';
    else if cholesterol <= 239 then chol_status='High-Borderline';
    else if cholesterol >= 240 then chol_status='High';
  end;
run;

proc contents data=out;
run;

proc freq data=out;
  table chol_status;
run;

*q18;
data out;
  set cert.input44;
  length chol_status $ 15;
  drop bp_status weight_status smoking_status;
  if cholesterol ne . then do;
    if cholesterol < 200 then chol_status='Safe';
    else if cholesterol <= 239 then chol_status='High-Borderline';
    else if cholesterol >= 240 then chol_status='High';
  end;
run;

proc contents data=out;
run;

proc freq data=out;
  table chol_status;
run;

*q19;
data groups;
  set cert.input48;
  if upcase(cvar) in ('A','B','C','D','E','F','G')
then group=1;
  else if upcase(cvar) in
('H','I','J','K','L','M','N') then group=2;
  else group=3;
  new_y=input(y,7.3);
*convert to numeric;
run;

/* Calculate the average of X and Y by Group */
/* What is the average of X and Y for Group 2? */

proc means data=groups mean
maxdec=2;
  where group = 2;
  class group;
  var x new_y;
run;

*q20;
data groups;
  set cert.input48;
  if upcase(cvar) in ('A','B','C','D','E','F','G')
then group=1;
  else if upcase(cvar) in
('H','I','J','K','L','M','N') then group=2;
  else group=3;
  new_y=input(y,7.3);
*convert to numeric;
run;

/* Calculate the average of X and Y by Group */
/* What is the average of X and Y for Group 2? */

proc means data=groups mean
maxdec=2;
  where group = 2;
  class group;
  var x new_y;
run;


