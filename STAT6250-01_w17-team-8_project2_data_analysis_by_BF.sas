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
*
Question: What is average favor drinking water PH level of the students for the 
test? 

Rationale: If the research finds that the PH level is about 7, we can assume 
that the test is the fair test so that the test is somehow reasonable.

Note: This compares the column "FavBotWatBrand” from the dataset of lunsford and 
to the column “Brand” from Water_PH_Dataset.

Methodology: 

When combining lunsford with Water_PH_Dataset during data preparation, the 
Match-merging jointed these two dataset by the FavBotWatBrand, so the PH info 
will be avaible in the now joined table.  We will get the average values from 
the variable PH.  If the value is 7 +/- 0.5 range, we can say the test is fair;
otherwise, we can assume the test is bias.  

proc means data=lunsford_analytic_file mean;
    var PH;
    If PH >7.5 or PH < 6.5
        then text = 'water taste test is not a fair test';
    Else
        text = 'water taste test is a fair test';
run;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Which drinking water type is the most for the students during the 
test?  Alkaline, Acidic or Regular.

Rationale: Rationale: We want to test if the group of students is fairly select, 
that is, each group should have about the same members, where they prefer 
Alkaline, Acidic or Regular.

Note: This compares the column "FavBotWatBrand” from the dataset of lunsford and 
to the column “Brand” from Water_PH_Dataset.

Methodology: 

When combining lunsford with Water_PH_Dataset during data preparation, the 
Match-merging jointed these two dataset by the FavBotWatBrand, so the Water_Type
info will be avaible in the now joined table.  We will use proc freq for the 
variable Water_Type, if the freq is about the same as of three water type, we 
can say the test is fair; otherwise, we can assume the test is bias. 

proc freq data= lunsford_analytic_file;
    table Water_Type;
    If Percent of Water_Type in (Alkaline) > 28 and 
       Percent of Water_Type in (Alkaline) > 38 and 
       Percent of Water_Type in (Acidic) < 28 and 
       Percent of Water_Type in (Acidic) > 38 and 
       Percent of Water_Type in (Regular) < 28 and 
       Percent of Water_Type in (Regular) > 38 
        then text = 'water taste test is not a fair test';
    Else
        text = 'water taste test is a fair test';
run;

*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
Question: Which drinking water is the most used for the student?  Tap Water, 
Spring Water, or Distilled Water etc. 

Rationale:  We want to know if the students for the test are diversified, that 
is, some of them like tap water, some like Spring Water, etc. so we can think 
the test is a fair test.

Methodology: 

When combining lunsford with Water_PH_Dataset during data preparation, the 
Match-merging jointed these two dataset by the FavBotWatBrand, so the 
Water_Type_2 info will be avaible in the now joined table.  We will use proc 
freq for the variable Water_Type_2, if the freq is about the same as of 
water types, we can say the test is fair; otherwise, we can assume the test is 
bias. 

proc freq data= lunsford_analytic_file;
    table Water_Type_2;
    If Percent of Water_Type in (Tap Water) > 23 and 
       Percent of Water_Type in (Tap Water) > 43 and 
       Percent of Water_Type in (Spring Water) < 23 and 
       Percent of Water_Type in (Spring Water) > 43 and 
       Percent of Water_Type in (Purifed Water) < 23 and 
       Percent of Water_Type in (Purifed Water) > 43 
        then text = 'water taste test is not a fair test';
    Else
        text = 'water taste test is a fair test';
run;






