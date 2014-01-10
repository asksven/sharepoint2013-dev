# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Renames the server
#
# History
# 1.0 	2014-01-03 	Initial version 
########################################################################
# Make changes in this section if required

$computerName = "development" # must be consistent with AutoSPInstaller config


# changes end here
########################################################################

$currentComputerName = Get-Content env:computername
Write-Host "(VM) $(Get-Date): Computer is currently named: $currentComputerName. Press ENTER to rename to $computerName"
pause
Write-Host "(VM) $(Get-Date): Setting Computer Name."
Rename-Computer $computerName



return 0
