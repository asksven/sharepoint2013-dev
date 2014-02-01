# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Creates a site collection on office365 using the office online commandlets
#
# History
# 1.0 	2014-02-01 	Initial version 
########################################################################

$user         = "sven.knispel@svenknispel.onmicrosoft.com"
$site         = "https://svenknispel-admin.sharepoint.com"
$locale       = 1033  # english
$newSite      = "https://svenknispel.sharepoint.com/sites/teamsitecollection1" 
$newSiteTitle = "Created by PowerShell"
            
Import-Module -name "Microsoft.Online.SharePoint.PowerShell" -DisableNameChecking

# connect
    Write-Host "Connecting to service"
try
{
    Connect-SPOService -Url $site -Credential $user

    Write-Host -ForegroundColor Green "Connected"
    
    # check if site exists
    $site = Get-SPOSite $newSite

    if ($site -ne $null)
    {

        Write-Host -ForegroundColor Red "Site $newSite already exists"
      
        $a = new-object -comobject wscript.shell 

        $choice = ""
        while ($choice -notmatch "[y|n]")
        {
            $choice = read-host "Site collection $newSite already exists. Do you want to delete and re-create it? (Y/N)"
        }

        if ($choice -eq "y")
        {
            # delete and purge
            Write-Host "Deleting $newSite"
            Remove-SPOSite $newSite -Confirm:$false

            Write-Host "Removing $newSite from recycle bin"
            Remove-SPODeletedSite -Identity $newSite -Confirm:$false

            # create a site collection
            Write-Host "Creating $newSite"
            New-SPOSite -Url $newSite -Owner $user -LocaleId $locale -StorageQuota 100 -ResourceQuota 1  -Title $newSiteTitle -Template STS#0 -NoWait

        }
        else
        {
            write-host "Doing nothing!"
        }
    }
    else
    {
        # create a site collection
        Write-Host "Creating $newSite"
        New-SPOSite -Url $newSite -Owner $user -LocaleId $locale -StorageQuota 100 -ResourceQuota 1  -Title $newSiteTitle -Template STS#0 -NoWait

    }

    # disconnect
    Disconnect-SPOService
}
catch 
{
    Write-Host -ForegroundColor Red "Unable to connect"
}




