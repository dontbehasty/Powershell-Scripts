#Count Number of active ports on several remote servers
$computers = "SERVER1", "SERVER2", "SERVER3";

foreach($computer in $computers)
{
    #Write results to text file on each server
    Invoke-Command -ComputerName $computer {(netstat -aon > "C:\Users\$env:UserName\Documents\port-list.txt")} 
    
    #Get count of all the active ports
    $portcount = Invoke-Command -ComputerName $computer {(netstat -aon | Select-String -Pattern 'TCP' , 'UDP' | Measure-Object).COUNT}
    Write-Output "$computer"
    Write-Output "Active Port Count: $portcount"

    #Get Process ID
    $getpid = Invoke-Command -ComputerName $computer {(Get-CimInstance -Query 'Select from Win32_Process where Name = "agent.exe"' | Select-Object -Property ProcessId). ProcessId} 
    
    #Get count of the active ports for specific Process ID
    $pidcount = Invoke-Command -ComputerName $computer {(netstat -aon | Select-String -Pattern $Using:getpid | Measure-Object).COUNT}
    Write-Output "PID ($getpid) Port Count: $pidcount"
    Write-Output " "
}