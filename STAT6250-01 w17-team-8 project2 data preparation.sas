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

[Data Source] http://filebin.ca/3C6MDo9ISFSP/Water_PH_Dataset.xlsx(sheet1)

[Data Dictionary]http://filebin.ca/3C6MDo9ISFSP/Water_PH_Dataset.xlsx(sheet2)

[Unique ID Schema] Water_OBS

--
[Dataset 4 Name] 

[Dataset Description] 

[Experimental d

[Number of Observations]                   

[Number of Features] 

[Data Source] )

[Data Dictionary]

[Unique ID Schema] 

--
* setup environmental parameters;
%let inputDataset1URL =

;
%let inputDataset1Type = XLS;
%let inputDataset1DSN = _raw;

%let inputDataset2URL =

;
%let inputDataset2Type = XLS;
%let inputDataset2DSN =_raw;;

%let inputDataset3URL =

;
%let inputDataset3Type = XLS;
%let inputDataset3DSN = _raw;;

%let inputDataset4URL =

;
%let inputDataset4Type = XLS;
%let inputDataset4DSN = _raw;


* load raw datasets over the wire, if they doesn't already exist;
