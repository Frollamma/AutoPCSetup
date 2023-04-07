$base_path = "\\NASCLOUD\FileServer$\lucibello.fra\"
$programs_path = $base_path + "programs\"

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
	$AcrobatReader,
	$WinRAR
)

$installers = @(
	$GoSign,
	$Java,
	$LibreOffice,
	$Sophos
)

Write-Host "Copying portable programs..." 
foreach ( $program in $programs ) {
    cp ($programs_path + $program) .
}

Write-Host "Running simple installers..."			# You don't need to pass any option, the isntallation is straightforward
foreach ( $installer in $simple_installers ) {
	Write-Host ("Installing " + $installer)
	Start-Process ($programs_path + $installer) -Wait
	Write-Host "Installation completed."
}

Write-Host "Running installers..."
foreach ( $installer in $installers ) {
	Write-Host ("Installing " + $installer)
	Start-Process ($programs_path + $installer) -Wait # -ArgumentList "/quiet /passive /norestart INSTALLDIR=C:\Program Files\My Program" -Wait
	Write-Host "Installation completed."
}
