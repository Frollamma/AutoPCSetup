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
	"Users\" + $user + "\Documents\",
	"Users\" + $user + "\Download\"
)

foreach ($dir in $directories) {
	$dir = "\\$ip\$drive$\$dir"

	# Write-Host "Copying " + $dir
	# copy /y ("\\" + $ip + "\c$\" + $dir + "\*") $dir
	Write-Host "Zipping $dir"
	$zipDir = $dir + ".rar"
	$command = "& `'$winrarPath`' a `'$zipDir`' `'$dir`'"
	Start-Process -FilePath "powershell.exe" -ArgumentList $command -Wait
}
