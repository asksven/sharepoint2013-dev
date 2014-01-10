# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Installs the Sharepoint 2013 pre-requisites
#
# History
# 1.0 	2014-01-03 	Initial version 
########################################################################
# Make changes in this section if required

# basic path and ISO info
$developerFolderPath = "e:\automation"
$softwareSetupPath = "e:\software"
$sharepointSetupPath = [STRING]::Concat($softwareSetupPath, "\en_sharepoint_server_2013_x64_dvd_1121447\prerequisiteinstaller.exe")


# changes end here
########################################################################

Write-Host "(VM) $(Get-Date): Start to install ShP2013 prerequisites."

# Configure SQL Server using Local System account 

if (-Not(Test-Path $sharepointSetupPath))
{
    Write-Host "(VM) $(Get-Date): $sharepointSetupPath does not exist"
    exit 1
}
$psExecPath = Join-Path -Path $developerFolderPath "tools\PsExec.exe"
$psExecLogPath = Join-Path -Path $developerFolderPath "tools\PsExecLog.txt"

$arguments = $sharepointSetupPath


$process = Start-Process -NoNewWindow -FilePath $psExecPath -ArgumentList $arguments -Wait -PassThru



return 0
