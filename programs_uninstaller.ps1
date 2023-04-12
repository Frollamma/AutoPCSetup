$programs = @(
	"Microsoft 365",
	"OneDrive",
	"OneNote",
	"Office"# Office 16
)

$apps = @(
	"McAfeeSecurity",
	"Spotify",
	"myHP",
	"Minecraft",
	"OneDrive",
	"OneNote"
)

foreach ($program in $programs) {
	$program_obj = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*$program*" }
	$program_obj.Uninstall()
}

foreach ($app in $apps) {
	Get-AppxPackage | Where-Object { $_.Name -like "*$app*" } | Remove-AppxPackage
}

