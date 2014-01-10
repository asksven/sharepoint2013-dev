# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Installs the ADDS role
#
# History
# 1.0 	2014-01-03 	Initial version 
########################################################################


$addsState = Get-WindowsFeature | where {$_.name -eq "AD-Domain-Services"}

if ($addsState.installed)
{
    Write-Host "(VM) $(Get-Date): ADDS is installed"
}
else
{
    Write-Host "(VM) $(Get-Date): ADDS is not installed"
    Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
}


return 0
