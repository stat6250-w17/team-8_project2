*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
[Dataset 1 Name] lunsford

[Dataset Description] Results from a Double-Blind Water Taste Test

[Experimental Unit Description] Longwood University Student

[Number of Observations] 109                   

[Number of Features] 11

[Data Source] 
https://github.com/ptabatabaeitabrizi-stat6250/Hello-world/blob/master/lunsford.xls (sheet1)

[Data Dictionary] 
https://github.com/ptabatabaeitabrizi-stat6250/Hello-world/blob/master/lunsford.xls (sheet2)

[Unique ID Schema] OBS

--

[Dataset 2 Name] lunsford2

[Dataset Description] Results from a Deceptive Water Taste Test 

[Experimental Unit Description] Longwood University Student

[Number of Observations] 104                   

[Number of Features] 10

[Data Source] 
https://github.com/ptabatabaeitabrizi-stat6250/Hello-world/blob/master/lunsford2.xls 
(sheet1)was downloaded and edited to addd OBS as an Unique ID

[Data Dictionary] 
https://github.com/ptabatabaeitabrizi-stat6250/Hello-world/blob/master/lunsford2.xls (sheet2)

[Unique ID Schema] OBS

--

[Dataset 3 Name] Water PH data set

[Dataset Description] Water PH level data from Bottled Water

[Experimental Unit Description] Bottled water from different brand

[Number of Observations] 113                  

[Number of Features] 11

[Data Source] 
http://filebin.ca/3C6MDo9ISFSP/Water_PH_Dataset.xlsx(sheet1)

[Data Dictionary]http://filebin.ca/3C6MDo9ISFSP/Water_PH_Dataset.xlsx(sheet2)

[Unique ID Schema] Water_OBS

--
* setup environmental parameters;
%let inputDataset1URL =
https://github.com/stat6250/team-8_project2/blob/master/data/lunsford.xls?raw=true
;
%let inputDataset1Type = XLS;
%let inputDataset1DSN = lunsford_raw;

%let inputDataset2URL =
https://github.com/stat6250/team-8_project2/blob/master/data/lunsford2.xls?raw=true
;
%let inputDataset2Type = XLS;
%let inputDataset2DSN =lunsford2_raw;;

%let inputDataset3URL =
https://github.com/bfu3-stat6250/hello-world/blob/master/Water_PH_Dataset.xls?raw=true

;
%let inputDataset3Type = XLS;
%let inputDataset3DSN = Water_PH_Dataset_raw;



* load raw datasets over the wire, if they doesn't already exist;
%macro loadDataIfNotAlreadyAvailable(dsn,url,filetype);
    %put &=dsn;
    %put &=url;
    %put &=filetype;
    %if
        %sysfunc(exist(&dsn.)) = 0
    %then
        %do;
            %put Loading dataset &dsn. over the wire now...;
            filename tempfile TEMP;
            proc http
                method="get"
                url="&url."
                out=tempfile
                ;
            run;
            proc import
                file=tempfile
                out=&dsn.
                dbms=&filetype.;
            run;
            filename tempfile clear;
        %end;
    %else
        %do;
            %put Dataset &dsn. already exists. Please delete and try again.;
        %end;
%mend;
%loadDataIfNotAlreadyAvailable(
    &inputDataset1DSN.,
    &inputDataset1URL.,
    &inputDataset1Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset2DSN.,
    &inputDataset2URL.,
    &inputDataset2Type.
)
%loadDataIfNotAlreadyAvailable(
    &inputDataset3DSN.,
    &inputDataset3URL.,
    &inputDataset3Type.
)


* sort and check raw datasets for duplicates with respect to their unique ids,
  removing blank rows, if needed;
proc sort
        nodupkey
        data=lunsford_raw
        dupout=lunsford_raw_dups
        out=lunsford_raw_sorted(where=(not(missing(Second))))
    ;
    by
        OBS
    ;
run;

proc sort
        nodupkey
        data=lunsford2_raw
        dupout=lunsford2_raw_dups
        out=lunsford2_raw_sorted(where=(not(missing(Second))))
    ;
    by
        OBS
    ;
run;

proc sort
        nodupkey
        data=Water_PH_Dataset_raw
        dupout=Water_PH_Dataset_raw_dups
        out=Water_PH_Dataset_raw_sorted(where=(not(missing(pH))))
    ;
    by
        Brand
    ;
run;

* combine lunsford and lunsford2 data vertically, combine composite key values into a primary key
  key, and compute year-over-year (y-o-y) change in Percent_Eligible_FRPM_K12,
  retaining all AY2014-15 fields and y-o-y Percent_Eligible_FRPM_K12 change;
data lunsford_combined;
    set
        lunsford_raw_sorted
        lunsford2_raw_sorted
    ;
run;

proc sort

        data=lunsford_combined
 
        out=lunsford_combined_sorted
    ;
    by
        FavBotWatBrand
    ;
run;



data lunsford_analytic_file;
    merge lunsford_combined_sorted (in=lun)
          Water_PH_Dataset_raw_sorted (rename=(Brand=FavBotWatBrand)in=wph )
    ;
	by
          FavBotWatBrand
    ;

run;

proc print data = lunsford_analytic_file;
     where OBS is not null;
run;

  /*
    if 
          lun = 1 and wph =1
	;
  */


