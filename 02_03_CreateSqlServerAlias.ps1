# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Creates an alias to be used by connections
#
# History
# 1.0 	2014-01-03 	Initial version
# 1.1	2014-02-14	Externalized config 
########################################################################
Get-Content "config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }

#This is the name of your SQL Alias
$AliasName = $h.sqlAliasName
 
#This is the name of your SQL server (the actual name!)
$ServerName = $h.computerName
 
#These are the two Registry locations for the SQL Alias locations
$x86 = "HKLM:\Software\Microsoft\MSSQLServer\Client\ConnectTo"
$x64 = "HKLM:\Software\Wow6432Node\Microsoft\MSSQLServer\Client\ConnectTo"
 
#We're going to see if the ConnectTo key already exists, and create it if it doesn't.
if ((test-path -path $x86) -ne $True)
{
    write-host "$x86 doesn't exist"
    New-Item $x86
}
if ((test-path -path $x64) -ne $True)
{
    write-host "$x64 doesn't exist"
    New-Item $x64
}
 
#Adding the extra "fluff" to tell the machine what type of alias it is
$TCPAlias = "DBMSSOCN," + $ServerName
$NamedPipesAlias = "DBNMPNTW,\\" + $ServerName + "\pipe\sql\query"
 
#Creating our TCP/IP Aliases
New-ItemProperty -Path $x86 -Name $AliasName -PropertyType String -Value $TCPAlias
New-ItemProperty -Path $x64 -Name $AliasName -PropertyType String -Value $TCPAlias
 
#Creating our Named Pipes Aliases
#New-ItemProperty -Path $x86 –Name $AliasName -PropertyType String -Value $NamedPipesAlias
#New-ItemProperty -Path $x64 –Name $AliasName -PropertyType String -Value $NamedPipesAlias


