function set_win_title(){
    echo -ne "\033]0; $(whoami)@$(hostname):$(basename $PWD) \007"
}

if [ -n "$ZSH_VERSION" ]; then
    __SHELL_NAME="zsh" 
    precmd_functions+=(set_win_title)
elif [ -n "$BASH_VERSION" ]; then
    __SHELL_NAME="bash"
    starship_precmd_user_func="set_win_title"
else
    echo "it is other shell, will not use init.sh."
    exit
fi

eval "$(starship init $__SHELL_NAME)"
# z.lua will be added AFTER starship
eval "$(lua $HOME/.config/dotfiles/cross_platform_modules/z.lua/z.lua --init $__SHELL_NAME)"
unset __SHELL_NAME
