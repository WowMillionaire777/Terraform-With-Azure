$LoginName="sqladmin"
$LoginPassword="Azure@1234"
$DatabaseName="appdb"
$ServerName="dbvm"
$DBQuery="CREATE DATABASE appdb"


Invoke-SqlCmd -ServerInstance $ServerName -U $LoginName -p $LoginPassword -Query $DBQuery


$LoginName="sqladmin"
$LoginPassword="Azure@1234"
$ServerName="dbvm"
$DatabaseName="appdb"
$ScriptFile="https://vmstore4577687.blob.core.windows.net/scripts/01.sql"
$Destination="D:\01.sql"


Invoke-WebRequest -Uri $ScriptFile -OutFile $Destination
Invoke-SqlCmd -ServerInstance $ServerName -InputFile $Destination -Database $DatabaseName -Username $LoginName -Password $LoginPassword


