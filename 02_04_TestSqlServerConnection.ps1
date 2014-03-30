# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Creates an alias to be used by connections
#
# History
# 1.0 	2014-01-03 	Initial version
# 1.1	2014-02-14	Externalized config 
########################################################################
Get-Content "config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }

$sqlServer = $h.sqlAliasName #$h.computerName

$objSQLConnection = New-Object System.Data.SqlClient.SqlConnection
try
{
    $objSQLCommand = New-Object System.Data.SqlClient.SqlCommand
    $objSQLConnection.ConnectionString = "Server=$sqlServer;Integrated Security=SSPI;"
    Write-Host -ForegroundColor White " - Testing access to SQL server/instance/alias:" $sqlServer
    Write-Host -ForegroundColor White " - Trying to connect to `"$sqlServer`"..."
    $objSQLConnection.Open() | Out-Null
    Write-Host -ForegroundColor Black -BackgroundColor Green "Success"
}
catch
{
    Write-Host -ForegroundColor Red " Failed..."
}
