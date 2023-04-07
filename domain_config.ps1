$domainName = "comune.local"
$credential = Get-Credential # IMPR: This prompts you to insert the password, we want to automate this, but we don't want to store passwords in plain text

Add-Computer -DomainName $domainName -Credential $credential # You can add "-Restart" to restart the PC


# IMPR: The following code uses password in plain text
# $domainName = "comune.local"
# $username = "comune.local\username"
# $password = ConvertTo-SecureString "password" -AsPlainText -Force
# $credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Add-Computer -DomainName $domainName -Credential $credential # If you want you can add "-Restart -Force"
