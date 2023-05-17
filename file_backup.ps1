# Run this in C:\

param (
	[string]$ip,
	[string]$user
)

$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"
$drive = "C"

$directories = @(
	"scanner",
	#	"Users\" + $user + "\Desktop\",
	"Users\$user\Documents",
	"Users\$user\Downloads"
)

foreach ($dir in $directories) {
	$path = "\\$ip\$drive$\$dir"
	$backupPath = "C:\scanner"

	$archive = $path + ".rar"
	Write-Host "Zipping $path to $archive"

	$command = "& `'$winrarPath`' a `'$archive`' `'$path`'"
	Start-Process -FilePath "powershell.exe" -ArgumentList $command -Wait
	
	Write-Host "Copying $path to $backupPath"
}
