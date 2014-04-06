# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Installs the Powerpivot features for Sharepoint 2013#
# History
# 1.0 	2014-04-05 	Initial version 
########################################################################

Get-Content "..\config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }

# basic path and ISO info
$developerFolderPath = $h.developerFolderPath
$softwareSetupPath = $h.softwareSetupPath

$caAuthProvider = $h.caAuthProvider


Write-Host "(VM) $(Get-Date): Start to install powerpivot for Sharepoint 2013."

$setupPath =  Join-Path -Path $softwareSetupPath "\spPowerPivot.msi"

Write-Host "(VM) $(Get-Date): Preparing to execute $setupPath"
pause

msiexec /i $setupPath

return 0
