if (!$IsMacOS || ! $PWD -eq "$HOME/.config/dotfiles" ) {
    Write-Error "This install script is MacOS only, and has hardcoded the installation path for now."
    exit
}
mkdir ../../powershell && ln -sv ../dotfiles/Microsoft.PowerShell_profile.ps1 ../../powershell
ln -sv dotfiles/starship.toml ../..

echo '. $HOME/.config/dotfiles/init.sh' >> ~/.zshrc
echo '. $HOME/.config/dotfiles/init.sh' >> ~/.bashrc
