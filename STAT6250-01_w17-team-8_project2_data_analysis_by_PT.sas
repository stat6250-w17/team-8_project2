*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

*
This file uses the following analytic dataset to test several research
questions about water taste. 
Dataset Name: lunsford_analytic_file created in external file
STAT6250-01_w17-team-8_project2_data_preparation.sas, which is assumed to be
in the same directory as this file (sheet2)
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
*
[Research Question 1] What is the most favorite brand overall?
[Rationale] This question is useful to see which brand has better taste for people?
Note: This will get information from  the column "FavBotWatBrand” from the dataset
of lunsford.
Methodology: 
Largest No. of frequency will show the most 

proc freq data=lunsford_analytic_file;
   tables FavBotWatBrand ;
run;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
[Research Question 2] What is the most favorite brand for female?
[Rationale] This question is showing the difference between female and male preference
Note: This compares the column "FavBotWatBrand” from the dataset of lunsford and 
to the column “Gender” from lunsford.
Methodology: 



*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
[Research Question 3] what is the most favorite brand for men?
[Rationale] This question can be compare to both above questions and we can see 
if second preference for men is match with 1st preference of women!

Methodology: 
