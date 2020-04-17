##Requires -RunAsAdministrator
$pathToRemote = '\\192.168.0.2\install\Keepass2'
$pathToLocal = 'C:\Users\PATH'

$ParaDelete = @{
Path= $pathToLocal
recurse= 1
force = 1
}

$ParaCopy = @{
Path = $pathToRemote
Destination = $pathToLocal
recurse = 1

}


function testRemote
{
    if(-not(test-path $pathToRemote))
    {
        return 0
    }
    Return 1
}

function deleteLocal
{
    remove-item @ParaDelete
}

function updateFromRemote
{
    copy @ParaCopy
}




$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

if (  ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) )
{
    if(testRemote = 1)
    {
        deleteLocal
        updateFromRemote
    }
    else
    {
        Write-Error "Es besteht keine Verbindung zum Heimat Netzlaufwerk es kann nur Lokal gearbeitet werden!"
        PAUSE
    }
    .'C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe'
}
else
{
    #write-error 'Es werden Administratorrechte ben�tigt'
    Start-Process -FilePath "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -ArgumentList "-Command", "&","'C:\Users\Cossacks\KP\Scripts\start Keepass.ps1'" -Verb runAs
    #PAUSE
}



#remove-item -Recurse -Force C:\Users\Cossacks\KP\Keepass2\
#copy \\192.168.0.2\install\Keepass2 C:\Users\Cossacks\KP\  -recurse
#.'C:\Program Files (x86)\KeePass Password Safe 2\KeePass.exe'
