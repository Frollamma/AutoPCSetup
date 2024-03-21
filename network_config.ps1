param (
    [string]$interfaceName = "Ethernet",
    [string]$ipAddress = "192.168.15.214",
    [int]$prefixLength = 21,
    [string]$gateway = "192.168.8.249",
    [string[]]$DnsServers = @("192.168.98.5", "192.168.15.6", "8.8.8.8")
)

Write-Host "Configuring network settings for IP Address: $ipAddress on interface: $interfaceName"

$interface = Get-NetAdapter | Where-Object { $_.Name -eq $interfaceName }
if (-not $interface) {
    Write-Host "Interface $interfaceName not found."
    exit
}
$interfaceIndex = $interface.ifIndex

$existingIps = Get-NetIPAddress -InterfaceIndex $interfaceIndex -AddressFamily IPv4
$desiredIpExists = $existingIps | Where-Object { $_.IPAddress -eq $ipAddress }

if (-not $desiredIpExists) {
    Write-Host "IP address $ipAddress not found on $interfaceName, configuring it now."

    # Remove all existing IPv4 addresses from the interface
    $existingIps | Remove-NetIPAddress -Confirm:$false

    # Set the new IP address
    New-NetIPAddress -IPAddress $ipAddress -PrefixLength $prefixLength -InterfaceIndex $interfaceIndex
} else {
    Write-Host "IP address $ipAddress already configured on $interfaceName."
}

# Ensure the default gateway is correctly configured
$existingGateway = Get-NetRoute -InterfaceIndex $interfaceIndex -AddressFamily IPv4 | Where-Object { $_.DestinationPrefix -eq '0.0.0.0/0' }
if ($existingGateway.NextHop -ne $gateway) {
    Write-Host "Updating default gateway to $gateway."
    $existingGateway | Remove-NetRoute -Confirm:$false
    New-NetRoute -InterfaceIndex $interfaceIndex -DestinationPrefix '0.0.0.0/0' -NextHop $gateway
} else {
    Write-Host "Default gateway $gateway is already configured."
}

# Set DNS servers
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses $DnsServers
Write-Host "DNS servers updated."
