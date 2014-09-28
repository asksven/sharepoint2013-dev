# Introduction
This is a set of scripts for added BI capabilities to the Sharepoint 2013 development image. These capabilities are not added to the development image by default as the added services add higher resource requirements (RAM) that may not be required in all cases.

The BI capabilities added are:
- SQL Server Analysis Services feature  (added to the SQLSERVER instance in tabular mode)
- SQL Server Integration Services feature 
- SQL Server Reporting Services feature (Sharepoint integrated mode)
- An instance of SSAS in tabular mode called POWERPIVOT
- An instance of SSAS in multidimentional mode called OLAP
- An Excel Services Sharepoint Service Application is added

The scripts are separated into 2 stages 01, 02:
- 01 is the basic SQL Server setup and instance creation
- 02 is the Sharepoint side setup

# Credits
## pstools
Are licensed by sysinternals.com and available here: http://technet.microsoft.com/de-de/sysinternals/bb896649.aspx
Please read the eual
 
# Prerequisites
* SQL Server must already be installed
* A user name SQL_AnalysisServices must exist (Password must be entered during setup)

# Notes


The SQL Server installation, configuration and setup is described in three INI files
- SQL_Server_ConfigurationFile_SSAS_SSIS_SSRS-integrated.ini installs the features
- SQLServer_ConfigurationFile_PowerPivotSSASInstance.ini creates the POWERPIVOT SSAS instance
- SQL_Server_ConfigurationFile_SSAS_Multidimentional.ini creates the multidimentional SSAS instance (name=OLAP)
- the AdventureWorks Sample database (relational, DW, cubes, etc.) can be installed following these instructions: http://technet.microsoft.com/en-us/library/jj573016(v=office.15).aspx

In case the "SQLServer_ConfigurationFile_PowerPivotSSASInstance.ini" file is re-created it must be edited afterhand: the FEATURE definition of the INI file must be commented out. 

# Further steps
Not (yet) covered by these scripts

* add a Reporting Services Service Application (central admin)
* Install the SQL Server Data Tools BI for Visual Studio 2013 (SSDT without BI is supported by VS2013 OOB)
* Add enpoints to connect SSAS and MSSQL: MSSQL (TCP) 1433, SSAS (TCP) 2382 and 2383
