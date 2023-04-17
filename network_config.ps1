param (
    [string]$interfaceName = "Ethernet",
    [string]$ipAddress = "192.168.15.200",
    # [string]$subnetMask = "255.255.248.0",
    [int]$prefixLength = 21, #See https://nuangel.net/2018/05/what-should-my-subnet-prefix-be/
    [string]$gateway = "192.168.8.249",
    [string[]]$DnsServers = @("192.168.98.5", "192.168.15.6", "8.8.8.8")
)

Write-Host "Add IP Address " $ipAddress

$interface = Get-NetAdapter | Where-Object { $_.Name -eq $interfaceName }
$interfaceIndex = $interface.ifIndex

# Remember to connect Ethernet before running the script!

# Check if IP address already exists
$existingIp = Get-NetIPAddress -InterfaceIndex $interfaceIndex | Where-Object { $_.IPAddress -eq $ipAddress }
if ($existingIp) {
    # IMPR: Never tested
    Set-NetIPAddress -InputObject $existingIp -PrefixLength $prefixLength -DefaultGateway $gateway
}
else {
    # Set IP address, subnet mask and gateway
    New-NetIPAddress -IPAddress $ipAddress -PrefixLength $prefixLength -DefaultGateway $gateway -InterfaceIndex $interfaceIndex
}

# Set-NetIPAddress -InterfaceIndex 2 -PrefixLength 24 -PrefixOrigin Manual -SubnetMask 255.255.255.0

# New-NetIPAddress -IPAddress $ipAddress -InterfaceIndex $interfaceIndex -PrefixLength 24 -SubnetMask $subnetMask -DefaultGateway $gateway

# Set DNS servers
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses $DnsServers
