# 
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#prompt look
PS1="\033[0;32m \n$ "

# alias
alias c='clear'
alias v='vim'
alias r='ranger'

alias startw='Hyprland'
alias xmrg='xrdb merge ~/.Xresources'

alias pkgs='pacman -Q | wc -l'
alias lspkg='pacman -Q'

alias ls='ls --color=auto'
alias l='ls -l --color=auto'
alias la='ls -la --color=auto'
alias l1='ls -1 --color=auto'

alias grep='grep --color=auto'

alias rice='cd $HOME/.config'
alias coffee='cd $HOME/Documents/workspaces'

alias fet='neofetch'

# rust short cut
alias cr="cargo run"
alias mrs="vim main.rs"
alias ccandy="cd $HOME/Documents/workspaces/rust/cotton_candy/src"

# keybinds
bind '"\C-k": history-search-backward'
bind '"\C-j": history-search-forward'

# setup
. "$HOME/.cargo/env"
