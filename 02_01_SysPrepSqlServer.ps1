# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# syspreps MSSQLServer
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


Write-Host "(VM) $(Get-Date): Start to sysprep SQL Server."

$sqlService = Get-Service -Name MSSQLSERVER -ErrorAction Ignore


if(!$sqlService)
{
    # Configure SQL Server using Local System account 

    if (-Not(Test-Path $sqlSetupPath))
    {
        Write-Host "(VM) $(Get-Date): $sqlSetupPath does not exist"
        exit 1
    }
    $psExecPath = Join-Path -Path $developerFolderPath "tools\PsExec.exe"
    $psExecLogPath = Join-Path -Path $developerFolderPath "tools\PsExecLog.txt"
    $sqlarguments = ' /q /ACTION=PrepareImage /UpdateEnabled /UpdateSource=MU /FEATURES=SQLENGINE /INSTANCEID=MSSQLSERVER /IACCEPTSQLSERVERLICENSETERMS'

    $arguments = $sqlSetupPath + $sqlarguments


    $process = Start-Process -NoNewWindow -FilePath $psExecPath -ArgumentList $arguments -Wait -PassThru

}
else
{
    Write-Host "(VM) $(Get-Date): SQL Server has already been configured."
}


return 0
