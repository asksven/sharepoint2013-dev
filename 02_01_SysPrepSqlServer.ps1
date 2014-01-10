# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# syspreps MSSQLServer
#
# History
# 1.0 	2014-01-03 	Initial version 
########################################################################
# Make changes in this section if required

# basic path and ISO info
$developerFolderPath = "e:\automation"
$softwareSetupPath = "e:\software"
$sqlSetupPath = [STRING]::Concat($softwareSetupPath, "\en_sql_server_2012_enterprise_edition_with_sp1_x64_dvd\setup.exe")

$caAuthProvider = "NTLM"


# changes end here
########################################################################

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