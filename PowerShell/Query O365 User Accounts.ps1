Install-Module -Name AzureAD
Import-Module AzureAD
Connect-AzureAD

#The following PowerShell one-liner should query which ever environment you connect to (CVR or IL5).
Get-AzureADUser -Filter "startswith(Mail,'<email_alias>')" | Select-Object AccountEnabled, Department, MailNickName, Mail, UserType
#Note:  replace <email_alias> with the email alias of the individual to search - e.g. "startswith(Mail, 'first.m.last.ptc')"
 
<# 
Alternatives to query multiple individuals -
• Create a single-column CSV file containing the email alias (i.e. everything before the @ sign).
• Execute the following (PowerShell cmdlets)
#>
$csv = Import-Csv '<path-to-your-csv-file>'
$csv[0] 
# Should return first record from your CSV, similar to the following
# mail
# ----
# first.m.last.ptc
$csv | ForEach-Object { Get-AzureADUser -Filter "startswith(Mail,'$($_.mail)')" | Select-Object AccountEnabled, Department, MailNickName, Mail, UserType } | Out-GridView