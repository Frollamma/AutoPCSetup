param (
	[int]$installation_delay = 300
)

$base_path = "\\NASCLOUD\FileServer$\lucibello.fra\"
$programs_path = $base_path + "programs\"

$WindowsPCHealthCheck = "WindowsPCHealthCheckSetup.msi"
$Chrome = "ChromeSetup.exe"
$GoSign = "GoSign-Desktop-installer-win32.msi"
$Java = "jre-8u181-windows-i586"
$LibreOffice = "LibreOffice.msi"
$AcrobatReader = "readerdc64.exe"
$Simel = "Simel Maggioli Quarto.jnlp"
$TeamViewerClient = "TeamViewerQS-idc3gq7dvg.exe"
$WinRAR = "winrar-x64-620it.exe"
$Sophos = "SophosSetup.exe"

$programs = @(
	$Simel,
	$TeamViewerClient
)

$simple_installers = @(
	$Chrome,
	$Java,
	$AcrobatReader,
	$WinRAR
)

$installers = @(
	$WindowsPCHealthCheck,
	$GoSign,
	$LibreOffice
)

Write-Host "Copying portable programs in Desktop..." 
foreach ( $program in $programs ) {
	cp ($programs_path + $program) .	# "%UserProfile%\Desktop" doesn't work
	Start-Sleep -Seconds $installation_delay
}

Write-Host "Running simple installers..."			# You don't need to pass any option, the installation is straightforward
foreach ( $installer in $simple_installers ) {
	Write-Host ("Installing " + $installer + "...")
	Start-Process ($programs_path + $installer) -Wait
	Write-Host "Installation completed."
	Start-Sleep -Seconds $installation_delay
}

Write-Host "Running installers..."
foreach ( $installer in $installers ) {
	Write-Host ("Installing " + $installer + "...")
	#Start-Process ($programs_path + $installer) -Wait # -ArgumentList "/quiet /passive /norestart INSTALLDIR=C:\Program Files\My Program"
	Start-Process ($programs_path + $installer) -Wait -ArgumentList "/quiet /passive /norestart"
	Write-Host "Installation completed."
	Start-Sleep -Seconds $installation_delay
}

# Ad hoc installation commands

Start-Process ($programs_path + $Sophos) -Wait -ArgumentList "--quiet --nofeedback --dumpfeedback"