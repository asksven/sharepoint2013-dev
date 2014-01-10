# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Configures the sysprepped MSSQLServer
#
# History
# 1.0 	2014-01-03 	Initial version 
﻿########################################################################
# Make changes in this section if required

# basic path and ISO info
$developerFolderPath = "e:\automation"
$softwareSetupPath = "e:\software"
$sqlSetupPath = [STRING]::Concat($softwareSetupPath, "\en_sql_server_2012_enterprise_edition_with_sp1_x64_dvd\setup.exe")
$product_key = "748RB-X4T6B-MRM7V-RTVFF-CHC8H"

$caAuthProvider = "NTLM"


# changes end here
########################################################################


Write-Host "(VM) $(Get-Date): Start to configure SQL Server."

$sqlService = Get-Service -Name MSSQLSERVER -ErrorAction Ignore

if(!$sqlService)
{
    # Configure SQL Server using Local System account 

    $psExecPath = Join-Path -Path $developerFolderPath "tools\PsExec.exe"
    $psExecLogPath = Join-Path -Path $developerFolderPath "tools\PsExecLog.txt"

    $sqlarguments = ' /q /ACTION=CompleteImage /PID=$product_key /SQMREPORTING=1 /INSTANCENAME=MSSQLSERVER /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /SQLSVCACCOUNT="NT AUTHORITY\Network Service" /SQLSVCSTARTUPTYPE=Automatic /AGTSVCACCOUNT="NT AUTHORITY\Network Service" /AGTSVCSTARTUPTYPE=Automatic /RSSVCACCOUNT="NT AUTHORITY\Network Service" /RSSVCSTARTUPTYPE=Automatic /IACCEPTSQLSERVERLICENSETERMS'
    $arguments = $sqlSetupPath + $sqlarguments

    #Write-Host "(VM) $(Get-Date): Preparing to execute $arguments"
    #pause

    $process = Start-Process -NoNewWindow -FilePath $psExecPath -ArgumentList $arguments -Wait -PassThru

    
    $sqlService = Get-Service -Name MSSQLSERVER

    if (!$sqlService)
    {
        Write-Host "(VM) $(Get-Date): SQL Server was not configured successfully."
        return 1        
    }
    else
    {
        Write-Host "(VM) $(Get-Date): SQL Server has been configured successfully." 
    }
}
else
{
    Write-Host "(VM) $(Get-Date): SQL Server has already been configured."
}


return 0
