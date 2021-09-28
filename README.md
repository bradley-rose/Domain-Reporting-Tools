# AD Reporting Script Information
To run these, call them from CMD or Powershell as a domain administrator with appropriate access, or run them from PowerShell_ISE. Wait 5-10s after execution, and check on your desktop for the appropriate file. 
**Note**: These were initially purpose-built for a domain I previously administered at a prior place of employment. There may have to be minor changes made to the scripts (such as the `$loggeduser` variable which is only used for placing the final output file on your desktop) in order for it to work with other domains.

AD Account Expiration:
This script automatically generates a report on your desktop titled "ExpiredUsers.csv" that displays all expired users in the domain. 

inactiveUsers:
Reports all users that have no recorded a logon in 365 days or longer to a file on your desktop titled inactiveUsers.csv

Old Computers:
Reports all computers that have not recorded a logon in one year or longer to a file on your desktop titled Old_Computers.csv

Users To Expire In One Month:
Reports all users set to expire within the next month to a files on your desktop titled usersToExpireSoon.csv
