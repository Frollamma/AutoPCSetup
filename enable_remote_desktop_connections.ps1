# Enable-RemoteDesktop.ps1
# This PowerShell script enables Remote Desktop Connections on a Windows machine.

# Enable Remote Desktop
Write-Host "Enabling Remote Desktop..."
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 0

# Allow Remote Desktop through the Firewall
Write-Host "Configuring Windows Firewall to allow Remote Desktop..."
Enable-NetFirewallRule -DisplayGroup "Desktop remoto"
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"


# Optional: Set the authentication level. Uncomment to enable.
# This sets the authentication mode to Secure (2) which requires network-level authentication.
# For less secure environments, you can set this to 0.
# Write-Host "Setting Remote Desktop authentication mode to Secure (requires NLA)..."
# Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 2

Write-Host "Remote Desktop has been enabled successfully."

# Note: Restarting the system or the Remote Desktop Service may be required for changes to take effect.
