# O365 PowerShell Scripts

## Table of Contents
+ [Query O365 User Accounts.ps1](#QueryO365UserAccounts)

## Query O365 User Accounts.ps1 <a name = "QueryO365UserAccounts"></a>
### Description
Collection of PowerShell one-line commands to query AzureAD for specific user accounts.

### Requires 
 + [Azure Active Directory PowerShell for Graph module](https://docs.microsoft.com/en-us/powershell/module/azuread/?view=azureadps-2.0#azuread)
 + An account with Administrator rights is required to install modules

### Usage
+ Note: Replace <email_alias> with the email alias of the individual to search - e.g. "startswith(Mail, 'first.m.last.ptc')"
+ Query Single User

```powershell
Get-AzureADUser -Filter "startswith(Mail,'<email_alias>')" | Select-Object AccountEnabled, Department, MailNickName, Mail, UserType, @{l='ForceChangePasswordNextLogin';e={$_.PasswordProfile.ForceChangePasswordNextLogin}}

# Select All Properties
Get-AzureADUser -Filter "startswith(Mail,'<email_alias>')" | Select-Object *
```
+ Query Query Multiple Users

```powershell
# Create a single-column CSV file containing the email alias (i.e. 'email alias' is everything before the @ sign).
# Import CSV and execute the Get-AzureADUser cmdlet against each record
# $csv[0] - should return first record from your CSV, similar to the following
# mail
# ----
# first.m.last.ptc

$csv = Import-Csv -Path '<path-to-csv-file>'

$csv | ForEach-Object { Get-AzureADUser -Filter "startswith(Mail,'$($_.mail)')" | Select-Object @{l='ForceChangePasswordNextLogin';e={$_.PasswordProfile.ForceChangePasswordNextLogin}}, AccountEnabled, Department, MailNickName, Mail, UserType } | Out-GridView

```

### Notes
| Property | Description |
| ---- | ---- | 
| ForceChangePasswordNextLogin | If set to true the account is inactive and password must be changed at next login |
| AccountEnabled | boolean (true/false) |  

