param (
	[Parameter(Mandatory=$true)][string]$ip,
	[Parameter(Mandatory=$true)][string]$user,
	[string]$drive = "C"
)

$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"
$backupPath = "C:\backup"

$directories = @(
	"scanner",
	"Users\$user\Desktop",
	"Users\$user\Documents",
	"Users\$user\Downloads",
	"Users\$user\Pictures"
)

# Creates backup folder if it doesn't exist
if (-not (Test-Path -Path $backupPath)) {
	New-Item -ItemType Directory -Path $backupPath | Out-Null
}

$processes = @()
foreach ($dir in $directories) {
    $path = "\\$ip\$drive$\$dir"
    $archive = $path + ".rar"
    Write-Host "Zipping $path to $archive"
    $command = "& `'$winrarPath`' a `'$archive`' `'$path`'"
    $process = Start-Process -FilePath "powershell.exe" -ArgumentList $command -PassThru
    $processes += $process
}
# Wait for all processes to complete
$processes | Wait-Process

foreach ($dir in $directories) {
	$path = "\\$ip\$drive$\$dir"
	$archive = $path + ".rar"

	Write-Host "Moving $archive to $backupPath"
	Move-Item -Path $archive -Destination $backupPath
}


# If I remember correctly, there's a bug that doesn't zip the subdirectories of a directly. - IMPR