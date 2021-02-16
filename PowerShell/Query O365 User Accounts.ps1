# Log on to the computer with an account that has Administrator rights
Install-Module -Name AzureAD
Import-Module AzureAD
Connect-AzureAD

# Query single user
Get-AzureADUser -Filter "startswith(Mail,'<email_alias>')" | Select-Object AccountEnabled, Department, MailNickName, Mail, UserType, @{l='ForceChangePasswordNextLogin';e={$_.PasswordProfile.ForceChangePasswordNextLogin}}
 
<# 
Alternative: Query Multiple Users -
• Create a single-column CSV file containing the email alias (i.e. 'email alias' is everything before the @ sign).
• Import CSV and execute the Get-AzureADUser cmdlet against each record
#>
$csv = Import-Csv '<path-to-your-csv-file>'
$csv[0] 
# Should return first record from your CSV, similar to the following
# mail
# ----
# first.m.last.ptc
$csv | ForEach-Object { Get-AzureADUser -Filter "startswith(Mail,'$($_.mail)')" | Select-Object AccountEnabled, Department, MailNickName, Mail, UserType, @{l='ForceChangePasswordNextLogin';e={$_.PasswordProfile.ForceChangePasswordNextLogin}} } | Out-GridView