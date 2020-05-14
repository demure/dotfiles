## vim
New-Alias -Name vi -Value 'C:\Program Files (x86)\vim\vim82\vim.exe'
New-Alias -Name vim -Value 'C:\Program Files (x86)\vim\vim82\vim.exe'

## readline
Set-PSReadLineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

## du function
Function du {
  gci . | %{$f=$_; gci -r -file $_.FullName | measure-object -property length -sum | select  @{Name="Name"; Expression={$f}}, @{Name="Sum (MB)"; Expression={"{0:N3}" -f ($_.sum / 1MB) }}, Sum } | sort Sum -desc |format-table -Property Name,"Sum (MB)", Sum -autosize
}

## Admin test
Function Test-IsAdmin {

 $user = [Security.Principal.WindowsIdentity]::GetCurrent();
 (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
 }

## Modify title if admin
Function Admin-Test {
  ## From https://serverfault.com/a/95464
  $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
  $IsAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

 if(-not ($IsAdmin))
  {$Host.ui.RawUI.WindowTitle = "Regular User PowerShell"}
 else {$Host.ui.RawUI.WindowTitle = "**ADMIN** User PowerShell!"}
}
Admin-Test

## func to read chrome history
## set $username manually?
function get-chromehistory {
    $path = "$env:systemdrive\users\$username\appdata\local\google\chrome\user data\default\history"
    if (-not (test-path -path $path)) {
        write-verbose "[!] could not find chrome history for username: $username"
    }
    $regex = '(htt(p|s))://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?'
    $value = get-content -path "$env:systemdrive\users\$username\appdata\local\google\chrome\user data\default\history"|select-string -allmatches $regex |% {($_.matches).value} |sort -unique
    $value | foreach-object {
        $key = $_
        if ($key -match $search){
            new-object -typename psobject -property @{
                user = $username
                browser = 'chrome'
                datatype = 'history'
                data = $_
            }
        }
    }
}
