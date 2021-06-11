# Team must be manually created in order to import users
# Script is written so that each line can be copied and pasted into a PowerShell console session or the script can be run in it's entirety
# Query Microsoft Teams
Import-Module AzureAD -Scope CurrentUser # Import necessary PowerShell Module
Connect-AzureAD -AzureEnvironmentName <AzureADName>

# Display a list of Teams
Get-AzureADGroup -Filter "startswith(DisplayName,'Niffty Network')"

# Grab new Team ObjectId
$objID = (Get-AzureADGroup -ObjectId <GUID> | Select-Object ObjectId).ObjectId

# Grab members of an old Team and import into new Team
# Refer to CSV file in https://github.com/marcadamcarter/O365/blob/794444e9d3d74d115b95517f39b601bb247737ef/PowerShell/Get%20Microsoft%20Teams%20Memberships.ps1#L12
$members = Import-Csv -Path 'C:\Users\joe.user\Downloads\niffty network team bravo.csv'
foreach($mbr in $members){ Add-AzureADGroupMember -ObjectID $objID -RefObjectId (Get-AzureADUser -ObjectID $mbr.MailNickName).ObjectID }
