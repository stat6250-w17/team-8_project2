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
"Research Question: What is the average favor drinking water pH level of the students for the test for female and male respectively?"
;

title2
"Rationale: If the research finds that the pH level is about 7 for both male and female group, we can assume that the test is the fair test so that the test is somehow reasonable."
;

title3
"Table of pH Level"
;

footnote1
"We can find that the average pH level for male is 6.05, where pH level for female is 5.88." 
;

footnote2
"The ideal pH average result should be about 7, so we can tell that the test groups are not fairly selected."
;

footnote3
"Furthermore, the test group profile is skewed where the testers have 102 female and 22 male, further investigation should be performed for the skewed profile and the bias group selection."
;

*
Note: This compares the column "FavBotWatBrand" from the dataset of lunsford 
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
    noprint
        data=lunsford_analytic_file maxdec=2
    ;
    class Gender;
    var pH;
    where pH is not missing;
    output out=lunsford_analytic_file_temp;
run;

proc sort 
        data=lunsford_analytic_file_temp(where=(_STAT_="MEAN"))
    ;
    by descending pH;
run;

proc print
        data=lunsford_analytic_file_temp label
    ;
    id Gender _FREQ_ ;
    var pH;
    format pH 4.2;
    where Gender is not Null;
    label _FREQ_ = 'Frequency';
run;


title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;


title1
"Research Question: What is the drinking water type distribution for the students?  Acidic, Alkaline and Regular."
;

title2
"Rationale: We want to know if the group of students is fairly selected, that is, each group should have about the same members, where they should prefer Alkaline, Acidic or Regular quite equally."
;

footnote1
"The result shows that 53 testers favor Acidic water,  16 testers favor Alkaline water and 55 testers favor Regular water."
;

footnote2
"The ideal testers for each group should be about the same, that is, each group member might be selected as 41 with 5% difference."  
;

footnote3
"From the result, we can tell the selection of the testers is bias, for example, the difference is 39 between Regular and Alkaline."
;

footnote4
"Further analysis should be focused on why the tester group has the trend of favoring the Acidic water. Is it related to the geographic location?"
;

*
Note: This compares the column "FavBotWatBrand" from the dataset of lunsford 
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
    label Water_Type = "Water Type";
run;

title;
footnote;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1
"Research Question: What are the tester profiles if the pH values are not identified regarding their drinking water?"
;

title2
"Rationale:  We want to know the full profile for the students who participate the test."
;

footnote1
"The report shows that 67 testers do not favor certain bottled water brand, 12 testers favor the bottled water from Sam's Club.  We also have one instance from the testers likes the water purchased from store, and one instance likes the PAREE water brand."
;

footnote2
"The count of ideal testers which are qualified for the missing pH values should be limited to the same amount of the testers who favor Alkaline, Acidic or Regular."
;

footnote3
"Furthermore, we should take a closer look why 12 testers favor the bottled water from Sam's Club.  Is there a Sam's Club closer to the university?"
;

*
Note: This compares the column "FavBotWatBrand" from the dataset of lunsford  
to the column "Brand" from Water_PH_Dataset.

Methodology: 

When combining lunsford with Water_PH_Dataset during data preparation, the 
Match-merging jointed these two dataset by the FavBotWatBrand, so the Water_Type
info will be avaible in the now joined table.  We will use proc freq for the 
variable Water_Type for the condition where the pH value are not documented.
;

proc freq data= lunsford_analytic_file order=freq;
    table FavBotWatBrand;
    label FavBotWatBrand="Favorite Bottled Water Brand";
    where pH is missing;
run;

title;
footnote;
