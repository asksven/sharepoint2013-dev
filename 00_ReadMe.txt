# Introduction
This is a set of scripts for automatically setting up different stages of development environments based on Windows Server 2012 using powershell.

The scripts are separated into 3 stages 01, 02 and 03:
- 01 is the basic server setup setting the computer name, configuring the network (optional) and setting up the AD role
- 02 is installation and setup of SQL Server 2012
- 03 is the installation of visual studio 2013 and sharepoint 2013 (using AutoSPInstaller)

# Credits
## pstools
Are licensed by sysinternals.com and available here: http://technet.microsoft.com/de-de/sysinternals/bb896649.aspx
Please read the eual

## AutoSPInstaller
Is made available under the terms of the Ms-PL (http://autospinstaller.codeplex.com/license)
 
# Directory Structure
The directory structure (assumed to be on drive e: inside of the Windows Server image)

  \
  \automation 		# where all the scripts are located, including AutoSPInstaller
    \AutoSPInstaller 	# see credits
    \tools 		# psexec and other pstools from sysinternals.com
  \software		# software distribution for Visual Studio 2013, Sharepoint 2013 and SQL Server 2012 (each exctracted into its own directory)
    \en_sharepoint_server_2013_x64_dvd_1121447
    \en_sql_server_2012_enterprise_edition_with_sp1_x64_dvd
    \en_visual_studio_ultimate_2013_x86_dvd_3175319

# Mandatory steps

* create the directory, download the ISO files and unzip
* downloads the pstools (http://technet.microsoft.com/de-de/sysinternals/bb896649.aspx) and extract them to \automation\tools (the license restricts distribution so they can not be provided)
* review and change the powershell script config "config.txt" to reflect the directory layout and settings
* review the server name (in 01_01) and if changed make the changes to the AutoSPInstaller XML configuration
* review the account password (01_05, 03_03, AutoSPInstall XML configuration) and consistently make the appropriate changes 
* review the SharePoint configuration XML

# Reboots
Rebooting the server between the steps will not happen automatically

Reboots shoule be made:
- after 01_02
- after 01_04
- after 01_05

﻿
