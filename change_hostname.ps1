param(
    [Parameter(Mandatory=$true)]
    [string]$newHostname
)

# Check if the script is running with administrative privileges
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "This script must be run as an Administrator. Please re-run this script as an Administrator."
    return
}

# Change the hostname
Rename-Computer -NewName $newHostname