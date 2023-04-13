# Create a scanner folder in C drive and share it with Read/Write permissions with user scanner2

$folderPath = "C:\Scanner"

# Create the folder if it doesn't already exist
if (!(Test-Path -Path $folderPath -PathType Container)) {
    New-Item -ItemType Directory -Path $folderPath
}

# Share the folder with read/write permissions for the user "scanner2"
New-SmbShare -Name "Scanner" -Path $folderPath -FullAccess "scanner2"
