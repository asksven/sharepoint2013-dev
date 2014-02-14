# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Add a site to a site collection using CSOM
#
# History
# 1.0 	2014-02-01 	Initial version 
########################################################################

$url      = "https://svenknispel.sharepoint.com/sites/teamsitecollection1" 
$newSiteTitle = "Created by PowerShell"

$username = Read-Host -Prompt "Enter username (user@domain.onmicrosoft.com)" 
$securePassword = Read-Host -Prompt "Enter password" -AsSecureString
 
#$securePassword = ConvertTo-SecureString $Password -AsPlainText -Force 
 
# we are on a sharepoint 2013 server. Path may differ
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.dll" 
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Runtime.dll" 
Add-Type -Path "c:\Program Files\Common Files\microsoft shared\Web Server Extensions\15\ISAPI\Microsoft.SharePoint.Client.Taxonomy.dll" 
 
# connect/authenticate to SharePoint Online and get ClientContext object.. 
$clientContext = New-Object Microsoft.SharePoint.Client.ClientContext($url) 
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($username, $securePassword) 
$clientContext.Credentials = $credentials 
 
if (!$clientContext.ServerObjectIsNull.Value) 
{ 
    Write-Host "Connected to SharePoint Online site: '$Url'" -ForegroundColor Green 
} 

$rootWeb = $clientContext.Web
$childWebs = $rootWeb.Webs
$clientContext.Load($rootWeb)
$clientContext.Load($childWebs)
$clientContext.ExecuteQuery()
 
function processWeb($web)
{
    $lists = $web.Lists
    #$groups = $web.Groups
    $clientContext.Load($web)
    #$clientContext.Load($groups)
    $clientContext.ExecuteQuery()
    Write-Host "Web URL is" $web.Url
    foreach ($group in $groups)
    {
        Write-Host "Group: $group"
    }
}

#list webs
foreach ($childWeb in $childWebs)
{
    processWeb($childWeb)
}

exit
# create web 
$wcInfo = New-Object Microsoft.SharePoint.Client.WebCreationInformation
$wcInfo.Description = "This is a site create using powershell with CSOM"
$wcInfo.Title = "another web"
$wcInfo.UseSamePermissionsAsParentSite = $false
$wcInfo.Url = "anotherweb2"
$wcInfo.WebTemplate = "STS#0“
$wcInfo.Language = 1033  # english

$newWeb = $rootWeb.Webs.Add($wcInfo);
$clientContext.Load($newWeb)
$clientContext.ExecuteQuery()

#list webs
foreach ($childWeb in $childWebs)
{
    processWeb($childWeb)
}
