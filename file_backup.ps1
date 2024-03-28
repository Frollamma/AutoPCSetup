param (
	[string]$ip,
	[string]$user,
	[string]$drive = "C"
)

$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"


$directories = @(
	"scanner",
	"Users\$user\Desktop",
	"Users\$user\Documents",
	"Users\$user\Downloads",
	"Users\$user\Pictures"
)

foreach ($dir in $directories) {
	$path = "\\$ip\$drive$\$dir"
	$backupPath = "C:\backup"

	# Creates backup folder if it doesn't exist
	if (-not (Test-Path -Path $backupPath)) {
		New-Item -ItemType Directory -Path $backupPath | Out-Null
	}


	$archive = $path + ".rar"
	Write-Host "Zipping $path to $archive"

	$command = "& `'$winrarPath`' a `'$archive`' `'$path`'"
	Start-Process -FilePath "powershell.exe" -ArgumentList $command -Wait
	
	Write-Host "Moving $archive to $backupPath"
	Move-Item -Path $archive -Destination $backupPath
}
