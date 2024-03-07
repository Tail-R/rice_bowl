source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $HOME/.cargo/env

export PATH=$PATH:$HOME/.local/bin

PS1="%B%F{white}%K{black} %2d %k%f :3c %b"

alias xmrg='xrdb merge ~/.Xresources'

alias c='clear'
alias ls='ls --color=auto'
alias l='ls -l --color=auto'
alias la='ls -la --color=auto'

alias v='vim'
alias r='ranger'
alias fet='bunnyfetch'

alias rice='[[ -d ~/.config ]] && cd ~/.config'
alias coffee='[[ -d ~/Documents/workspaces ]] && cd ~/Documents/workspaces'
