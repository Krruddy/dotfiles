# ==========================================
# 1. Environment & Path
# ==========================================
export ZSH="$HOME/.oh-my-zsh"
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export XDG_CONFIG_HOME="$HOME/.config"
export LANG=en_US.UTF-8
export EDITOR='nvim' 
export ALIAS_PATH="$HOME/.aliases.zsh"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
export GPG_TTY=$(tty)
export PRINTER='Canon_G3520'
export STARSHIP_CONFIG=~/.config/starship/starship.toml
#export MANPAGER="env NVIM_MAN=1 nvim +Man!"


# ==========================================
# 2. Oh My Zsh Config
# ==========================================
# Starship will likely take over the prompt, but we keep this as fallback
#ZSH_THEME="robbyrussell" 
#
plugins=(
#  vi-mode # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
#  git # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git ; I never use the aliases
  zsh-syntax-highlighting # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zsh-syntax-highlighting
  zsh-autosuggestions # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zsh-autosuggestions
  archlinux # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/archlinux
  zoxide # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/zoxide
  fzf # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
  kitty # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/kitty
#  ssh # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/ssh ; Not needed for now
#  sudo # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo ; Miss type
#  gh # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/gh ; Works without it on Arch
) 

# ==========================================
# 3. Tool Initialization
# ==========================================

# Aliases
source $ALIAS_PATH

# Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Starship (Prompt)
eval "$(starship init zsh)"

eval "$(pass-cli completions zsh)"

# OCaml
#eval $(opam env)

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
## #
## ## FNM (Fast Node Manager)
## #FNM_PATH="/home/ruddy/.local/share/fnm"
## ## fnm
## #if [ -d "$FNM_PATH" ]; then
## #  export PATH="$FNM_PATH:$PATH"
## #  eval "`fnm env`"
## #fi
## #eval "$(fnm env --use-on-cd --shell zsh)"
## 
## # FNM (Fast Node Manager)
## # 1. Add to PATH (Only needed if you didn't install via Pacman)
## if [ -d "$HOME/.local/share/fnm" ]; then
##   export PATH="$HOME/.local/share/fnm:$PATH"
## fi
## 
## # 2. Initialize (Just once, with the cd hook)
## eval "$(fnm env --use-on-cd --shell zsh)"

# Gnome Keyring (Currently Disabled)
# if ! pgrep -x -f gnome-keyring-daemon >/dev/null; then
#   eval "$(gnome-keyring-daemon --start --components=secrets,ssh)"
#   export SSH_AUTH_SOCK
# fi

# ==========================================
# 4. Custom Functions & Aliases
# ==========================================
# Yazi (File Manager with CD support)
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/vault vault
export LIBVIRT_DEFAULT_URI="qemu:///system"
fgd() {
    fzf --bind "start:reload:git status --short | grep '^ M' | cut -d' ' -f 3" \
        --preview 'git diff --color {}' \
        --multi \
        --bind 'enter:become:git add {+}'
}



# ==========================================
# 5. Fastfetch (System Info)
# ==========================================

fastfetch
