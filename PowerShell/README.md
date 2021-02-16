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
+ Replace <email_alias> with the email alias of the individual to search - e.g. "startswith(Mail, 'first.m.last.ptc')"

### Notes
+ 'ForceChangePasswordNextLogin' = if set to true, the account is inactive
+ 'AccountEnabled' = boolean (true/false)  
