# Run this in C:\

param (
    [string]$ip,
    [string]$user
)

$directories = @(
	"scanner",
#	"Users\" + $user + "\Desktop\",
	"Users\" + $user + "\Documents\",
	"Users\" + $user + "\Download\"
)

foreach ($dir in $directories) {
	Write-Host "Copying " + $dir
	copy /y ("\\" + $ip + "\c$\" + $dir + "\*") $dir
}
