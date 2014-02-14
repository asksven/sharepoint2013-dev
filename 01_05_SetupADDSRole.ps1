# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Configure the domain controller
#
# History
# 1.0 	2014-01-03 	Initial version 
# 1.1	2014-02-14	Externalized config 
########################################################################
Get-Content "config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }

$domainName = $h.domainName # must be something as a.b.c to fullfill the prereqs (fully qualified name)
$domainNetBIOSName = $h.domainNetBIOSName


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
