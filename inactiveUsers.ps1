#This script when executed will run a query against AD to pull all inactive AD accounts and export them to a CSV on your desktop titled "inactiveUsers.csv".
#This script must be executed as an administrator (Start Menu > Powershell_ise.exe > File > Open > Select this file > Press the green play button in the toolbar)
#ALLOW APPROXIMATELY 5-10 SECONDS FOR THE SCRIPT TO EXECUTE.
#Created by Bradley Rose, October 2nd 2017.

Import-Module ActiveDirectory #Imports the AD Toolset into the Powershell session.

$loggeduser = (Get-WMIObject -class Win32_ComputerSystem | select -expand username) #These two lines of code pull the current logged in user, not the support/admin account used to open the session.
$loggeduser = $loggeduser.Substring(6)

$Date = (((Get-Date).AddDays(-365)).ToUniversalTime()).Ticks - ([DateTime]"January 1, 1601").Ticks #Converts the date to the value that LDAP uses to calculate its queries.

Get-ADUser -LDAPFilter "(&(objectCategory=person)(objectClass=user)(lastLogonTimeStamp<=$Date))" -Properties DisplayName,Description,lastLogonTimeStamp,HomeDirectory,AccountExpirationDate | Select-Object DisplayName,Description,@{Name="Last Logon"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}},HomeDirectory,AccountExpirationDate | Export-Csv "C:\Users\$loggeduser\Desktop\inactiveUsers.csv"
#The above line queries all AD users that have not logged on in 1 year and exports their names, descriptions, homedirectories, and expiration dates to a CSV on your desktop titled "inactiveUsers.csv"