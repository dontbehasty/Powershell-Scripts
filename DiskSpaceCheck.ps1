#Check Disk Space on several remote servers
$computers = @("SERVER1", "SERVER2", "SERVER3");

foreach($computer in $computers)
{
    $disks Get-WmiObject Win32_LogicalDisk -ComputerName $computer -Filter DriveType=3 |
        Select-Object DeviceID,
            @{'Name'='Size'; 'Expression'={[math]::truncate($_.size / 1GB)}}, 
            @{'Name'='Freespace'; 'Expression'={[math]:: truncate($_. freespace / 1GB)}}

    $computer

    foreach($disk in $disks)
    {
        $disk. DeviceID + $disk. FreeSpace.ToString("NO") + "GB / " + $disk. Size.ToString("NO") + "GB"
    }
}