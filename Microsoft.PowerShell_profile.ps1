# useful func for aliases
function Get-LastArgs
{
    $lastHistory = (Get-History -count 1)
    $lastCommand = $lastHistory.CommandLine   
    $errors = [System.Management.Automation.PSParseError[]] @()

    [System.Management.Automation.PsParser]::Tokenize($lastCommand, [ref] $errors) | ? {$_.type -eq "commandargument"} | select -last 1 -expand content    
}

# aliases
function __vi() { nvim $args }
Set-Alias -Name vi -Value __vi
function __ga() { git add $args }
Set-Alias -Name ga -Value __ga
function __gala() { git add --verbose (Get-LastArgs) }
Set-Alias -Name ga.la -Value __gala
function __gst() { git status }
Set-Alias -Name gst -Value __gst
function __em() { emeditor $args }
Set-Alias -Name em -Value __em


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
