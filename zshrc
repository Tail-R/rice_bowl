source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.cargo/env

export EDITOR=vim
export PATH=$PATH:$HOME/.local/bin

# prompt
if [ $TERM != "linux" ]; then
    eval "$(starship init zsh)"
else
    PS1="%5~ %# "
fi

# aliases
alias c='clear'
alias ls='ls --color=auto'
alias l='ls -l --color=auto'
alias la='ls -la --color=auto'

alias v='vim'
alias r='yazi'
alias xmrg='xrdb merge ~/.Xresources'

alias rice='[[ -d ~/.config ]] && cd ~/.config'
alias coffee='[[ -d ~/Documents/workspaces ]] && cd ~/Documents/workspaces'
