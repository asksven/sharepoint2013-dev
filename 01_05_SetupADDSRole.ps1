# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Configure the domain controller
#
# History
# 1.0 	2014-01-03 	Initial version 
########################################################################
# Make changes in this section if required

$domainName = "dev.com" # must be something as a.b.c to fullfill the prereqs (fully qualified name)
$domainNetBIOSName = "dev"


# changes end here
########################################################################


$addsState = Get-WindowsFeature | where {$_.name -eq "AD-Domain-Services"}

if ($addsState.installed)
{
    Write-Host "(VM) $(Get-Date): ADDS is installed"
    Import-Module ADDSDeployment
    Install-ADDSForest `
      -DomainName $domainName `
       -DomainNetbiosName $domainNetBIOSName `
       -SafeModeAdministratorPassword (ConvertTo-SecureString -String "pass@word1" -AsPlainText -Force) `
       -NoDnsOnNetwork `
       -InstallDns `
       -DomainMode Win2012 `
       -ForestMode Win2012 `
       -NoRebootOnCompletion `
       -Confirm:$false
}
else
{
    Write-Host "(VM) $(Get-Date): Error: ADDS is not installed"
    exit 1
}

return 0
