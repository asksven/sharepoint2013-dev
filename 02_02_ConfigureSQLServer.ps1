# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Configures the sysprepped MSSQLServer
#
# History
# 1.0 	2014-01-03 	Initial version 
# 1.1	2014-02-14	Externalized config 
########################################################################
Get-Content "config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }

# basic path and ISO info
$developerFolderPath = $h.developerFolderPath
$softwareSetupPath = $h.softwareSetupPath
$sqlSetupPath = [STRING]::Concat($softwareSetupPath, $h.sqlSetupPath)
$caAuthProvider = $h.caAuthProvider


Write-Host "(VM) $(Get-Date): Start to configure SQL Server."

$sqlService = Get-Service -Name MSSQLSERVER -ErrorAction Ignore

if(!$sqlService)
{
    # Configure SQL Server using Local System account 

    $psExecPath = Join-Path -Path $developerFolderPath "tools\PsExec.exe"
    $psExecLogPath = Join-Path -Path $developerFolderPath "tools\PsExecLog.txt"

    $sqlarguments = ' /q /ACTION=CompleteImage /SQMREPORTING=1 /INSTANCENAME=MSSQLSERVER /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" /SQLSVCACCOUNT="NT AUTHORITY\Network Service" /SQLSVCSTARTUPTYPE=Automatic /AGTSVCACCOUNT="NT AUTHORITY\Network Service" /AGTSVCSTARTUPTYPE=Automatic /RSSVCACCOUNT="NT AUTHORITY\Network Service" /RSSVCSTARTUPTYPE=Automatic /IACCEPTSQLSERVERLICENSETERMS'
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
