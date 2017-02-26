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
[Research Question 1] What is the average ORP level in water from each brand name containers used in deceptive water test experiment?
[Rationale] We can see how much attention the experiment makers paid to the ORP level of water given to the students.
Methodology: 



*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
[Research Question 2] What is the water type preference based on each class level?
[Rationale] This will help to establish Chi-Squared tests to see if water type is different across class level.
Methodology: 
;


*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
[Research Question 3] What is the top brand type preference based on gender in both experiments?
[Rationale] This will help to compare water brand preference from datasets 1 and 2 and see how they are different.

Methodology: 
;
proc freq data=lunsford_analytic_file;
	tables FavBotWatBrand * Gender / nocol norow nopercent; 
run;
