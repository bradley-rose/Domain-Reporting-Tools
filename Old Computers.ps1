#This script when executed will pull a list from AD of all computer objects that have not recorded a logon event within the last six months, and exports this into a CSV on your desktop titled "Old_Computers.csv".
#This script must be executed as an administrator (Start Menu > Powershell_ise.exe > File > Open > Select this file > Press the green play button in the toolbar)
#ALLOW APPROXIMATELY 5-10 SECONDS FOR THE SCRIPT TO EXECUTE. 
#Created by Bradley Rose, October 2nd 2017.

Import-Module ActiveDirectory #Imports the AD Toolset into the Powershell session.

$loggeduser = (Get-WMIObject -class Win32_ComputerSystem | select -expand username) #These two lines of code pull the current logged in user, not the support/admin account used to open the session.
$loggeduser = $loggeduser.Substring(6)

$Date = (Get-Date).AddDays(-365) #Subtracts six months from the current date.

Get-ADComputer -Filter {LastLogonTimeStamp -lt $Date} -Properties LastLogonTimeStamp,Description | Select-Object Name,Description,@{Name="Last Logon"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}} | Export-Csv "C:\Users\$loggeduser\Desktop\Old_Computers.csv"
#Queries AD for all computer objects that have not recorded a logon within six months. Pulls timestamp and description information, and formats them into a CSV exported on your desktop titled "Old_Computers.csv".