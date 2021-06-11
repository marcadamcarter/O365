# O365 PowerShell One-liners, Scripts and such

## Table of Contents
+ [Get Microsoft Teams Memberships.ps1](#GetTeamsMemberships)
+ [Import Members into a Team.ps1](#ImportTeamMembers)
+ [Query O365 User Accounts.ps1](#QueryO365UserAccounts)
\
\
\
&nbsp;
## Get Microsoft Teams Memberships.ps1 <a name = "GetTeamsMemberships"></a>
#### Description
A collection of PowerShell one-line commands to query AzureAD, gather a specified user's Teams Memberships and export each Team's members into an individual comma separated value (CSV) file.

#### Requires 
 + [Azure Active Directory PowerShell for Graph module](https://docs.microsoft.com/en-us/powershell/module/azuread/?view=azureadps-2.0#azuread)
 + A local computer account with sufficient rights to load modules in a PowerShell session

#### Usage
+ Note: Replace the email alias of the individual to search - e.g. "startswith(Mail, 'first.m.last.ptc')"
```powershell
$objID = Get-AzureADUser -Filter "startswith(Mail,'joe.p.user')" | Select-Object ObjectId
```
![Demo console session](../Assets/GetTeamsMemberships.png?raw=true)
+ One CSV file will be exported, to your Downloads folder, for each Team the specific user is a member of - i.e. `C:\Users\joe.user\Downloads\niffty network team bravo.csv`  
\
\
\
&nbsp;
## Import Members into a Team.ps1 <a name = "ImportTeamMembers"></a>
#### Description
A collection of PowerShell one-line commands to search AzureAD for a Microsoft Team and import Team members from a comma separated value (CSV) file.

#### Requires 
 + [Azure Active Directory PowerShell for Graph module](https://docs.microsoft.com/en-us/powershell/module/azuread/?view=azureadps-2.0#azuread)
 + A local computer account with sufficient rights to load modules in a PowerShell session
 + __Existing Microsoft Team*__
 + __Owner Role in target Team*__

#### Usage
+ Note: -Filter parameter uses oData v3.0 search to perform a (begins with) string search on Team Display Name - e.g. `"startswith(DisplayName, 'Niffty Network')"`
+ Ref: [oData 3.0 String Functions](https://www.odata.org/documentation/odata-version-3-0/odata-version-3-0-core-protocol/)
```powershell
Get-AzureADGroup -Filter "startswith(DisplayName,'Niffty Group')"
```
+ Replace `<GUID>` with the ObjectId of the target (gaining) Team returned from results of `Get-AzureADGroup` that you wish to import members to.
```powershell
$objID = Get-AzureADGroup -ObjectId <GUID> | Select-Object ObjectId
```
\
\
\
&nbsp;
## Query O365 User Accounts.ps1 <a name = "QueryO365UserAccounts"></a>
#### Description
Collection of PowerShell one-line commands to query AzureAD for specific user accounts.

#### Requires 
 + [Azure Active Directory PowerShell for Graph module](https://docs.microsoft.com/en-us/powershell/module/azuread/?view=azureadps-2.0#azuread)
 + A local computer account with sufficient rights to load modules in a PowerShell session

#### Usage
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

