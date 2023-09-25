#Check latest time of a Windows Event on serveral remote server
$computers = "SERVER1", "SERVER2", "SERVER3";

foreach($computer in $computers)
{
    Write-Output "$computer"
    $eventtime = Invoke-Command -ComputerName $computer -ScriptBlock{Get-WinEvent -FilterHashtable @{logname="application"; id="10990"}} | sort timecreated -des | select -First 1 | Select TimeCreated 
    Write-Output "Last 10990 event time: $eventtime" 
    Write-Output " "
}