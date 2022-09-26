# set title via starship
function Invoke-Starship-PreCommand {
    $host.UI.RawUI.WindowTitle = "$([System.Environment]::UserName)@$(hostname):$(Split-Path -Leaf $PWD)"
}

# auto-suggestion and bash-like auto-completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History

# env-specified settings
if($IsMacOS) {
    $(/opt/homebrew/bin/brew shellenv) | Invoke-Expression
}

# environment configuration
Invoke-Expression (&starship init powershell)

# last execution
Invoke-Expression (& { (lua "$(Join-Path -Path $HOME -ChildPath .config\dotfiles\cross_platform_modules\z.lua\z.lua)" --init powershell) -join "`n" })
