# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Creates the accounts needed by AutoSPInstaller
#
# History
# 1.0 	2014-01-03 	Initial version 
##############################################################
﻿# Make changes in this section if required


# create all the required accounts (see http://blog.lekman.com/2012/10/autospinstaller-prepare-server-hardware.html)
$Users = @("SP_Services", "SP_PortalAppPool", "SP_ProfilesAppPool", "SP_SearchService", "SP_CacheSuperUser", "SP_CacheSuperReader", "SP_Farm", "SP_SearchContent", "SP_ProfileSync", "SP_ExcelUser", "SP_VisioUser", "SP_PerfPointUser", "SP_ProjectServer")

$password = "Geheim123."

# changes end here
########################################################################

Import-Module ActiveDirectory 

Write-Host "(VM) $(Get-Date): Deleting and re-creating users"
foreach ($User in $Users)  
{
    Write-Host "(VM) $(Get-Date): $User"
}
pause

foreach ($User in $Users)  
{  

    $SAM =  $User
    Write-Host "(VM) $(Get-Date): Creating user $SAM"
    Remove-ADUser -Identity $SAM
    New-ADUser -Name $SAM -SamAccountName $SAM -UserPrincipalName $SAM -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true
} 
