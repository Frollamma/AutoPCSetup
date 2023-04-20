param (
    [string[]]$driveNames = @("Disco K"),
    [string[]]$driveLetters = @("K"),
    [string[]]$cloudPaths = @("\\NASCLOUD\condivisa")
)

for ($i = 0; $i -lt $driveNames.Count; $i++) {
    $driveName = $driveNames[$i]
    $driveLetter = $driveLetters[$i]
    $cloudPath = $cloudPaths[$i]

    New-PSDrive -Name $driveName -PSProvider "FileSystem" -Root $cloudPath -Persist -Scope Global

    if (Test-Path "$driveLetter`:") {
        Write-Host "Drive $driveName added successfully"
    }
    else {
        Write-Host "Failed to add drive $driveName"
    }
}


# I don't think this will work
# New-PSDrive -Name $driveLetter -PSProvider FileSystem -Root $cloudPath

# $volume = Get-Volume -FileSystemLabel "PSDrive $driveLetter"
# Set-Volume -DriveLetter $volume.DriveLetter -NewFileSystemLabel "K"

