function set_win_title(){
    echo -ne "\033]0; $(whoami)@$(hostname):$(basename $PWD) \007"
}

if [ -n "$ZSH_VERSION" ]; then
    __SHELL_NAME="zsh" 
    precmd_functions+=(set_win_title)
    
    ## history file settings
    export HISTFILESIZE=1048576
    export HISTSIZE=1048576
    setopt INC_APPEND_HISTORY

    export HISTTIMEFORMAT="[%F %T] "
    setopt EXTENDED_HISTORY

    setopt HIST_FIND_NO_DUPS
    setopt HIST_IGNORE_ALL_DUPS
elif [ -n "$BASH_VERSION" ]; then
    __SHELL_NAME="bash"
    starship_precmd_user_func="set_win_title"
    # we will not set any other functions here,
    # because when we use bash we often only want
    # a clean and quiet environment.
else
    echo "it is other shell, will not use init.sh."
    exit
fi

eval "$(starship init $__SHELL_NAME)"
# z.lua will be added AFTER starship
eval "$(lua $HOME/.config/dotfiles/cross_platform_modules/z.lua/z.lua --init $__SHELL_NAME)"
unset __SHELL_NAME

# remove duplicate PATH
if [[ -x /usr/bin/awk ]]; then export PATH="$(echo "$PATH" | /usr/bin/awk 'BEGIN { RS=":"; } { sub(sprintf("%c$", 10), ""); if (A[$0]) {} else { A[$0]=1; printf(((NR==1) ?"" : ":") $0) }}')" ; fi

alias quotify="$HOME/.config/dotfiles/scripts/quotify.pl"
alias choose_lang='pwsh -noprofile -command '\''Get-Random -InputObject @("Python", "Rust", "C#", "C++", "Java")'\'''
