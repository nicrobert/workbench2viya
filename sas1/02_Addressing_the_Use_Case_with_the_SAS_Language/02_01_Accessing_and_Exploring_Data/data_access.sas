%global path ;

%if %quote(&path) ne %then %do ;
   %put NOTE: PATH variable = %quote(&path). ;
%end ;
%else %do ;
   %put NOTE: PATH variable empty. It will be set to a default value. ;
   %let path=/workspaces/churnproject/workbench2viya/sas1 ;
   %put NOTE: PATH variable = %quote(&path). ;
%end ;

proc import file="&path/data/input/subscriptions.csv" out=subscriptions dbms=csv replace ;
run ;

proc contents data=subscriptions varnum ;
run ;

proc print data=subscriptions ;
run ;

libname rev json "&path/data/input/reviews.json" ;
proc datasets lib=rev ;
quit ;

proc contents data=rev.reviews varnum ;
run ;

proc print data=rev.reviews(obs=10) ;
run ;

libname tcs "&path/data/input" ;
proc datasets lib=tcs ;
quit ;

proc contents data=tcs.techsupportevals varnum ;
run ;

proc print data=tcs.techsupportevals(obs=10) ;
run ;

proc means data=tcs.techsupportevals ;
run ;

proc freq data=tcs.techsupportevals ;
   tables techsupporteval / plots=freqplot() ;
run ;
