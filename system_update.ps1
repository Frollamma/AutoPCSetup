Install-Module -Name PSWindowsUpdate -Force
Get-WindowsUpdate -Install -AcceptAll # If you want you can add "-AutoReboot"

# Update to Windows 11
$base_path = "\\NASCLOUD\FileServer$\lucibello.fra\"
$programs_path = $base_path + "programs\"

$Windows11Assistant = "Windows11InstallationAssistant.exe"

