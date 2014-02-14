# by Sven Knispel under ter terms of the Ms-PL license (see license.txt)
#
# Disables the windows firewall
#
# History
# 1.0 	2014-01-03 	Initial version 
########################################################################
﻿# we turn the firewall off alltogether

Get-NetFirewallProfile | Set-NetFirewallProfile –Enabled False


# previous attempt to define individual rules was abandoned  
# see also http://stevegoodyear.wordpress.com/sharepoint-2013-build-guide/configuring-the-windows-firewall-for-sharepoint-farm-traffic/
#New-NetFirewallRule -DisplayName “SharePoint Web Traffic" –Protocol TCP	–LocalPort 80,443 -Action allow
#New-NetFirewallRule -DisplayName “SharePoint Search Index" –Protocol TCP –LocalPort 16500-16519 -Action allow
#New-NetFirewallRule -DisplayName “SharePoint Farm Communication" –Protocol TCP –LocalPort 32843,32844,32845 -Action allow
#New-NetFirewallRule -DisplayName “SharePoint Profile Synchronizing (TCP)" –Protocol TCP –LocalPort 5725,389,88,53 -Action allow
#New-NetFirewallRule -DisplayName “SharePoint Profile Synchronizing (UDP)" –Protocol UDP –LocalPort 389,88,53,464 -Action allow
#New-NetFirewallRule -DisplayName “SharePoint User Code Service"	–Protocol TCP –LocalPort 32846 -Action allow
#New-NetFirewallRule -DisplayName “SharePoint SMTP Service" –Protocol TCP –LocalPort 25 -Action allow

#Enabling SQL Server Ports
#New-NetFirewallRule -DisplayName “SQL Server” -Direction Inbound –Protocol TCP –LocalPort 1433 -Action allow
#New-NetFirewallRule -DisplayName “SQL Admin Connection” -Direction Inbound –Protocol TCP –LocalPort 1434 -Action allow
#New-NetFirewallRule -DisplayName “SQL Service Broker” -Direction Inbound –Protocol TCP –LocalPort 4022 -Action allow
#New-NetFirewallRule -DisplayName “SQL Debugger/RPC” -Direction Inbound –Protocol TCP –LocalPort 135 -Action allow

