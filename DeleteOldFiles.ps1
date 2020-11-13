$Folder = "C:\Users\nabeelp\Downloads\Temp\To Delete"

#Delete files older than 6 months
Get-ChildItem $Folder -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-90)} |
ForEach-Object {
   $_ | del -Force -Recurse
   $_.FullName | Out-File .\deletedlog.txt -Append
}

#Delete empty folders and subfolders
Get-ChildItem $Folder -Recurse -Force -ea 0 |
? {$_.PsIsContainer -eq $True} |
? {$_.getfiles().count -eq 0} |
ForEach-Object {
    $_ | del -Force -Recurse
    $_.FullName | Out-File .\deletedlog.txt -Append
}