param (
	[int]$installationDelay = 0,
	[bool]$useLocalFolder = $true,
	[bool]$blocking = $false
)

$base_path = "\\NASCLOUD\FileServer$\lucibello.fra\"
$desktopPath = "$env:USERPROFILE\Desktop"

$programs_path = $base_path + "programs\"

$WindowsPCHealthCheck = "WindowsPCHealthCheckSetup.msi"
$Chrome = "ChromeSetup.exe"
$GoSign = "GoSign-Desktop-installer-win32.msi"
$Java = "jre-8u181-windows-i586"
$LibreOffice = "LibreOffice.msi"
$Webex = "Webex.msi"
$AcrobatReader = "readerdc64.exe"
$Simel = "Simel Maggioli Quarto.jnlp"
$TeamViewerComuneClient = "TeamViewerQS-idc3gq7dvg.exe"
$WinRAR = "winrar-x64-620it.exe"
$Sophos = "SophosSetup.exe"

$programs = @(
	$Simel,
	$TeamViewerComuneClient
)

$simple_installers = @(
	$Chrome,
	$Java,
	$WinRAR
)

$installers = @(
	$WindowsPCHealthCheck,
	$GoSign,
	$LibreOffice,
	$Webex
)

Write-Host "Copying portable programs in Desktop ($desktopPath)..." 
foreach ( $program in $programs ) {
	Write-Host ("Copying " + $installer + "...")
	Start-Sleep -Seconds $installationDelay
	cp ($programs_path + $program) "$desktopPath"
}

Write-Host "Running simple installers..."			# You don't need to pass any option, the installation is straightforward
foreach ( $installer in $simple_installers ) {
	Write-Host ("Installing " + $installer + "...")
	Start-Sleep -Seconds $installationDelay

	if ($blocking) {
		Start-Process ($programs_path + $installer) -Wait
	} else {
		Start-Process ($programs_path + $installer)
	}
	
	Write-Host "Installation completed."
}

Write-Host "Running installers..."
foreach ( $installer in $installers ) {
	Write-Host ("Installing " + $installer + "...")
	Start-Sleep -Seconds $installationDelay
	#Start-Process ($programs_path + $installer) -Wait # -ArgumentList "/quiet /passive /norestart INSTALLDIR=C:\Program Files\My Program"
	Start-Process ($programs_path + $installer) -Wait -ArgumentList "/quiet /passive /norestart"
	Write-Host "Installation completed."
}

# Ad hoc installation commands
Write-Host "Starting ad hoc installations..."

# Adobe reader
Write-Host "Installaling Adobe Reader..."
Start-Sleep -Seconds $installationDelay
Start-Process ($programs_path + $AcrobatReader) -Wait -ArgumentList '/g IT /sl "1040" /sAll'

# Sophos
Write-Host "Installaling Sophos..."
Start-Sleep -Seconds $installationDelay
Start-Process ($programs_path + $Sophos) -Wait -ArgumentList "--quiet --dumpfeedback"
# Start-Process ($programs_path + $Sophos) -Wait -ArgumentList "--quiet --nofeedback"
Write-Host "Installation completed."

# Olivetti driver
Write-Host "Installaling Olivetti driver..."
Start-Sleep -Seconds $installationDelay
Start-Process "\\192.168.98.4\condivisa\Driver e software\Kx82_UPD_Olivetti\KXDriver\KmInstall.exe"
Write-Host "Installation completed."
