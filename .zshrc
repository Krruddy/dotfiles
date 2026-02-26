# ==========================================
# 1. Environment & Path
# ==========================================
export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export EDITOR='nvim' 
export PATH=~/.npm-global/bin:$PATH # Custom NPM Global Path so that I don't need sudo for global installs
export PRINTER='Canon_G3520'
#export GEMINI_API_KEY="AIzaSyANY6TlMrRbHELKanhcGxgBfMrztw80ptc"
#export AVANTE_GEMINI_API_KEY="AIzaSyC4hMVyMlT5osTwwhA1MI2pqX0xabaGwRg"
#export AVANTE_DEEPSEEK_API_KEY="sk-c6dfa20e6eae4c7689387bb0325e4a97"

#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk
#export PATH=$JAVA_HOME/bin:$PATH
#export HADOOP_HOME=/home/ruddy/workspace/hadoop-2.7.1
#export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
#export SPARK_HOME=/home/ruddy/workspace/spark-2.4.3-bin-hadoop2.7
#export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# ==========================================
# 2. Oh My Zsh Config
# ==========================================
# Starship will likely take over the prompt, but we keep this as fallback
ZSH_THEME="robbyrussell" 

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  archlinux
  sudo
)

# ==========================================
# 3. Tool Initialization
# ==========================================

# Oh My Zsh
source $ZSH/oh-my-zsh.sh
#
# Zoxide (Better cd)
eval "$(zoxide init zsh --cmd cd)"

# FZF (Fuzzy Finder)
source <(fzf --zsh)

# Starship (Prompt)
export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# Fastfetch (System Info)
fastfetch

# OCaml
eval $(opam env)

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

# Waydroid Stop Function
wdkill() {
    echo "Stopping Waydroid Session..."
    waydroid session stop
    echo "Stopping Waydroid Container..."
    sudo systemctl stop waydroid-container
    echo "Waydroid fully stopped."
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/bin/vault vault
