$sqlServer = "development"
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