# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Renames the server
#
# History
# 1.0 	2014-01-03 	Initial version
# 1.1	2014-02-14	Externalized config 
########################################################################
Get-Content "config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }
$computerName = $h.computerName


$currentComputerName = Get-Content env:computername

Write-Host "(VM) $(Get-Date): Computer is currently named: $currentComputerName. Press ENTER to rename to $computerName"
pause
Write-Host "(VM) $(Get-Date): Setting Computer Name."
Rename-Computer $computerName



return 0
