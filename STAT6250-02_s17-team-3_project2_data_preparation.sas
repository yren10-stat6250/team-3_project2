*******************************************************************************;
**************** 80-character banner for column width reference ***************;
* (set window width to banner width to calibrate line length to 80 characters *;
*******************************************************************************;

* 
[Dataset 1 Name] Grads1314

[Dataset Description] A dataset containing information for California high 
school graduates by racial/ethnic group and school for the school year 2013 – 
2014.

[Experimental Unit Description] High Schools within California

[Number of Observations] 2495

[Number of Features] 15

[Data Source] http://dq.cde.ca.gov/dataquest/dlfile/dlfile.aspx?cLevel=School&cYear=2013-14&cCat=GradEth&cPage=filesgrad.asp
I followed the link for the California Department of Education datasets and 
found this one for California high school graduate information. After 
downloading the text file, the information was copied and pasted into Excel 
for visualization.

[Data Dictionary] http://www.cde.ca.gov/ds/sd/sd/fsgrad09.asp

[Unique ID Schema] CDS_CODE, a 14-digit primary key that is a unique ID for a 
school within California

--

[Dataset 2 Name] Grads1415

[Dataset Description] A dataset containing information for California high 
school graduates by racial/ethnic group and school for the school year 2014 – 
2015.

[Experimental Unit Description] High Schools within California

[Number of Observations] 2490

[Number of Features] 15

[Data Source] http://dq.cde.ca.gov/dataquest/dlfile/dlfile.aspx?cLevel=School&cYear=2014-15&cCat=GradEth&cPage=filesgrad.asp
I followed the link for the California Department of Education datasets and 
found this one for California high school graduate information. After 
downloading the text file, the information was copied and pasted into Excel 
for visualization.

[Data Dictionary] http://www.cde.ca.gov/ds/sd/sd/fsgrad09.asp

[Unique ID Schema] CDS_CODE, a 14-digit primary key that is a unique ID for 
a school within California

--

[Dataset 3 Name] GradRates

[Dataset Description] A dataset containing information for graduate rates 
for high schools in California. This dataset also contains dropout 
information.

[Experimental Unit Description] High Schools within California

[Number of Observations] 7543

[Number of Features] 11

[Data Source] http://dq.cde.ca.gov/dataquest/dlfile/dlfile.aspx?cLevel=All&cYear=0910&cCat=NcesRate&cPage=filesncesrate
I followed the link for the California Department of Education datasets and 
found this one for California high school graduate rates. After 
downloading the text file, the information was copied and pasted into Excel 
for visualization.

[Data Dictionary] http://www.cde.ca.gov/ds/sd/sd/fsncesrate.asp

[Unique ID Schema] CDS_CODE, a 14-digit primary key that is a unique ID for a school within California

--

;

* setup environmental parameters;
%let inputDataset1URL =
https://github.com/stat6250/team-3_project2/blob/master/data/Grads1314.xls?raw=true
;
%let inputDataset1Type = XLS;
%let inputDataset1DSN = Grads1314_raw;

%let inputDataset2URL =
https://github.com/stat6250/team-3_project2/blob/master/data/Grads1415.xls?raw=true
;
%let inputDataset2Type = XLS;
%let inputDataset2DSN = Grads1415_raw;

%let inputDataset3URL =
https://github.com/stat6250/team-3_project2/blob/master/data/GradRates.xls?raw=true
;
%let inputDataset3Type = XLS;
%let inputDataset3DSN = GradRates_raw;

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
            filename tempfile "%sysfunc(getoption(work))/tempfile.xlsx";
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
