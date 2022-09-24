if [ -n "$ZSH_VERSION" ]; then
    __SHELL_NAME="zsh" 
    eval "$(starship init zsh)" 
elif [ -n "$BASH_VERSION" ]; then
    __SHELL_NAME="bash"
else
    echo "it is other shell, will not use init.sh."
fi

eval "$(starship init $__SHELL_NAME)"
# z.lua will be added AFTER starship
eval "$(lua $HOME/.config/dotfiles/cross_platform_modules/z.lua/z.lua --init $__SHELL_NAME)"
unset __SHELL_NAME
