# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Sets up the windows network to work in a bridged environment
#
# History
# 1.0 	2014-01-03 	Initial version 
########################################################################
# Make changes in this section if required

$ip = "192.168.2.200"
$prefix = 24              # 255.255.255.0
$gtw = "192.168.2.1"
$primDns = "192.168.2.1"
$secDNS  = "8.8.8.8"


# changes end here
########################################################################

# Configure adapter
New-NetIPAddress -IPAddress $ip -InterfaceAlias "Ethernet" -DefaultGateway $gtw -AddressFamily IPv4 -PrefixLength 24

# disable ipv6
New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\services\TCPIP6\Parameters -Name DisabledComponents -PropertyType DWord -Value 0xffffffff

# add DNS
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses ("127.0.0.1", $primDns,$secDNS)

return 0
