# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Creates the accounts needed by AutoSPInstaller
#
# History
# 1.0 	2014-01-03 	Initial version 
# 1.1	2014-02-14	Externalized config 
# 1.2	2014-02-16	Make sure to add user with a never expiring password
########################################################################
Get-Content "config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }

# create all the required accounts (see http://blog.lekman.com/2012/10/autospinstaller-prepare-server-hardware.html)
$Users = @("SP_Services", "SP_PortalAppPool", "SP_ProfilesAppPool", "SP_SearchService", "SP_CacheSuperUser", "SP_CacheSuperReader", "SP_Farm", "SP_SearchContent", "SP_ProfileSync", "SP_ExcelUser", "SP_VisioUser", "SP_PerfPointUser", "SP_ProjectServer", "SQL_AnalysisServices")

$password = $h.$password

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
    New-ADUser -Name $SAM -SamAccountName $SAM -UserPrincipalName $SAM -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -Enabled $true -PasswordNeverExpires $true
}  
