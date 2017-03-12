*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to test several research
questions about water taste. 

Dataset Name: lunsford_analytic_file created in external file
STAT6250-01_w17-team-8_project2_data_preparation.sas, which is assumed to be
in the same directory
See included file for dataset propertiess
;

* environmental setup;
%let dataPrepFileName = STAT6250-01_w17-team-8_project2_data_preparation.sas;
%let sasUEFilePrefix = team-8_project2;


* load external file that generates analytic dataset
lunsford_analytic_file using a system path dependent on the host
operating system, after setting the relative file import path to the current
directory, if using Windows;
%macro setup;
    %if
        &SYSSCP. = WIN
    %then
        %do;
            X
            "cd ""%substr(%sysget(SAS_EXECFILEPATH),1,%eval(%length(%sysget(SAS_EXECFILEPATH))-%length(%sysget(SAS_EXECFILENAME))))"""
            ;           
            %include ".\&dataPrepFileName.";
        %end;
    %else
        %do;
            %include "~/&sasUEFilePrefix./&dataPrepFileName.";
        %end;
%mend;
%setup


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question 1: What is the most favorite brand overall?"
;
title2
"Rationale:This question is useful to see which brand has best taste for people?"

;
footnote1 
"According to the analysis Non of them has a most frequency"
;
footnote2
"Future analysis will show can show the taste by geographic"
;
footnote3
"However the age may affect the result"
;
*
Note:
This will get information from the column "FavBotWatBrand” from the dataset
of lunsford and lunsford2.
Methodology: 
Largest No. of frequency will show the most favourite brand 
;

proc freq order=freq data=lunsford_combined_sorted;
   tables FavBotWatBrand ;
   label FavBotWatBrand="Favorite Bottle Water Brand";
run;    
title;
footnote;



*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1
"Research Question 2: What is the most favorite brand for female & male?"
;
title2
"Rationale:This question is showing difference between female& male preference"
;
footnote1
"Aquafina is a favorite brand and Followed by Fiji for both gender. 5.85 % differance for female and 1.95% for male"
;
footnote2
"As we can see most attendence was from female so need to separate the favourite men taste as well"
;
footnote3
"Next analysis can show if the second favourite taste for women and men are close or not"
;
*
Note: This compares the column "FavBotWatBrand” from the dataset of lunsford & 
to the column “Gender” from lunsford and lunsford2.
Methodology: 
Proc Freq will help me to see the ratio of barnds and with crosslist I can 
combine it to the  gender, with this code I can even compare the preferance
base on the gender and the difference may show the difference taste for men 
and women so I will compare the second fav. in next question.
;
proc format First;
    value $First_fmt
    'A'='Aquafina'
    'B'='Deer Park'
    'C'='Paree'
    'D'='Dasani'
    'F'='Fiji'
    'S'='Sam'
    ;
   run;
proc freq data=lunsford_combined_sorted;
   tables Gender*First/ crosslist;
   format First $First_fmt.;
run;

title;
footnote;




*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
title1
"Research Question 3:what is the 2ndmost favorite brand for men?"
;
title2
"Rationale] This question can be compare to both above questions and we can see if second preference for men is match with 1st preference of women!"
;
footnote1
"Aquafina has a highest frequency for second preference ans followeed by s(sam's)(8.29% difference) for female and F(Fiji)(3.9% difference) for male"
;
footnote2
" However there is difference preference for two gender but they are close and it shows that their standards are close together."
;
footnote3
"Age factor and regional may affaect the result and should consider for next step analysis "
;
*
Note: This compares the column "FavBotWatBrand” from the dataset of lunsford & 
to the column “Gender” from lunsford and lunsford2.
Methodology: 
In this step I can combine the gender and second preference of favourite brand
and compare tow gender second preference. It may shows the differenace taste
base on gender if  second preference are differ.
;
proc format Second;
    value $Second_fmt
    'A'='Aquafina'
    'B'='Deer Park'
    'C'='Paree'
    'D'='Dasani'
    'F'='Fiji'
    'S'='Sam'
    ;
   run;
proc freq data=lunsford_combined_sorted;
   tables Gender*Second/ crosslist;
   format First $Second_fmt.;
run;
title;
footnote;
