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
	"Users\$user\Documents\",
	"Users\$user\Download\"
)

foreach ($dir in $directories) {
	$path = "\\$ip\$drive$\$dir"
	$backupPath = "C:\scanner"

	# Write-Host "Copying " + $path
	# copy /y ("\\" + $ip + "\c$\" + $path + "\*") $path
	Write-Host "Zipping $path"
	$zipDir = $path + ".rar"
	$command = "& `'$winrarPath`' a `'$zipDir`' `'$path`'"
	Start-Process -FilePath "powershell.exe" -ArgumentList $command -Wait
	
	Write-Host "Copying $path to $backupPath"
}
