# auto-suggestion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# env-specified settings
if($IsMacOS) {
    $(/opt/homebrew/bin/brew shellenv) | Invoke-Expression
}

# environment configuration
Invoke-Expression (&starship init powershell)

# last execution
Invoke-Expression (& { (lua "$(Join-Path -Path $HOME -ChildPath .config\dotfiles\cross_platform_modules\z.lua\z.lua)" --init powershell) -join "`n" })
