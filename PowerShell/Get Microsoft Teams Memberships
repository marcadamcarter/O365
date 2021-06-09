# Query Microsoft Teams
Import-Module AzureAD -Scope CurrentUser # Import necessary PowerShell Module
Connect-AzureAD 

#Grab the user's ObjectID (use email alias)
$objID = Get-AzureADUser -Filter "startswith(Mail,'joe.p.user')" | Select-Object ObjectId

#Grab the user's Team Memberships
Get-AzureADUserMembership -ObjectId $objID.ObjectId

#Export members from each Team to spreadsheet
foreach($grp in (Get-AzureADUserMembership -ObjectId $objID.ObjectId)){ Get-AzureADGroupMember -ObjectId $grp.ObjectId | Select MailNickName, AccountEnabled, DisplayName | Export-Csv -Path "C:\Users\joe.user\Downloads\$($grp.DisplayName).csv" -NTI}
