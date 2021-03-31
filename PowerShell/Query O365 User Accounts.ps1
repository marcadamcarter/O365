# Log on to the computer with an account that has Administrator rights
Install-Module -Name AzureAD -Scope CurrentUser
Import-Module AzureAD
Connect-AzureAD

# Query single user
Get-AzureADUser -Filter "startswith(Mail,'<email_alias>')" | Select-Object AccountEnabled, Department, MailNickName, Mail, UserType, @{l='ForceChangePasswordNextLogin';e={$_.PasswordProfile.ForceChangePasswordNextLogin}}


# Query Multiple Users -
$csv = Import-Csv -Path <path_to_file>
$csv | ForEach-Object { Get-AzureADUser -Filter "startswith(Mail,'$($_.mail)')" | Select-Object AccountEnabled, Department, MailNickName, Mail, UserType, @{l='ForceChangePasswordNextLogin';e={$_.PasswordProfile.ForceChangePasswordNextLogin}} } | Out-GridView