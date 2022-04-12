Import-Module ActiveDirectory
#######################################
# 1. Create an AD Account for our sqlmi
#######################################
# Create OU - not an Arc requirement but nice to show since everyone uses it
# Arc SQL MI Users can be in any OU
New-ADOrganizationalUnit -Name "arcou" -Path "DC=CONTOSO,DC=LOCAL"

$pass = "arc@123!!" | ConvertTo-SecureString -AsPlainText -Force
New-ADUser -Name "arcaduser" `
           -UserPrincipalName "arcaduser@contoso.local" `
           -Path "OU=arcou,DC=CONTOSO,DC=LOCAL" `
           -AccountPassword $pass `
           -Enabled $true `
           -ChangePasswordAtLogon $false `
           -PasswordNeverExpires $true


################
# 2. Create SPNs
################
setspn -S MSSQLSvc/arcaduser.contoso.local arcaduser
setspn -S MSSQLSvc/arcaduser.contoso.local:31433 arcaduser
