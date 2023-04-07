param (
    [string]$interfaceName = "Ethernet",
    [string]$ipAddress,
    [string]$subnetMask = "255.255.248.0",
    [string]$gateway = "192.168.8.249"
)

$interface = Get-NetAdapter | Where-Object { $_.Name -eq $interfaceName }
$interfaceIndex = $interface.ifIndex

New-NetIPAddress -IPAddress $ipAddress -PrefixLength $subnetMask -DefaultGateway $gateway -InterfaceIndex $interfaceIndex
