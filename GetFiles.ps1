#Check folder on remote servers for failed files
$computers = "SERVER1", "SERVER2", "SERVER3"; 

foreach($computer in $computers)
{
    if (Invoke-Command -ComputerName $computer {(Get-ChildItem -Path "C:\Test" -Filter *.failed | Measure-Object). Count -eq 0}) 
    { 
        Write-Output "$computer - No failed files found"
        Write-Output " "
    }
    else
    {
        $failedfiles = Invoke-Command -ComputerName $computer {(Get-ChildItem -Path "C:\Test" -Filter *. failed -Name)}
        Write-Output "$computer - Failed Files:"
        Write-Output $failedfiles
        Write-Output " "
    }
}