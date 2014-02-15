ven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Installs Visual Studio 2013 ultimate (the product must later be activated with a proper key
#
# History
# 1.0 	2014-01-03 	Initial version 
# 1.1	2014-02-14	Externalized config 
# 1.2   2014-02-15	Fixed bug in path/arguments
########################################################################
Get-Content "config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }

# basic path and ISO info
$developerFolderPath = $h.developerFolderPath
$softwareSetupPath = $h.softwareSetupPath
$setupPath = [STRING]::Concat($softwareSetupPath, $h.vsSetupPath)


Write-Host "(VM) $(Get-Date): Start to install Visual Studio 2013."


if (-Not(Test-Path $setupPath))
{
    Write-Host "(VM) $(Get-Date): $setupPath does not exist"
    exit 1
}
$psExecPath = Join-Path -Path $developerFolderPath "tools\PsExec.exe"
$psExecLogPath = Join-Path -Path $developerFolderPath "tools\PsExecLog.txt"
$configFilePath = Join-Path -Path $developerFolderPath "VisualStudioConfig.xml"

$arguments = " /AdminFile $configFilePath"

$arguments = $setupPath + $arguments

Write-Host "(VM) $(Get-Date): Executing $arguments"
pause

$process = Start-Process -NoNewWindow -FilePath $psExecPath -ArgumentList $arguments -Wait -PassThru


return 0
