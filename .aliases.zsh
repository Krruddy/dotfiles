# commands

_='sudo '
alias alias_mod='nv ~/.oh-my-zsh/custom/aliases.zsh'

#alias z='cd'
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt="ls --tree"
alias f="fzf --preview 'bat --color=always {}' --preview-window '~3'"
alias grep='grep --color=auto'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

alias update="sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y"
alias sz="source $ZSHELL_CONFIG/zshrc"

# apps

alias open="xdg-open"
alias minecraft="java -jar /usr/local/SKlauncher-3.2.12.jar"
alias gnatstudio="/home/ruddy/Software/GNAT_Studio-x86_64.AppImage"
alias nv="nvim"
alias n="nv"
alias b="bat"
alias n7="cd ~/Documents/ENSEEIHT/; nv"
alias nvp="cd ~/.config/nvim/lua/plugins/ && nvim"
alias hypreboot="hyprshutdown -t 'Restarting...' --post-cmd 'reboot'"
alias hyprshutdown-now="hyprshutdown -t 'Restarting...' --post-cmd 'shutdown now'"
