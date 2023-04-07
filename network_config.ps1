param (
    [string]$interfaceName = "Ethernet",
    [string]$ipAddress,
    [string]$subnetMask = "255.255.248.0",
    [string]$gateway = "192.168.8.249",
    [string[]]$DnsServers = @("192.168.98.5", "192.168.15.6", "8.8.8.8")
)

$interface = Get-NetAdapter | Where-Object { $_.Name -eq $interfaceName }
$interfaceIndex = $interface.ifIndex

# Set IP address, subnet mask and gateway
New-NetIPAddress -IPAddress $ipAddress -PrefixLength $subnetMask -DefaultGateway $gateway -InterfaceIndex $interfaceIndex

# Set DNS servers
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses $DnsServers
