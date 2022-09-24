# auto-suggestion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# environment configuration
Invoke-Expression (&starship init powershell)

if($IsWindows) {
    Invoke-Expression (& { (lua $HOME\scoop\apps\z.lua\current\z.lua --init powershell) -join "`n" })
}
