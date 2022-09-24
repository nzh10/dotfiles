if (!$IsWindows || $PSVersionTable.Version -le [System.Version]"6.0") {
    Write-Error "This install script is Windows & Powershell Core only for now."
    exit
}

if (!
    #current role
    (New-Object Security.Principal.WindowsPrincipal(
        [Security.Principal.WindowsIdentity]::GetCurrent()
    #is admin?
    )).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator
    )
) {
    #elevate script and exit current non-elevated runtime
    Start-Process `
        -FilePath 'pwsh' `
        -ArgumentList (
            #flatten to single array
            '-NoExit -ExecutionPolicy Bypass -File', $MyInvocation.MyCommand.Source, $args `
            | %{ $_ }
        ) `
        -Verb RunAs
    exit
}

$profile_name = "Microsoft.PowerShell_profile.ps1"
$link_path = "$env:USERPROFILE/Documents/Powershell/$profile_name"
$starship_path = "$env:USERPROFILE/.config/starship.toml"

Remove-Item $link_path,$starship_path
New-Item -ItemType SymbolicLink -Target "$(Split-Path -Path $MyInvocation.MyCommand.Source)/$profile_name" -Path $link_path
New-Item -ItemType SymbolicLink -Target "$(Split-Path -Path $MyInvocation.MyCommand.Source)/starship.toml" -Path $starship_path

