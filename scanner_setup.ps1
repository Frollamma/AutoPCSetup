# Create a scanner folder in C drive and share it with Read/Write permissions with user scanner2

$folderPath = "C:\scanner"

# Create the folder if it doesn't already exist
if (!(Test-Path -Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $folderPath
}

# Share the folder with read/write permissions for the user "scanner2"
New-SmbShare -Name "scanner" -Path $folderPath -FullAccess "scanner2"


# i tied https://4sysops.com/archives/managing-windows-file-shares-with-powershell/ and it doesn't work