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


title1 justify=left
"Research Question 1: What is the frequently consumed water type - bottled, tap or filtered for students in sample survey?"
;

title2 justify=left
"Rationale: This helps to further analyze the cost and sustainability of bottle water consumption by the lunsford analytics."
;

footnote1 justify=left
"Majority of students prefer to drink bottled water, followed by filtered water and tap water."
;

footnote2 justify=left
"If university plans to set Green Goals, then it should look into discouraging bottle water consumption and perhaps set up water fountains for tap water."
;

*
Note: Initial frequency was performed for all ages as there were some ages of 2,9, 
17 & ages above 22. We believe those ages were a data entry error and as such 
these ages were omitted from PROC FREQ display. We do not beieve omitting these 
ages made any statistical impact since the sample participants were college 
students and the order of frequency for each water type was the same for 
including and excluding ages.

Methodology: The file lunsford_analytic was created by horizontally combining 
lunsford_combined table with Water_PH_Dataset table based on FavBotWatBrand column. 
We use PROC FREQ method to create a table by age and usually consumed water. 
We use PROC FORMAT to change the display of variables in UsuallyDrink column so that 
the frequency table is easy to interpret, which is included in data preparation file.
We are using the PROC TEMPLATE method to change the variable names in 
the PROC FREQ file.
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

proc freq data=lunsford_analytic_file ;
	where Age IN (18,19,20,21);
	tables Age * UsuallyDrink / nocol norow nopercent;
	format UsuallyDrink $UsuallyDrink.;
	label Age='Academic Class'
		UsuallyDrink='Water Type';
	title3 height=10pt 
		color=red "Table 1: Usually Consumed Water Type by Age Group";
run;

title;
footnote;



*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;

title1 justify=left
"Research Question 2: What is the lowest rank water brand based on gender in Deceptive Water Test?"
;

title2 justify=left 
"Rationale: This shows if the participants dislike a particular water brand. In Deceptive Water experiment, participants were asked to taste and rank 3 cups of water in terms of preference. Each cup is labeled with 3 different brand names: Fiji, Aquafina, and Sam's Choice but all were actually filled with WalMart drinking water."
;

footnote1 justify=left 
"Based on the graph and table output, participants seem to dislike the taste of Sam's Choice the most among other least ranked water brands."
; 

footnote2 justify=left 
"Further test should check if having the brand label on the water cup had any effect on participant's preference rank r if this choice is merely random."
;

*
Methodology: We are using PROC FREQ statment to obtain a frequency table and a plot 
for least preferred water brand by gender in Deceptive Experiment. 
;


proc freq data=lunsford2_raw_sorted ;
	tables Gender * Third / nocol norow nopercent plots (only) = freqplot(twoway = stacked);
	format Third $First.;
	label Third='Lowest Ranked Water Brand';
	title3 height=10pt 
		color=red "Table 2: Least Favorite Water Brand by Gender in Deceptive Water Test";
run; 


title;
footnote;
*******************************************************************************;
* Research Question Analysis Starting Point;
*******************************************************************************;



