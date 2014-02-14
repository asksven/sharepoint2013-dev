# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Sets up the windows network to work in a bridged environment
#
# History
# 1.0 	2014-01-03 	Initial version 
# 1.1	2014-02-14	Externalized config 
########################################################################
Get-Content "config.txt" | foreach-object -begin {$h=@{}} -process { $k = [regex]::split($_,'='); if(($k[0].CompareTo("") -ne 0) -and ($k[0].StartsWith("[") -ne $True)) { $h.Add($k[0], $k[1]) } }

$ip = $h.net_ip
$prefix = $h.net_prefix
$gtw = $h.net_gtw
$primDns = $h.net_primDns
$secDNS  = $h.net_secDns

# Configure adapter
New-NetIPAddress -IPAddress $ip -InterfaceAlias "Ethernet" -DefaultGateway $gtw -AddressFamily IPv4 -PrefixLength 24

# disable ipv6
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters -Name DisabledComponents -PropertyType DWord -Value 0xffffffff

# add DNS
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("127.0.0.1", $primDns,$secDNS)

return 0
