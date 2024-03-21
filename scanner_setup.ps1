param (
    [string]$folderPath = "C:\scanner",
    [string]$userName = "scanner2"
)

# Ensure the user name includes the domain
$userName = "COMUNE.LOCAL\$userName"

# Check if the folder already exists
if (-Not (Test-Path -Path $folderPath)) {
    # Create the folder if it does not exist
    New-Item -ItemType Directory -Path $folderPath
    Write-Output "Folder created at $folderPath."
} else {
    Write-Output "Folder already exists at $folderPath."
}

# Prepare the share name and user
$shareName = (Get-Item $folderPath).Name

# Check if the SMB share already exists
$existingShare = Get-SmbShare -Name $shareName -ErrorAction SilentlyContinue

if ($existingShare) {
    Write-Output "Share '$shareName' already exists. Updating permissions."
    # Update the permissions for the existing share
    Grant-SmbShareAccess -Name $shareName -AccountName $userName -AccessRight Full -Force
} else {
    # Share does not exist, attempt to create it
    try {
        New-SmbShare -Name $shareName -Path $folderPath -FullAccess $userName
        Write-Output "Folder '$folderPath' is now shared with user '$userName'."
    } catch {
        Write-Error "Failed to share folder '$folderPath' with user '$userName'. Error: $_"
    }
}

# Get the current ACL for the folder
$Acl = Get-Acl $folderPath

# Define the permission set
$permission = "$userName", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow"

# Create the new access rule
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission

# Add the access rule to the ACL
$Acl.SetAccessRule($AccessRule)

# Apply the ACL to the folder
Set-Acl -Path $folderPath -AclObject $Acl

Write-Output "NTFS permissions set for user '$userName' on folder '$folderPath'."


# In case something goes wrong you can use:
# Remove-SmbShare -Name "scanner" -Force