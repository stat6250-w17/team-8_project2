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
[Research Question 1] What is the frequently consumed water type in terms of bottled, tap or filtered?
[Rationale] We can see how students prefer to drink their water.
Methodology: 
;
proc freq data=lunsford_analytic_file ;
	tables Age * UsuallyDrink / nocol norow nopercent; 
run;



*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
[Research Question 2] What is the water type preference based on each class level?
[Rationale] This will help to establish Chi-Squared tests to see if water type is different across class level.
Methodology: I am using the PROC TEMPLATE method to change the variable names in 
the PROC FREQ file. 
Then I will use PROC FREQ on lunsford2 (deceptive test) data to 
create a two-way frequency table by academic class and most preferred 
water preference.
;
proc template;                                                                       
   edit Base.Freq.CrossTabFreqs;                                                     
      cellvalue Frequency Expected Deviation CellChiSquare TotalPercent
                Percent RowPercent ColPercent CumColPercent;                                           
      header TableOf  ControllingFor;                                                
                                                                                     
      define TableOf;                                                                 
         text "Table of " _ROW_LABEL_ " by " _COL_LABEL_ ;                            
      end;                                                                            
                                                                                     
      define header rowsheader;                                                       
         text _row_label_ / _row_label_ ^=' ';                                        
         text _row_name_;                                                             
      end;                                                                            
                                                                                     
      define header colsheader;                                                       
         text _col_label_ / _col_label_ ^=' ';                                        
         text _col_name_;                                                             
         cindent = ";";                                                               
         space = 1;                                                                   
      end;                                                                            
                                                                                     
      cols_header=colsheader;                                                         
      rows_header=rowsheader;                                                         
      header tableof;                                                                 
   end;                                                                              
run; 

proc freq data=lunsford2_raw_sorted;
	where class in ('F','J','SO','SR');
	tables class * first / nocol norow nopercent;
	label class='Academic Class'
		first='Water Brand';
	 title 'PROC FREQ displaying Top Ranked Water Brand by Class Year'; 
run;



*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;
*
[Research Question 3] What is the top brand type preference based on gender in both experiments?
[Rationale] This will help to compare water brand preference from datasets 1 and 2 and see how they are different.

Methodology: I am using PROC FREQ statment to obtain most preferred water brand by male versus female in both experiments.
;
proc freq data=lunsford_raw_sorted order=freq;
	tables FavBotWatBrand * Gender / nocol norow nopercent; 
	label FavBotWatBrand='Water Brand';
	 title 'Favorite Water Brand by Gender in Blind Water Test'; 
run;

        
proc freq data=lunsford2_raw_sorted order=freq;
	tables FavBotWatBrand * Gender / nocol norow nopercent; 
	label FavBotWatBrand='Water Brand';
	 title 'Favorite Water Brand by Gender in Deceptive Water Test'; 
run;
