# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Make a new release of the master VHD
#
# History
# 1.0 	2014-02-16 	Initial version 
########################################################################
# This script pushes a release the sharepoint dev image to
# the master storage account

Get-Content "config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("#") -ne $True) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }

# needed as the azure powershell extension does not get added to PATH
$env:PSModulePath=$env:PSModulePath+";"+"C:\Program Files (x86)\Microsoft SDKs\Windows Azure\PowerShell"
Import-Module Azure -force

Select-AzureSubscription $h.azureSubscription
 
$releaseName = "sharepoint_2013_dev_r_2_1_0_0.vhd"

### Source VHD - authenticated container ###
$srcUri = $h.srcUri
 
### Source Storage Account ###
$srcStorageAccount = $h.srcStorageAccount
$srcStorageKey = "KXXr4uy2Sy76REClJgCwwDYB51Ofa89VAhwO+Ffjba8J4L+Z8Sc2YLCHwPBDQw1c4AzGMP1un1H3lsRe4d6xIg=="

 
### Target Storage Account ###
$destStorageAccount = $h.destStorageAccount
$destStorageKey = "9o9O2chz4209Y2jjGiNeGOU/Wk3f3tJuv3Iz6iSwpQ95/hBjUzBFSHWK9v1MR75ggHgone30eyuuxy3HhWrHzg=="

 
### Create the source storage account context ### 
$srcContext = New-AzureStorageContext  –StorageAccountName $srcStorageAccount `
                                        -StorageAccountKey $srcStorageKey  
 
### Create the destination storage account context ### 
$destContext = New-AzureStorageContext  –StorageAccountName $destStorageAccount `
                                        -StorageAccountKey $destStorageKey  
 
### Destination Container Name ### 
$containerName = "mastervhds"
 
if (!(Get-AzureStorageContainer -Name $containerName -Context $destContext))
{
    Write-Host "(VM) $(Get-Date): Creating storage container $containerName"
    ### Create the container on the destination ### 
    New-AzureStorageContainer -Name $containerName -Context $destContext 
}
else
{
    Write-Host "(VM) $(Get-Date): Storage container $containerName already exists. Do nothing"
}

if (!(Get-AzureStorageBlob -Container $containerName -Blob $releaseName -Context $destContext))
{
    Write-Host "(VM) $(Get-Date): Starting async copy from $srcContext to $releaseName"
    ### Start the asynchronous copy - specify the source authentication with -SrcContext ### 
    $blob1 = Start-AzureStorageBlobCopy -srcUri $srcUri `
                                    -SrcContext $srcContext `
                                    -DestContainer $containerName `
                                    -DestBlob $releaseName `
                                    -DestContext $destContext
}
else
{
    Write-Host "(VM) $(Get-Date): blob $releaseName already exists. Do nothing"
    
}
 

