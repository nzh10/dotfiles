# aliases
Set-Alias -Name vi -Value vim

# env settings
$MaximumHistoryCount = 32767

# set title via starship
function Get-PathTitle {
    if("$PWD" -eq "$HOME") {
    	return "~"
    } else {
    	return Split-Path -Leaf $PWD
    }
}

function Invoke-Starship-PreCommand {
    $host.UI.RawUI.WindowTitle = "$(Get-PathTitle):$([System.Environment]::UserName)@$([System.Net.Dns]::GetHostName())"
}

# auto-suggestion and bash-like auto-completion
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
## git auto-completion
Import-Module posh-git
$GitPromptSettings.EnablePromptStatus = $false

# env-specified settings
if($IsMacOS) {
    $(/opt/homebrew/bin/brew shellenv) | Invoke-Expression
}

# environment configuration
Invoke-Expression (&starship init powershell)

# last execution
Invoke-Expression (& { (lua "$(Join-Path -Path $HOME -ChildPath .config\dotfiles\cross_platform_modules\z.lua\z.lua)" --init powershell) -join "`n" })
