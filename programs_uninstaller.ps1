$programs = @(
	"Microsoft 365",
	"Microsoft OneDrive",
	"Microsoft OneNote"
)

$apps = @(
	"McAfeeSecurity",
	"Spotify",
	"myHP",
	"Minecraft"
)

foreach ($program in $programs) {
	$program_obj = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*$program*" }
	$program.Uninstall()	
}

foreach ($app in $apps) {
	Get-AppxPackage | Where-Object { $_.Name -like "*$app*" } | Remove-AppxPackage
}

