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
	$program_objs = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*$program*" }

	foreach ($program_obj in $program_objs) {
		$program_obj.Uninstall()
	}
	
	$program_obj = Get-Package -Provider Programs -IncludeWindowsInstaller | Where-Object { $_.Name -like "*$program*" }

	foreach ($program_obj in $program_objs) {
		Uninstall-Package -Name $program_obj.Name
	}
}

foreach ($app in $apps) {
	Get-AppxPackage | Where-Object { $_.Name -like "*$app*" } | Remove-AppxPackage
}

