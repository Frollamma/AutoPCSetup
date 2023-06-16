$interfaceName = "Ethernet"
$DnsServers = @("192.168.15.6", "192.168.98.5", "8.8.8.8")

$interface = Get-NetAdapter | Where-Object { $_.Name -eq $interfaceName }
$interfaceIndex = $interface.ifIndex

# Set DNS servers
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses $DnsServers
