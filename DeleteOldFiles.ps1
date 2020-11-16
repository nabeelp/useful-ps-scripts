$Folder = "C:\Users\nabeelp\Downloads\Temp\To Delete"
$LogFile = "C:\Repos\GitHub\nabeelp\useful-ps-scripts\deletedlog.txt"

#Delete files older than 6 months
Get-ChildItem $Folder -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-90)} |
ForEach-Object {
   $_ | del -Force -Recurse
   $_.FullName | Out-File $LogFile -Append
   Write-Output ("Deleted File: " + $_.FullName)
}

#Delete empty folders and subfolders
Get-ChildItem $Folder -Recurse -Force -ea 0 |
? {$_.PsIsContainer -eq $True} |
? {$_.getfiles().count -eq 0} |
ForEach-Object {
    $_ | del -Force -Recurse
    $_.FullName | Out-File $LogFile -Append
    Write-Output ("Deleted Folder: " + $_.FullName)
}