*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to address several research
questions if the water taste test is a far test based on some criteria

Dataset Name: lunsford_analytic_file created in external file
STAT6250-01_w17-team-8_project2_data_preparation.sas, which is assumed to be
in the same directory as this file
See included file for dataset properties
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
"Research Question: What is average favor drinking water pH level of the students for the test for female and male respectively?"
;

title2
"Rationale: If the research finds that the pH level is about 7 for both female and male group, we can assume that the test is the fair test so that the test is somehow reasonable."
;

footnote1
"We can find that the average pH level for female is 5.88, where pH level for male is 6.05."
;

footnote2
"The ideal pH average result should be about 7, so we can tell that the test group are not fairly selected."
;

footnote3
"Further more, the test group profile is skewed where the testers have 102 female and 22 male, further investigation should be performed for the skewed profile and bias group selection."
;

*
Note: This compares the column "FavBotWatBrand" from the dataset of lunsford and 
to the column "Brand" from Water_PH_Dataset.

Methodology: 

When combining lunsford with Water_PH_Dataset during data preparation, the 
Match-merging jointed these two dataset by the FavBotWatBrand, so the pH info 
will be avaible in the now joined table.  We will get the average values from 
the variable pH.  If the value is 7 +/- 0.5 range, we can say the test is fair,
otherwise, we can assume the test is bias.  
;

proc means 
        mean
        data=lunsford_analytic_file 
    ;
	class Gender;
        var pH;
	where pH is not missing;
    output out=lunsford_analytic_file_temp;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;


title1
"Research Question: Which is drinking water type distribution for the students?  Alkaline, Acidic or Regular."
;

title2
"Rationale: We want to test if the group of students is fairly select, that is, each group should have about the same members, where they prefer Alkaline, Acidic or Regular."
;

footnote1
"The result shows that 53 testers favor Acidic water,  16 testers favor Alkaline water and 55 testers favor Regular water."
;

footnote2
"The ideal testers for each group should be the value between 38 and 43, so we can tell the selection of the tested is bias."
;

footnote3
"Further analysis should focus on why the tester group has the trend of favoring the Acidic water. Is it related to the geographic location?"
;

*
Note: This compares the column "FavBotWatBrand" from the dataset of lunsford and 
to the column "Brand" from Water_PH_Dataset.

Methodology: 

When combining lunsford with Water_PH_Dataset during data preparation, the 
Match-merging jointed these two dataset by the FavBotWatBrand, so the Water_Type
info will be avaible in the now joined table.  We will use proc freq for the 
variable Water_Type, if the freq is about the same as of three water type, we 
can say the test is fair, otherwise, we can assume the test is bias. 
;


proc freq data= lunsford_analytic_file;
    table Water_Type;
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question: What is the tester profile if the pH values are not documented?"
;

title2
"Rationale:  We want to know the full profile for the students who participate the test?"
;

footnote1
"The SAS shows that 67 testers do not favor a certain bottled water brand, 12 testers favor the bottled water from Sam's Club.  We also have one instance likes the water purchased from store, and one instance like the PAREE water brand."
;

footnote2
"The ideal tester counts which are qualified for the missing pH values should be limited to the same amount of the testers who favor Alkaline, Acidic or Regular."
;

footnote3
"Further more, we should take a look why 12 testers favor the bottled water from Sam's Club.  Is there a Sam's Club closing to the university?"
;

*
Note: This compares the column "FavBotWatBrand" from the dataset of lunsford and 
to the column "Brand" from Water_PH_Dataset.

Methodology: 

When combining lunsford with Water_PH_Dataset during data preparation, the 
Match-merging jointed these two dataset by the FavBotWatBrand, so the Water_Type
info will be avaible in the now joined table.  We will use proc freq for the 
variable Water_Type for the condition where the pH value are not documented.
;

proc freq data= lunsford_analytic_file;
    table FavBotWatBrand;
	Where pH is missing;
run;

title;
footnote;
