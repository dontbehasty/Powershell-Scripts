#Check status of Windows Service on several remote server
$computers = "SERVER1", "SERVER2", "SERVER3";

foreach($computer in $computers)
{
    Get-Service -ComputerName $server | Where{$_. Name -eq "servicename"}| Select MachineName, Name, Status
}