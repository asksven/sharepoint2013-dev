# Introduction
This is a set of scripts for added BI capabilities to the Sharepoint 2013 development image. These capabilities are not added to the development image by default as the added services add higher resource requirements (RAM) that may not be required in all cases.

The BI capabilities added are:
- SQL Server Analysis Services feature  (added to the SQLSERVER instance in tabular mode)
- SQL Server Integration Services feature 
- SQL Server Reporting Services feature (Sharepoint integrated mode)
- An instance of SSAS in tabular mode called POWERPIVOT
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


The SQL Server installation, configuration and setup is described in two INI files
- SQL_Server_ConfigurationFile_SSAS_SSIS_SSRS-integrated.ini installs the features
- SQLServer_ConfigurationFile_PowerPivotSSASInstance.ini creates the POWERPIVOT SSAS instance

In case the "SQLServer_ConfigurationFile_PowerPivotSSASInstance.ini" file is re-created it must be edited afterhand: the FEATURE definition of the INI file must be commented out. 

After installing and configuring PowerPivot fr Sharepoint 2013 the power pivot gallery feature will not be deployed in all web apps. To fix this go to the central admin, select Central Admin-System Settings-Manage Farms Solution and deploy powerpivotwebapplicationsolution.wsp to your web application (ref: http://sergeluca.wordpress.com/2013/01/28/sharepoint-2013-creating-a-powerpivot-gallery-and-getting-could-not-load-type-microsoft-analysisservices-spaddin-reportgallery-reportgalleryview/)