data shoes ;
set sashelp.shoes;
Netsales = Sales - Returns ;
run;

Proc means data= shoes mean sum ;
var Netsales ;class region;
run;


%let path '/home/u63348281/Essential_Training';
libname Essen &path;
libname Essen clear ;


libname NP xlsx '/home/u63348281/Essential_Training/Data/np_info.xlsx';
options validvarname=v7;
proc print data=np.parks;run;
proc contents data=np.parks ;
run;
libname np clear ;

/* import txt file */
proc import datafile='/home/u63348281/Essential_Training/Data/storm_damage.tab'
dbms= tab out = strom_damage replace ;
run;

proc import datafile='/home/u63348281/Essential_Training/Data/eu_sport_trade.xlsx'
dbms=xlsx out= eu_sport_trade replace ;
run;

%let path '/home/u63348281/Essential_Training/Data/np_traffic.csv';
proc import datafile= &path dbms=csv out=traffic replace;
guessingrows=max ;
run;
proc print data=traffic (firstobs=37 obs=37) ;
run;

/* import text file */
proc import datafile='/home/u63348281/Essential_Training/Data/np_traffic.dat'
dbms=dlm
out=traffic replace;
delimiter='|';
guessingrows= max ;
run;

/* library */
libname Essen'/home/u63348281/Essential_Training/Data';
proc print data=Essen.np_summary ;
var  Reg Type ParkName DayVisits TentCampers RVCampers ;
run;
proc means data=Essen.np_summary ;
var DayVisits TentCampers RVCampers ;
run;
proc univariate data=Essen.np_summary ;
var DayVisits TentCampers RVCampers ;
run;
proc freq data=Essen.np_summary ;
tables  Reg Type;
run;

proc univariate data=Essen.np_summary ;
var Acres ;
run; 
proc print data=essen.np_summary(obs=6 firstobs=6);
run;
proc print data=essen.np_summary(obs=78 firstobs=78);
run;

proc univariate data=Essen.eu_occ ;
var camp ;
run; 

ods trace on;
proc univariate data=essen.eu_occ;
var camp;
run;
ods trace off;

ods select missingvalues ;
proc univariate data=essen.eu_occ;
var camp;
run;

ods select extremeobs;
proc univariate data=essen.eu_occ nextrobs=10;
var camp;
run;

proc print data=essen.storm_summary(obs=50);
	where missing( MinPressure ); /*same as MinPressure = .*/
	where Type is not missing; /*same as Type ne " "*/
	where MaxWindMPH between 150 and 155;
	where Basin like "_I";
run;

/* Filter */
%let basincode = 'SP';
proc means data=essen.storm_summary ;
where Basin= &basincode;
var  MinPressure MaxWindMPH ;
run;

proc freq data=essen.storm_summary ;
where Basin= &basincode;
tables type ;
run;

proc print data= essen.np_summary ;
where parkname like '%Preserve%';
var ParkName Type;
run;

proc print data=essen.eu_occ;
where missing( Hotel) & missing(ShortStay) & missing(Camp);
run;
proc print data=essen.eu_occ;
where Hotel > 40000000;
run;
options obs= 5 ;
proc freq data=essen.storm_summary;
tables startdate ;
run;
proc freq data=essen.storm_summary  order=freq;
tables startdate ;
run;
proc freq data=essen.storm_summary  order=data ;
tables startdate ;
run;
proc freq data=essen.storm_summary  order=data ;
tables startdate ;
format Startdate MONNAME12.;
run;
proc freq data=essen.storm_summary  order=data ;
tables startdate ;
format Startdate WeekDate.;
run;

proc sort data=essen.storm_summary out = sort ;
where Basin in('NA' ,'na');
by   MaxWindMPH ;
run;
proc print data=sort ;
var  Basin MaxWindMPH ;
run;

proc sort data=essen.np_largeparks out = clean
nodupkey dupout=duppp ;
by _ALL_;
run;

proc sort data= essen.eu_occ(keep=Geo country) 
out=eu(keep=Geo country) 
nodupkey dupout=occ ;
by geo ;
run;

data storm_cat5 ;
set essen.storm_summary ;
where (MaxWindMPH ge 156) and 
(startdate ge '01JAN2000'd) ;
keep  Season Basin Type Name MaxWindMPH ;
run;

data eu ;
set essen.eu_occ ;
where YearMon like '2016%';
format Hotel Shortstay camp COMMA17.;
drop Geo;
run;

data fox ;
set essen.np_species ;
where ( Category = 'Mammal'and  lowcase(Common_Names)  like '%fox%') and lowcase(common_names) not like '%squirrel%';
drop  Category Nativeness Record_Status Occurrence ;
run;
proc sort data= Fox ;
by Common_Names ;
run;

data Mammal;
set essen.np_species;
where lowcase(category)='mammal';
drop  Abundance Seasonality Conservation_Status ;
run;
proc freq data= mammal ;
tables Record_status;run;

%let ma = bird;
data bird;
set essen.np_species;
where lowcase(category)="&ma";
drop  Abundance Seasonality Conservation_Status ;
run;
proc freq data= bird ;
tables Record_status;run;

data strom ;
set essen.storm_summary ;
drop Hem_EW Hem_NS Lat Lon;
stromlen = -(startdate - enddate )+1;
run;
proc print data=strom ;
where season=1980 and upcase(name)='AGATHA';
run;

data s;
set essen.storm_range;
windavg= mean(of  Wind1 Wind2 Wind3 Wind4);
windrange=range(of Wind1-Wind4);
run;
proc print data=s (obs=1);
var windavg windrange ;
run;

data ab;
string = "This is a sentence";
Letter = UPCASE(substr(scan(string, 4," ") ,4 ,1));
run;

data P;
set essen.storm_summary ;
where substr(Basin ,2,1)='P';
run;

data upd ;
set essen.np_summary;
SqMiles = Acres* 0.0015625 ;
camping = sum(of  OtherCamping RVCampers BackcountryCampers TentCampers);
format SqMiles COMMA6. Camping COMMA10.;
keep  ParkName SqMiles Camping ;
run;
proc print data= upd(keep=ParkName SqMiles Camping) ;
where ParkName = 'Cape Krusenstern National Monument';
run;

data scan ;
set essen.np_summary;
ParkType = scan(ParkName ,-1," ");
keep Reg ParkName Type ParkType ;
run;

proc print data=scan(firstobs=4 obs=4);
var ParkType ;
run ;

data eww ;
set essen.eu_occ ;
year =substr(YearMon ,1,4);
Month =substr(YearMon ,6,2);
Reportdate = MDY(Month ,1,year);
Total=sum( ShortStay, Camp, Hotel);
format Hotel Camp ShortStay Total comma17. Reportdate monyy7. ;
country= substr(upcase(country),1,3);
drop  Geo Year Month YearMon;
run;
proc print data=eww (obs=5);
run;

data condition;
set essen.storm_summary ;
if Missing(Minpressure) then pressuregrp = '.';
else if  Minpressure < = 920 then Pressuregrp = 1;
else pressuregrp = 0;
run;
proc print data=condition (keep= Minpressure  pressuregrp);
run;
proc freq data= condition ;
tables pressuregrp ;
run;

data sss ;
set essen.storm_summary;
length Ocean $ 9. ;
Basin = upcase(Basin);
Oceancode = substr(Basin,2,1);
if Oceancode = 'I' then Ocean='India';
else if Oceancode ='A' then ocean ='Atlantic';
else ocean= 'Pacific' ;
run ;
proc print data= sss;run;
proc freq data= sss;
tables Ocean ;
run;

data u40 o40 ;
set sashelp.cars ;
if MSRP < 20000 then do ;
cost_grp =1;
output u40 ;
end;
else if MSRP < 40000 then do;
cost_grp =2 ;
output u40 ;
end;
else do ;
cost_grp =3 ;
output o40 ;
end;
run;

data np;
set essen.np_summary;
if Type = 'NM' then ParkType ='Monument';
Else if Type = 'NP' then ParkType ='Park';
Else if Type in('PRE' , 'PRESERVE','NPRE') then ParkType ='Preserve';
Else if Type = 'NS' then ParkType ='Seashore';
Else if Type in('RVR' , 'RIVERWAYS') then ParkType ='River';
run;

proc freq data= np;
tables ParkType Type;
run;

/* IF Else */
data Park mon ;
set essen.np_summary;
length ParkType $ 9. ;
format campers comma6. ;
campers = sum( BackcountryCampers, OtherCamping ,RVCampers, TentCampers) ;
keep Reg ParkName DayVisits OtherLodging Campers ParkType;
if TYpe ='NP' then do;
ParkType = 'Park';
output park ;
end;
if Type = 'NM' then do;
parktype = 'Monuments';
output mon ;
end;
run;
proc print data=park ;
proc print data= mon;
run;

/* when do */
data Park mon ;
set essen.np_summary;
Where type in ('NP','NM');
length ParkType $ 9. ;
format campers comma6. ;
campers = sum( BackcountryCampers, OtherCamping ,RVCampers, TentCampers) ;
keep Reg ParkName DayVisits OtherLodging Campers ParkType;
select(Type);
	when ('NP') do ;
	parktype ='Park';
	output park ;
	end;
	otherwise do;
	parktype = 'mon';
	output mon ;
	end;
end;
run;

data car_type;
    set sashelp.cars;
    if msrp>80000 then car_type="luxury";
    else car_type="regular";
    length car_type $ 8;
run;

title "Storm Analysis";


proc means data=essen.storm_final;
	var MaxWindMPH MinPressure;
run;
title ;
title2 'dhsj';
proc freq data=essen.storm_final;
	tables BasinName;
run;
title ;

data cars_update;
    set sashelp.cars;
	keep Make Model MSRP Invoice AvgMPG;
	AvgMPG=mean(MPG_Highway, MPG_City);
	label MSRP="Manufacturer Suggested Retail Price"
          AvgMPG="Average Miles per Gallon"
          Invoice ="Invoice Price";
run;
proc means data=cars_update min mean max;
    var MSRP Invoice;
run;

proc print data=cars_update label ;
    var Make Model MSRP Invoice AvgMPG;
run;

ods graphics on ;
ods noproctitle ;
proc freq data=essen.storm_final order=freq ;
tables startdate / plots=freqplot ;
format startdate monname.; 
run;

proc freq data= essen.np_species order= freq;
tables category / nocum;
run;

ods graphics on;
ods noproctitle ;
proc freq data=essen.np_species order=freq ;
tables category /nocum plots=freqplot ;
where (Species_ID like 'EVER%' )and (category ^= 'Vascular Plant');
run;

proc freq data=essen.np_codelookup nlevels order=freq;
tables type*region/nocol norow ;
where lowcase(type) ^= '%other%';
run;

proc means data=essen.np_westweather mean min max maxdec=2;
var PRECIP SNOW TEMPMIN TEMPMAX ;
class year Name;
run;

proc means data=essen.np_westweather mean min max maxdec=2;
where Precip ^= 0;
class  Name year;
output out = rainstat N=RainDays Sum=TotalRain ;
ways 2 ;
run;

title1 'Rain Statistics by Year and Park';
proc print data=rainstat label noobs;
    var Name Year RainDays TotalRain;
    label Name='Park Name'
          RainDays='Number of Days Raining'
          TotalRain='Total Rain Amount (inches)';
run;
title;

proc means data=essen.np_multiyr noprint ;
var visitors ;
class region year ;
ways 2 ;
output out= top3(drop=_FREQ_  _TYPE_) sum =TotalVisitors
idgroup (max(visitors) out[3] (Visitors Parkname) =)
;run;
proc print data= top3 ;
run;


















ods graphics on;
ods noproctitle ;
proc freq data=essen.np_codelookup nlevels order=freq;
tables type*region/
	 crosslist plots=freqplot (groupby=row Orient=Horizontal scale = percent ) ;
where Type in('National Historic Site','National Monument','National Park');
run;

title1 'Counts of Selected Park Types by Park Region';
proc sgplot data=essen.np_codelookup;
    where Type in ('National Historic Site', 'National Monument', 'National Park');
    hbar region  / group=type;
    keylegend / opaque across=1 position=bottomright location=outside;
    xaxis grid;
    yaxis grid ;
run;


proc means data=essen.storm_final maxdec=0;
	var MinPressure;
	where Season >=2010;
	 class Season Ocean;
	 ways 1 ;
run;

proc means data=essen.storm_final mean median max;
	var MaxWindMPH;
	class BasinName;
	ways 1;
	output out= xlout.wind_stats mean=AvgWind max=MaxWind;
run;
proc print data=wind_stats;
run;

%let output = /home/u63348281/Essential_Training/Output_File;
libname lib " &output ";
proc export data=essen.storm_final outfile= "&output/strom.csv"
dbms= csv replace ;
run;

libname xlout xlsx "&output/output_file.xlsx";

ods excel file= "&output/stromfinal.xlsx" options(sheet_name='summary');
ods noproctitle;
proc means data=essen.storm_final mean min max median maxdec=0 ;
var Minpressure ;
class Basinname ;
run;
ods excel options(sheet_name = 'scatter Plot');
proc sgscatter data=essen.storm_summary ;
plot minpressure*maxwindmph ;
run;
ods excel close ;

proc template ;
list styles;
run;
ods powerpoint file= "&output/stromfinal.pptx" style = Pearl;
ods noproctitle;
proc means data=essen.storm_final mean min max median maxdec=0 ;
var Minpressure ;
class Basinname ;
run;

proc sgscatter data=essen.storm_summary ;
plot minpressure*maxwindmph ;
run;
ods powerpoint close ;

ods Rtf file= "&output/stromfinal.rtf" style = Pearl  startpage=no;
ods noproctitle;
proc means data=essen.storm_final mean min max median maxdec=0 ;
var Minpressure ;
class Basinname ;
run;

proc sgscatter data=essen.storm_summary ;
plot minpressure*maxwindmph ;
run;
ods rtf close ;


ods pdf file= "&output/stromfinal.pdf" style = journal  startpage=no pdftoc=2;
ods noproctitle;
ods proclabel "means" ;
proc means data=essen.storm_final mean min max median maxdec=0 ;
var Minpressure ;
class Basinname ;
run;
ods proclabel "scatter plot" ;
proc sgscatter data=essen.storm_summary ;
plot minpressure*maxwindmph ;
run;
ods pdf close ;

ods pdf file="&output/StormSummary.PDF" style=Journal nobookmarkgen;

title1 "2016 Northern Atlantic Storms";

proc sgmap plotdata=essen.storm_final;
    *openstreetmap;
    esrimap url='http://services.arcgisonline.com/arcgis/rest/services/World_Physical_Map';
    bubble x=lon y=lat size=maxwindmph / datalabel=name datalabelattrs=(color=red size=8);
    where Basin='NA' and Season=2016;
    keylegend 'wind';
run;

proc print data=essen.storm_final noobs;
    var name StartDate MaxWindMPH StormLength;
    where Basin="NA" and Season=2016;
    format StartDate monyy7.;
run;

ods pdf close;

  ods excel file="&output/class.xlsx";
   proc print data=sashelp.class;
   run;
   ods excel close;
   
data strom_damage;
set essen.storm_damage ;
proc sql ;
select cost format = comma18. , year(date) as season ,event from essen.storm_damage
where cost > 25000000000
order by cost desc;
run;

proc sql; 
select  Season, Name, storm_summary.Basin,  MaxWindMPH, BasinName
from essen.storm_summary as A inner join essen.storm_basincodes as B
on A.Basin =B.Basin 
order by Season desc;
run;

proc sort data=essen.storm_summary out= summary;
by Basin;
run;
proc sort data=essen.storm_basincodes out= codes;
by Basin;
run;
data iner_;
merge summary(in =A) codes(in=B);
by Basin;
if A and B ;
run;





